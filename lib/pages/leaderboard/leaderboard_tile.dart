import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';

class LeaderboardTile extends StatefulWidget {
  final String name;
  final int index;
  final int steps;
  final String imgURL;
  final int prevDay;
  const LeaderboardTile(
      {Key? key,
      required this.name,
      required this.index,
      required this.steps,
      required this.imgURL,
      required this.prevDay})
      : super(key: key);

  @override
  _LeaderboardTileState createState() => _LeaderboardTileState();
}

class _LeaderboardTileState extends State<LeaderboardTile> {
  String toOrd(var num) {
    // num = int.parse(num);
    var digits = [num % 10, num % 100];
    var ordinals = ['st', 'nd', 'rd', 'th'];
    var lst = [1, 2, 3, 4];
    var special = [11, 12, 13, 14, 15, 16, 17, 18, 19];
    if (lst.contains(digits[0]) && !special.contains(digits[1])) {
      return num.toString() + ordinals[digits[0] - 1];
    } else {
      return num.toString() + "th";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
        child: Container(
          height: 95,
          child: Card(
            elevation: 1,
            color: white,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: 40,
                        child: Text(
                          toOrd(widget.index),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 17),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: Image.network(
                            widget.imgURL,
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
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    widget.name,
                                    style: GoogleFonts.poppins(
                                      color: purple,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      height: 1.25,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                        widget.prevDay < widget.steps
                            ? Icons.expand_less_sharp
                            : Icons.expand_more_sharp,
                        color: yellow),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Text(
                        widget.steps.toString(),
                        style: GoogleFonts.poppins(
                          color: leaderboardStepColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
