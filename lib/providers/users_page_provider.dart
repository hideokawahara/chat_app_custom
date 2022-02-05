//Packages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

//Services
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/navigation_service.dart';

//Providers
import 'package:chatify_app/providers/authentication_provider.dart';

//Models
import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/models/chat.dart';

//Pages
import 'package:chatify_app/pages/chat_page.dart';

class UsersPageProvider extends ChangeNotifier {
  AuthenticationProvider _auth;

  late DatabaseService _database;
  late NavigationService _navigation;

  List<ChatUser>? users;
  late List<ChatUser> _selectedUsers;

  List<ChatUser> get selectedUsers {
    return _selectedUsers;
  }

  UsersPageProvider(this._auth) {
    _selectedUsers = [];
    _database = GetIt.instance.get<DatabaseService>();
    _navigation = GetIt.instance.get<NavigationService>();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
