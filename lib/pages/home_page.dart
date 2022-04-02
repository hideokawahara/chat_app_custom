//Packages
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//Pages
import 'package:chat_app_custom/pages/chats_page.dart';
import 'package:chat_app_custom/pages/users_page.dart';
import 'package:chat_app_custom/pages/my_settings_page.dart';

//Resources
import 'package:chat_app_custom/resource/app_colors.dart';
import 'package:chat_app_custom/resource/app_strings.dart';

//Widgets
import 'custom_cupertino_tab_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> _tabItems = [
    BottomNavigationBarItem(
      label: AppStrings.navigationTitleChats,
      icon: Icon(
        Icons.chat_bubble_sharp,
      ),
    ),
    BottomNavigationBarItem(
      label: AppStrings.navigationTitleUsers,
      icon: Icon(
        Icons.supervised_user_circle_sharp,
      ),
    ),
    BottomNavigationBarItem(
      label: AppStrings.navigationTitleMySettings,
      icon: Icon(
        Icons.person,
      ),
    ),
  ];

  final List<Widget> _pages = [
    ChatsPage(),
    UsersPage(),
    MySettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return CupertinoTabScaffold(
      tabBar: CustomCupertinoTabBar(
        items: _tabItems,
        activeColor: AppColors.white,
        inactiveColor: AppColors.unSelectedGrey,
        backgroundColor: AppColors.mainColorTeal,
        height: 80,
        labelStyle: TextStyle(
          color: AppColors.unSelectedGrey,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        activeLabelStyle: TextStyle(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(builder: (context) {
          return _pages[index];
        });
      },
    );
  }
}
