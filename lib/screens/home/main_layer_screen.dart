import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:evently_application/network/auth_service.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:evently_application/screens/home/home_tab/home_tab.dart';
import 'package:evently_application/screens/home/settings_tab/settings_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';
import '../events/new_event/new_event_screen.dart';
import 'fav_tab/favorite_tab.dart';

class MainLayerScreen extends StatefulWidget {
  const MainLayerScreen({super.key});

  static const String routName = '/mainLayer';

  @override
  State<MainLayerScreen> createState() => _MainLayerScreenState();
}

class _MainLayerScreenState extends State<MainLayerScreen> {
  int currentIndex = 0;
  bool isLoading = true;

  List<Widget> tabs = [
    HomeTab(),
    Container(color: Colors.red),
    FavoriteTab(),
    SettingsTab(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeUser();
  }

  initializeUser() async {
    UserModel userModel = (await AuthService.getUSerInfo())!;
    Provider.of<UserProvider>(context, listen: false).userModel = userModel;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : tabs[currentIndex],
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
