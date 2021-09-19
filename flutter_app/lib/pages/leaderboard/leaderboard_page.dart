import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/pages/leaderboard/leaderboard_app_bar.dart';
import 'package:flutter_application_1/pages/leaderboard/leaderboard_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final day_of_week = DateFormat('EEEE').format(DateTime.now());
  final yesterday =
      DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: 1)));
  final db = FirebaseFirestore.instance;
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: leaderboardAppBar(),
        backgroundColor: grey,
        body: StreamBuilder<QuerySnapshot>(
            stream: db
                .collection("users")
                .orderBy('week_data.$day_of_week', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: false,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        dynamic doc = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                          child: Card(
                            elevation: 3,
                            color: purple,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Container(
                              height: 200,
                              width: 399,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(),
                                      child: SizedBox(
                                        height: 120,
                                        width: 120,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image.network(
                                            snapshot.data!.docs[0]
                                                ['profile_pic'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ), // Image of the tile
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/crown.png'))),
                                        ),
                                        Text(
                                          snapshot.data!.docs[0]['name'],
                                          style: GoogleFonts.poppins(
                                              fontSize: 25,
                                              color: white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              doc['week_data'][day_of_week] >
                                                      doc['week_data']
                                                          [yesterday]
                                                  ? Icons.expand_less_sharp
                                                  : Icons.expand_more_sharp,
                                              color: yellow,
                                              size: 30,
                                            ),
                                            Text(
                                              snapshot
                                                  .data!
                                                  .docs[0]
                                                      ['week_data.$day_of_week']
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 36,
                                                  color: yellow,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      dynamic doc = snapshot.data!.docs[index];
                      return LeaderboardTile(
                        name: doc['name'],
                        index: (index + 1),
                        steps: doc['week_data'][day_of_week],
                        imgURL: doc['profile_pic'],
                        prevDay: doc['week_data'][yesterday],
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
