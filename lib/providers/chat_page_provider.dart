import 'dart:async';

//Packages
import 'package:chatify_app/services/media_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

//Services
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/cloud_storage_service.dart';
import 'package:chatify_app/services/navigation_service.dart';

//Providers
import 'package:chatify_app/providers/authentication_provider.dart';

//Models
import 'package:chatify_app/models/chat_message.dart';

class ChatPageProvider extends ChangeNotifier {
  late DatabaseService _db;
  late CloudStorageService _storage;
  late MediaService _media;
  late NavigationService _navigation;

  AuthenticationProvider _auth;
  ScrollController _messagesListViewController;

  String _chatID;
  List<ChatMessage>? messages;

  late StreamSubscription _messagesStream;

  String? _message;

  String get message {
    return message;
  }

  ChatPageProvider(this._chatID, this._auth, this._messagesListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
    listenToMessages();
  }

  @override
  void dispose() {
    _messagesStream.cancel();
    super.dispose();
  }

  void listenToMessages() {
    try {
      _messagesStream = _db.streamMessagesForChat(_chatID).listen((_snapshot) {
        List<ChatMessage> _messages = _snapshot.docs.map(
          (_m) {
            Map<String, dynamic> _messageData =
                _m.data() as Map<String, dynamic>;
            return ChatMessage.fromJSON(_messageData);
          },
        ).toList();
        messages = _messages;
        notifyListeners();
      });
    } catch (e) {
      print("Error getting Messages");
      print(e);
    }
  }

  void goBack() {
    _navigation.goBack();
  }
}
