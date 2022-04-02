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
      tabBar: CupertinoTabBar(
        items: _tabItems,
        activeColor: AppColors.white,
        inactiveColor: AppColors.unSelectedGrey,
        backgroundColor: AppColors.mainColorTeal,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(builder: (context) {
          return _pages[index];
        });
      },
    );
  }
}
