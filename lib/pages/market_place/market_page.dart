import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/market_place/market_page_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

Future<int> getWalletBalance() async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final data =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();
  final walletID = data["wallet_id"];
  http.Response response = await http.get(Uri.parse(
      'https://ordinary-gecko-65.loca.lt/fetchcoin?address=$walletID'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body)["balance"];
  } else {
    return -1;
  }
}

Future<void> removeWalletBalance(amount) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final data =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();
  final walletID = data["wallet_id"];
  http.Response response = await http.get(
    Uri.parse(
      "https://ordinary-gecko-65.loca.lt/removecoin?address=$walletID&amount=$amount",
    ),
  );
  if (response == 200) {
    print("REMOVE SUCCESSFUL, NEW BALANCE IS: " +
        jsonDecode(response.body)["balance"].toString());
  }
}

Future<void> addWalletBalance(amount) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final data =
      await FirebaseFirestore.instance.collection("users").doc(uid).get();
  final walletID = data["wallet_id"];
  http.Response response = await http.get(
    Uri.parse(
      "https://ordinary-gecko-65.loca.lt/addcoin?address=$walletID&amount=$amount",
    ),
  );
  if (response == 200) {
    print("ADD SUCCESSFUL, NEW BALANCE IS: " +
        jsonDecode(response.body)["balance"].toString());
  }
}

class _MarketPageState extends State<MarketPage> {
  var _bal = 0;

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
              child: FutureBuilder(
                future: getWalletBalance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _bal = (snapshot.data as int);
                  }
                  return Center(child: Text(_bal.toString()));
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              removeWalletBalance(10);
              setState(() {
                _bal = _bal - 10;
              });
            },
            child: Container(height: 10),
          ),
          ElevatedButton(
            onPressed: () {
              addWalletBalance(10);
              setState(() {
                _bal = _bal + 10;
              });
            },
            child: Container(height: 10),
          ),
        ],
      ),
    );
  }
}
