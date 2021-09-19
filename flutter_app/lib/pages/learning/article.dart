import 'package:flutter/material.dart';
import './article_clicked.dart';
import 'package:google_fonts/google_fonts.dart';

class LearningCard extends StatelessWidget {
  final imgURL;
  final title;
  final difficulty;
  LearningCard({
    @required this.imgURL,
    @required this.title,
    @required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LearningCardClicked(imgURL: imgURL, title: title)),
        );
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              height: 150,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Card(
                elevation: 3,
                color: Color(0xFFecebf3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FittedBox(
                    child: Opacity(
                      opacity: 0.6,
                      child: Image.network(imgURL),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 9),
                  height: 150 - 12,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      title,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "Difficulty: ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: difficulty,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: (difficulty == "Beginner"
                                ? Color(0xFF01814e)
                                : (difficulty == "Intermediate"
                                    ? Color(0xFFEAAA00)
                                    : Color(0xFFAA0114))),
                          ),
                        ),
                      ]),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
