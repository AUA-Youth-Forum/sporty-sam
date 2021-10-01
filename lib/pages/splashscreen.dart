import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sporty_sam/pages/login.dart';
import 'package:sporty_sam/services/auth.dart';
import 'package:sporty_sam/components/functions/firebaseFunctions.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _isScaleCompleted = false;
  bool _initialized = false;
  bool _error = false;

  late final AnimationController _controllerScale = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..forward().whenComplete(() {
      print("Scale Completed");
      setState(() {
        _isScaleCompleted = true;
      });
    });

  late final AnimationController _controllerSlide = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward().whenComplete(() {
      if (isAuthenticated()) {
        print("Authenticated");
        Navigator.pushNamed(context, "/home");
      } else {
        print("Not Authenticated");
        Navigator.pushNamed(context, "/login");
      }
    });
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controllerScale,
    curve: Curves.fastLinearToSlowEaseIn,
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.5),
  ).animate(CurvedAnimation(
    parent: _controllerSlide,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    _controllerScale.dispose();
    _controllerSlide.dispose();
    super.dispose();
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
      print("ready filesync");
      if(isAuthenticated()){
        String? userID = getUser()?.uid;
        fileSync(userID);
      }

    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e);
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    /* Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Login()))); */
    initializeFlutterFire();

  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print("error firebase");
//      return Text("error firebase");
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print("connecting to server firebase");
//      return Text("connecting to server firebase");
    }

    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isScaleCompleted
              ? SlideTransition(
                  position: _offsetAnimation,
                  child: Column(
                    children: [
                      Text(
                        "Sporty Sam",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'PortLligatSans',
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Hero(
                        tag: 'hero',
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48.0,
                            child: Image(
                              image: AssetImage('lib/assets/login-img.png'),
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ScaleTransition(
                  scale: _animation,
                  child: Text(
                    "Sporty Sam",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'PortLligatSans',
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
        ],
      )),
    );
  }
}

/* Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          Text(
            "Keep Moving and Save Sam",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredokaOne(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black
            ),
          ), */