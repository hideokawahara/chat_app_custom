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

  final List<GlobalKey<NavigatorState>> _tabNavKeyList =
      List.generate(3, (index) => index)
          .map((_) => GlobalKey<NavigatorState>())
          .toList();

  final CupertinoTabController _controller = CupertinoTabController();

  int _previousIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBar: CustomCupertinoTabBar(
        items: _tabItems,
        activeColor: AppColors.white,
        inactiveColor: AppColors.unSelectedGrey,
        backgroundColor: AppColors.mainColorTeal,
        height: 66,
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
        onTap: (index) => _onTapItem(context, index),
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
            navigatorKey: _tabNavKeyList[index],
            builder: (context) {
              return _pages[index];
            });
      },
    );
  }

  void _onTapItem(BuildContext context, int index) {
    if (index != _previousIndex) {
      _previousIndex = index;
      return;
    }

    if (_tabNavKeyList[_controller.index].currentState != null &&
        !_tabNavKeyList[_controller.index].currentState!.canPop()) {
      if (_pages[index] is ChatsPage) {
        ChatsPage setChatsPage = _pages[index] as ChatsPage;
        setChatsPage.scrollToTop();
      } else if (_pages[index] is UsersPage) {
        UsersPage setUsersPage = _pages[index] as UsersPage;
        setUsersPage.scrollToTop();
      } else if (_pages[index] is MySettingsPage) {
        MySettingsPage setMySettingsPage = _pages[index] as MySettingsPage;
      }
    }

    _tabNavKeyList[_controller.index]
        .currentState
        ?.popUntil((route) => route.isFirst);
  }
}
