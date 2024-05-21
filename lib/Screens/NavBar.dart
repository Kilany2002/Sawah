import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:sawah_app/Screens/HomeScreen.dart';
import 'package:sawah_app/generated/l10n.dart';
import 'ProfilePage.dart';
import 'explore.dart';

class MyNevBar extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  MyNevBar({required this.onLocaleChange});

  @override
  _MyNevBarState createState() => _MyNevBarState();
}

class _MyNevBarState extends State<MyNevBar> {
  int currentIndex = 0;

  late List<Widget> listOfColors;

  @override
  void initState() {
    super.initState();
    listOfColors = [
      HomeScreen(),
      ExplorePage(),
      ProfileScreen(onLocaleChange: widget.onLocaleChange),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfColors[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text((S.of(context).home)),
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Color(0xff385f98)),
          BottomNavyBarItem(
              icon: Icon(Icons.explore),
              title: Text((S.of(context).explore)),
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Color(0xff385f98)),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text((S.of(context).profile)),
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Color(0xff385f98)),
        ],
      ),
    );
  }
}
