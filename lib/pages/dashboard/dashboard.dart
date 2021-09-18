import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/provider.dart';
import 'package:provider/provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  final user = FirebaseAuth.instance.currentUser!;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String _status = 'stopped', _steps = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) async {
    final data =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (data["step_offset"] == null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"step_offset": event.steps});
    }
    print(event);
    setState(() async {
      final day_of_week = DateFormat('EEEE').format(DateTime.now());
      final yesterday =
          DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: 1)));
      _steps = event.steps.toString();
      FirebaseFirestore.instance.collection("users").doc(uid).update({
        "week_data." + day_of_week:
            int.parse(_steps) - data["week_data"][yesterday]
      });
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  final day_of_week = DateFormat('EEEE').format(DateTime.now());
                  final data = (snapshot.data!.data() as Map);
                  final today_steps =
                      data["week_data"][day_of_week] - data["step_offset"];

                  print("HERE: " + day_of_week + " " + today_steps.toString());

                  return Text(
                    today_steps.toString(),
                    style: TextStyle(fontSize: 60),
                  );
                } else
                  return Text(
                    "0",
                    style: TextStyle(fontSize: 60),
                  );
              },
            ),
            Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? TextStyle(fontSize: 30)
                    : TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
