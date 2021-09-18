import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/pages/leaderboard/leaderboard_app_bar.dart';
import 'package:flutter_application_1/pages/leaderboard/leaderboard_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: leaderboardAppBar(),
      backgroundColor: grey,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            LeaderboardTile(),
            LeaderboardTile(),
            LeaderboardTile(),
          ],
        ),
      ),
    );
  }
}
