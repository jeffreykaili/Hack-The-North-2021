import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/shop/shop_page_app_bar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: shopAppBar(),
    );
  }
}
