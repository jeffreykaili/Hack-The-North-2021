import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/onboarding/google_signin.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_widget/delayed_widget.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height * 0.85),
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('assets/crown.png'),
                  ),
                ),
                SizedBox(height: 20),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome to',
                      speed: Duration(milliseconds: 160),
                      textStyle: GoogleFonts.poppins(
                          fontSize: 40,
                          color: purple,
                          fontWeight: FontWeight.w600),
                      cursor: '',
                    ),
                  ],
                ),
                DelayedWidget(
                  delayDuration: Duration(milliseconds: 1000),
                  child: Text(
                    'Exer',
                    style: GoogleFonts.poppins(
                        fontSize: 90,
                        color: purple,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 40),
                DelayedWidget(
                  delayDuration: Duration(milliseconds: 1400),
                  animationDuration: Duration(milliseconds: 500),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1000),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Login(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return child;
                          }));
                    },
                    child: Text("click to continue",
                        style: GoogleFonts.nunitoSans(
                          color: purple,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
