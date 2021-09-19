import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/onboarding/google_signin.dart';
import 'package:flutter_application_1/pages/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      checkFirstSeen();
    });
  }

  void checkFirstSeen() {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1250),
        pageBuilder: (context, animation, secondaryAnimation) => SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(

        // To make Status bar icons color white in Android devices.
        statusBarIconBrightness: Brightness.light,

        // statusBarBrightness is used to set Status bar icon color in iOS.
        statusBarBrightness: Brightness.light
        // Here light means dark color Status bar icons.

        ));

    return Container(
        color: white,
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: Hero(
            tag: 'logo',
            child: Image.asset('assets/crown.png'),
          ),
        )));
  }
}
