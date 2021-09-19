import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/onboarding/onboarding_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../services/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> docExists(String docID) async {
  try {
    var doc = await FirebaseFirestore.instance.doc("users/$docID").get();
    return doc.exists;
  } catch (e) {
    return false;
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occured."));
          } else if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser!;
            final uid = user.uid;
            return FutureBuilder(
              future: docExists(uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final exists = snapshot.data;
                  if (exists == false) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .set({
                      "profile_pic": user.photoURL,
                      "name": user.displayName,
                      "wallet_id": null,
                      "step_offset": null,
                      "week_data": {
                        "Monday": 0,
                        "Tuesday": 0,
                        "Wednesday": 0,
                        "Thursday": 0,
                        "Friday": 0,
                        "Saturday": 0,
                        "Sunday": 0,
                      },
                    });
                  }
                  return HomePage();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return LandingPage();
          }
        },
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void login() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    await provider.googleLogin();
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (context, animation, secondaryAnimation) => SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Hero(
                tag: 'logo',
                child: Image.asset('assets/crown.png'),
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                login();
              },
              child: Container(
                width: 300,
                height: 55,
                decoration: BoxDecoration(
                    color: purple,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Center(
                  child: Text(
                    "Sign in with Google",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 150,
            )
          ]),
        ),
      ),
    );
  }
}
