import 'dart:async';

//Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Services
import 'package:chat_app_custom/services/database_service.dart';

//Providers
import 'package:chat_app_custom/providers/authentication_provider.dart';

//Models
import 'package:chat_app_custom/models/chat.dart';
import 'package:chat_app_custom/models/chat_message.dart';
import 'package:chat_app_custom/models/chat_user.dart';

class ChatsPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;

  late DatabaseService _db;

  List<Chat>? chats;

  late StreamSubscription _chatsStream;

  ChatsPageProvider(this._auth) {
    _db = GetIt.instance.get<DatabaseService>();
    getChats();
  }

  @override
  void dispose() {
    _chatsStream.cancel();
    super.dispose();
  }

  void getChats() async {
    try {
      _chatsStream =
          _db.getChatsForuser(_auth.user.uid).listen((_snapshot) async {
        chats = await Future.wait(
          _snapshot.docs.map(
            (_d) async {
              Map<String, dynamic> _chatData =
                  _d.data() as Map<String, dynamic>;

              List<ChatUser> _members = [];
              for (var _uid in _chatData["members"]) {
                DocumentSnapshot _userSnapshot = await _db.getUser(_uid);
                Map<String, dynamic> _userData =
                    _userSnapshot.data() as Map<String, dynamic>;
                _userData["uid"] = _userSnapshot.id;
                _members.add(
                  ChatUser.fromJSON(_userData),
                );
              }

              List<ChatMessage> _messages = [];
              QuerySnapshot _chatMessage =
                  await _db.getLastMessageForChat(_d.id);
              if (_chatMessage.docs.isNotEmpty) {
                Map<String, dynamic> _messageData =
                    _chatMessage.docs.first.data()! as Map<String, dynamic>;
                ChatMessage _message = ChatMessage.fromJSON(_messageData);
                _messages.add(_message);
              }

              return Chat(
                uid: _d.id,
                currentUserUid: _auth.user.uid,
                members: _members,
                messages: _messages,
                activity: _chatData["is_activity"],
                group: _chatData["is_group"],
              );
            },
          ).toList(),
        );
        notifyListeners();
      });
    } catch (e) {
      print("Error getting chats");
      print(e);
    }
  }
}
