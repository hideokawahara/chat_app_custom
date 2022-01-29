//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Providers
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/providers/chats_page_provider.dart';

//Widgets
import 'package:chatify_app/widgets/top_bar.dart';
import 'package:chatify_app/widgets/custom_list_view_tiles.dart';

//Models
import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/models/chat_message.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late ChatsPageProvider _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(
            _auth,
          ),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (BuildContext _context) {
      _pageProvider = _context.watch<ChatsPageProvider>();
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
              'Chats',
              primaryAction: IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Color.fromRGBO(
                    0,
                    82,
                    218,
                    1.0,
                  ),
                ),
                onPressed: () {
                  _auth.logout();
                },
              ),
            ),
            _chatsList(),
          ],
        ),
      );
    });
  }

  Widget _chatsList() {
    List<Chat>? _chats = _pageProvider.chats;

    return Expanded(
      child: (() {
        if (_chats != null) {
          if (_chats.length != 0) {
            return ListView.builder(
                itemCount: _chats.length,
                itemBuilder: (BuildContext _context, int _index) {
                  return _chatTile(
                    _chats[_index],
                  );
                });
          } else {
            return Center(
              child: Text(
                "No Chats Found",
                style: TextStyle(color: Colors.white),
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
      })(),
    );
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recipients = _chat.recipients();
    bool _isActive = _recipients.any((_d) => _d.wasRecentlyActive());
    String _subtitleText = "";
    if (_chat.messages.isNotEmpty) {
      _subtitleText = _chat.messages.first.type != MessageType.TEXT
          ? "画像表示"
          : _chat.messages.first.content;
    }
    return CustomListViewTileWithActivity(
      height: _deviceHeight * 0.10,
      title: _chat.title(),
      subTitle: _subtitleText,
      imagePath: _chat.imageURL(),
      isActive: _isActive,
      isActivity: _chat.activity,
      onTap: () {},
    );
  }
}
