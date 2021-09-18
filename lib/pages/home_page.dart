import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/pages/dashboard/dashboard.dart';
import 'package:flutter_application_1/pages/leaderboard/leaderboard_page.dart';
import 'package:flutter_application_1/pages/shop/shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;
  bool changedColour = false;

  int _currentIndex = 2;

  late PageController _pageController = PageController(initialPage: 2);

  @override
  void initState() {
    super.initState();

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          ShopPage(),
          Dashboard(),
          LeaderboardPage(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: bottomNavBarIconSelectedColor,
            unselectedItemColor: bottomNavBarIconUnselectedColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bottomNavBarColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  size: 25,
                ),
                title: SizedBox.shrink(),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                    size: 30,
                  ),
                  title: SizedBox.shrink()),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.leaderboard_rounded,
                    size: 30,
                  ),
                  title: SizedBox.shrink()),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.jumpToPage(
                index,
              );
            }),
      ),
    );
  }
}
