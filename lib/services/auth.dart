import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

Future<String> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user!.uid;
    //print(userCredential.user?.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      throw (0);
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      throw (0);
    }
    print(e);
    throw (-1);
  }
}

Future<String> register(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "name": "New User",
        "email": email,
        "gender": "Male",
        "birthday": DateTime(1980, 1, 1).toString(),
        "country": "LK",
        "myScore": 0
      });
      return userCredential.user!.uid;
    } else {
      throw (-1);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      throw (0);
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      throw (1);
    }
    print(e);
    throw (-1);
  }
}

bool isAuthenticated() {
  User? user = _auth.currentUser;
  if (user != null) {
    return true;
  }
  return false;
}

User? getUser() {
  User? user = _auth.currentUser;
  return user;
}

Future<String> deleteUser() async {
  try {
    await FirebaseAuth.instance.currentUser!.delete();
    return "Deleted";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      print(
          'The user must reauthenticate before this operation can be executed.');
      throw ("Reauthentication required");
    }
  }
  throw ("Deletion error");
}

Future<void> signOut() async {
  await _auth.signOut();
}
