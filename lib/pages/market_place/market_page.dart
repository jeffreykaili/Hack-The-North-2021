import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/market_place/market_page_app_bar.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: marketAppBar(),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            elevation: 2,
            child: Container(
              height: 200,
            ),
          )
        ],
      ),
    );
  }
}
