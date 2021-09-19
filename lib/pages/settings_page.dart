import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/services/provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: Icon(
                Icons.logout_outlined,
                size: 80,
                color: purple,
              ),
            ),
            Text(
              'Logout',
              style: TextStyle(
                  fontSize: 35, color: purple, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
