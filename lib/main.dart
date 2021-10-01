import 'package:flutter/material.dart';
import 'package:sporty_sam/pages/home.dart';
import 'package:sporty_sam/pages/register.dart';
import 'package:sporty_sam/pages/splashscreen.dart';
import 'pages/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
 /*  bool _initialized = false;
  bool _error = false; */

  // Define an async function to initialize FlutterFire
  /* void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
 */
  @override
  void initState() {
    /* initializeFlutterFire(); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/login': (context) => Login(),
        '/register': (context) => SignUp()
      },
    );
  }
}