import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarketplaceTile extends StatelessWidget {
  final imgURL;
  final company;
  final price;
  final logo;
  MarketplaceTile({
    @required this.imgURL,
    @required this.company,
    @required this.price,
    @required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Card(
            elevation: 4.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FittedBox(
                  child: Opacity(
                    opacity: 0.75,
                    child: Image.network(imgURL),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            child: Container(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: FittedBox(
                  child: Image.network(logo),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 26,
                child: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            primary: Color(0xFF4E47C6),
                          ),
                          child: Text(
                            "Redeem for " + price + " EXE",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              height: 1.2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
