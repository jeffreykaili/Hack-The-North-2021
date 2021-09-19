import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/pages/leaderboard/leaderboard_app_bar.dart';
import 'package:flutter_application_1/pages/leaderboard/leaderboard_tile.dart';
import 'package:intl/intl.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final day_of_week = DateFormat('EEEE').format(DateTime.now());
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: leaderboardAppBar(),
      backgroundColor: grey,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: db
              .collection("users")
              .orderBy('week_data.$day_of_week', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  dynamic doc = snapshot.data!.docs[index];
                  return LeaderboardTile(
                      name: doc['name'],
                      index: (index + 1),
                      steps: doc['week_data'][day_of_week],
                      imgURL: doc['profile_pic']);
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
