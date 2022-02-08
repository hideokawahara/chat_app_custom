//Packages
import 'package:flutter/material.dart';

//Pages
import 'package:chat_app_custom/pages/chats_page.dart';
import 'package:chat_app_custom/pages/users_page.dart';

//Resources
import 'package:chat_app_custom/resource/app_colors.dart';
import 'package:chat_app_custom/resource/app_strings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    ChatsPage(),
    UsersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.unSelectedGrey,
        currentIndex: _currentPage,
        onTap: (_index) {
          setState(() {
            _currentPage = _index;
          });
        },
        items: [
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
        ],
      ),
    );
  }
}
