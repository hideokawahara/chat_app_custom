//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Providers
import 'package:chat_app_custom/providers/authentication_provider.dart';
import 'package:chat_app_custom/providers/chats_page_provider.dart';

//Resource
import 'package:chat_app_custom/resource/app_colors.dart';
import 'package:chat_app_custom/resource/app_strings.dart';
import 'package:chat_app_custom/resource/app_styles.dart';

//Services
import 'package:chat_app_custom/services/navigation_service.dart';

//Pages
import 'package:chat_app_custom/pages/chat_page.dart';

//Widgets
import 'package:chat_app_custom/widgets/top_bar.dart';
import 'package:chat_app_custom/widgets/custom_list_view_tiles.dart';

//Models
import 'package:chat_app_custom/models/chat.dart';
import 'package:chat_app_custom/models/chat_user.dart';
import 'package:chat_app_custom/models/chat_message.dart';

class ChatsPage extends StatefulWidget {
  final ScrollController _controller = ScrollController();

  @override
  _ChatsPageState createState() => _ChatsPageState();

  void scrollToTop() {
    _controller.animateTo(
      0,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );
  }
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late NavigationService _navigation;
  late ChatsPageProvider _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();

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
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColorTeal,
          title: Text(
            AppStrings.chatsPageTitle,
            style: AppStyles.appBarTitleStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                _auth.logout();
              },
              icon: Icon(
                Icons.logout,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        body: Container(
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
              _chatsList(),
            ],
          ),
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
                controller: widget._controller,
                itemCount: _chats.length,
                itemBuilder: (BuildContext _context, int _index) {
                  return _chatTile(
                    _chats[_index],
                  );
                });
          } else {
            return Center(
              child: Text(
                AppStrings.emptyChatsText,
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          );
        }
      })(),
    );
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recipients = _chat.recipients();
    bool _isActive = _recipients.any((_d) => _d.wasRecentlyActive());
    String _subtitleText = AppStrings.isEmptyText;
    if (_chat.messages.isNotEmpty) {
      _subtitleText = _chat.messages.first.type != MessageType.TEXT
          ? AppStrings.imageSentText
          : _chat.messages.first.content;
    }
    return CustomListViewTileWithActivity(
      height: _deviceHeight * 0.10,
      title: _chat.title(),
      subTitle: _subtitleText,
      imagePath: _chat.imageURL(),
      isActive: _isActive,
      isActivity: _chat.activity,
      onTap: () {
        _navigation.navigateToPage(
          ChatPage(chat: _chat),
        );
      },
    );
  }
}
