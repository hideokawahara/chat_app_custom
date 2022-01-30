//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Widgets
import 'package:chatify_app/widgets/top_bar.dart';
import 'package:chatify_app/widgets/custom_list_view_tiles.dart';
import 'package:chatify_app/widgets/custom_input_fields.dart';

//Models
import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/models/chat_message.dart';

//Providers
import 'package:chatify_app/providers/authentication_provider.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;

  ChatPage({
    required this.chat,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;

  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messagesListViewController;

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold();
  }
}
