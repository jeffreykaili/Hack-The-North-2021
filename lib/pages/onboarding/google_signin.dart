import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/pages/home_page.dart';
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
            return Login();
          }
        },
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Sign in with Google"),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
        ),
      ),
    );
  }
}
