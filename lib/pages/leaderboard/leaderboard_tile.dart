import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';

class LeaderboardTile extends StatefulWidget {
  const LeaderboardTile({Key? key}) : super(key: key);

  @override
  _LeaderboardTileState createState() => _LeaderboardTileState();
}

class _LeaderboardTileState extends State<LeaderboardTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
        child: Container(
          height: 105,
          child: Card(
            elevation: 2,
            color: white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "2.",
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: SizedBox(
                        height: 75,
                        width: 75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(37.5),
                          child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Michael_Jordan_in_2014.jpg/220px-Michael_Jordan_in_2014.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ), // Image of the tile
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Abhinav",
                                  style: GoogleFonts.poppins(
                                    color: purple,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    height: 1.25,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Bala",
                                  style: GoogleFonts.poppins(
                                    color: purple,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    height: 1.25,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        "12032",
                        style: GoogleFonts.poppins(
                          color: leaderboardStepColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
