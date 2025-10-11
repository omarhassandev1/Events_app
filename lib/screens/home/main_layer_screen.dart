import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/screens/home/home_tab/home_tab.dart';
import 'package:evently_application/screens/home/settings_tab/settings_tab.dart';
import 'package:evently_application/screens/new_event/new_event_screen.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'fav_tab/favorite_tab.dart';

class MainLayerScreen extends StatefulWidget {
  const MainLayerScreen({super.key});

  static const String routName = '/mainLayer';

  @override
  State<MainLayerScreen> createState() => _MainLayerScreenState();
}

class _MainLayerScreenState extends State<MainLayerScreen> {
  int currentIndex = 0;

  List<Widget> tabs = [
    HomeTab(),
    Container(color: Colors.red,),
    FavoriteTab(),
    SettingsTab(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap:
              (value) => setState(() {
                currentIndex = value;
              }),
          items: [
            BottomNavigationBarItem(
              icon: Assets.svg.homeOutlined.svg(),
              activeIcon: Assets.svg.homeFilled.svg(),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Assets.svg.locationOutlined.svg(),
              activeIcon: Assets.svg.locationFilledLight.svg(),
              label: 'Location',
            ),
            BottomNavigationBarItem(
              icon: Assets.svg.heartOutlined.svg(),
              activeIcon: Assets.svg.heartFilled.svg(),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Assets.svg.profileOutlined.svg(),
              activeIcon: Assets.svg.profileFilled.svg(),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewEventScreen.routeName);
        },
        shape: CircleBorder(),
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: Icon(Icons.add, color: AppColors.lightBg, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
