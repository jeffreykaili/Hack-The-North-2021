import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import '../../services/provider.dart';
import './line_graph.dart';

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

    setState(() {
      _steps = event.steps.toString();
    });

    final day_of_week = DateFormat('EEEE').format(DateTime.now());
    final yesterday =
        DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: 1)));
    _steps = event.steps.toString();
    FirebaseFirestore.instance.collection("users").doc(uid).update({
      "week_data." + day_of_week: int.parse(_steps) -
          (data["week_data"][yesterday] == 0
              ? data["step_offset"]
              : data["week_data"][yesterday])
    });

    print(event);
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

  Future<DocumentSnapshot> _getDocument() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final FirebaseAuth _user = FirebaseAuth.instance;
    DocumentSnapshot document = await users.doc(_user.currentUser!.uid).get();
    return document;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.88,
                child: Stack(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        var steps = 0;
                        if (snapshot.hasData) {
                          final day_of_week =
                              DateFormat('EEEE').format(DateTime.now());
                          final data = (snapshot.data!.data() as Map);
                          steps = data["week_data"][day_of_week];
                        }
                        var percent_gauge =
                            min(100, max(6, (steps / 10000) * 100));
                        return SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: AxisLineStyle(
                                thickness: 18,
                                color: Color(0xFFecebf3),
                                cornerStyle: CornerStyle.bothCurve,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                  width: 18,
                                  value: percent_gauge.toDouble(),
                                  cornerStyle: CornerStyle.bothCurve,
                                  color: Color(0xFFff5840),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .doc(uid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              final day_of_week =
                                  DateFormat('EEEE').format(DateTime.now());
                              final data = (snapshot.data!.data() as Map);
                              final today_steps =
                                  data["week_data"][day_of_week];
                              print("BROKEN: " +
                                  today_steps.toString() +
                                  " " +
                                  _steps);
                              return Text(
                                today_steps.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 60,
                                ),
                              );
                            } else
                              return Text(
                                "0",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 60,
                                ),
                              );
                          },
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text(
                            "Steps",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<DocumentSnapshot>(
                future: _getDocument(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = (snapshot.data!.data()!
                        as Map<String, dynamic>)["week_data"];

                    return LineChartSample2(data);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Center(
                child: Text(
                  _status,
                  style: _status == 'walking' || _status == 'stopped'
                      ? TextStyle(fontSize: 30)
                      : TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
