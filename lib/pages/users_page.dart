//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Providers
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/providers/users_page_provider.dart';

//Widgets
import 'package:chatify_app/widgets/top_bar.dart';
import 'package:chatify_app/widgets/custom_input_fields.dart';
import 'package:chatify_app/widgets/custom_list_view_tiles.dart';
import 'package:chatify_app/widgets/rounded_button.dart';

//Models
import 'package:chatify_app/models/chat_user.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late UsersPageProvider _pageProvider;

  final TextEditingController _searchFieldTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
          create: (_) => UsersPageProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (BuildContext _context) {
      _pageProvider = _context.watch<UsersPageProvider>();
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopBar(
              'ユーザー',
              primaryAction: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.logout,
                  color: Color.fromRGBO(
                    0,
                    82,
                    218,
                    1.0,
                  ),
                ),
              ),
            ),
            CustomTextField(
              onEditingComplete: (_value) {},
              hintText: "ユーザーを探す",
              obscureText: false,
              controller: _searchFieldTextEditingController,
              icon: Icons.search,
            ),
            _usersList(),
          ],
        ),
      );
    });
  }

  Widget _usersList() {
    List<ChatUser>? _users = _pageProvider.users;
    return Expanded(child: () {
      if (_users != null) {
        if (_users.length != 0) {
          return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (BuildContext _context, int _index) {
                return CustomListViewTile(
                  height: _deviceHeight * 0.10,
                  title: _users[_index].name,
                  subTitle: "Last Active: ${_users[_index].lastDayActive()}",
                  imagePath: _users[_index].imageURL,
                  isActive: _users[_index].wasRecentlyActive(),
                  isSelected: false,
                  onTap: () {},
                );
              });
        } else {
          return Center(
            child: Text(
              "そんな人はいません",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      }
    }());
  }
}
