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

  String? _message;

  String get message {
    return message;
  }

  ChatPageProvider(this._chatID, this._auth, this._messagesListViewController) {
    _db = GetIt.instance.get<DatabaseService>();
    _storage = GetIt.instance.get<CloudStorageService>();
    _media = GetIt.instance.get<MediaService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goBack() {
    _navigation.goBack();
  }
}
