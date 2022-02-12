//Packages
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Services
import 'package:chat_app_custom/services/database_service.dart';
import 'package:chat_app_custom/services/navigation_service.dart';

//Models
import 'package:chat_app_custom/models/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;

  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();

    // _auth.signOut();

    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        _databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then(
          (_snapshot) {
            Map<String, dynamic> _userData =
                _snapshot.data()! as Map<String, dynamic>;
            user = ChatUser.fromJSON(
              {
                "uid": _user.uid,
                "name": _userData["name"],
                "email": _userData["email"],
                "last_active": _userData["last_active"],
                "image": _userData["image"],
              },
            );
            _navigationService.removeAndNavigateToRoute('/home');
          },
        );
      } else {
        _navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }

  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      print(_auth.currentUser);
    } on FirebaseAuthException {
      print("Error logging user into Firebase");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return _credentials.user!.uid;
    } on FirebaseAuthException {
      print("Error registering user");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> update({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _auth.currentUser!.updateDisplayName(name);
      AuthCredential _credential = EmailAuthProvider.credential(
          email: _auth.currentUser!.email!, password: password);
      UserCredential? result =
          await _auth.currentUser?.reauthenticateWithCredential(_credential);
      if (result != null) {
        await _auth.currentUser!.updateEmail(email);
      }
      return _auth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      print("Error update user, ${e.code}");
    } catch (e) {
      print(e);
    }
  }

  Future<void> setChatUser() async {
    DocumentSnapshot _dbUser =
        await _databaseService.getUser(_auth.currentUser!.uid);
    Map<String, dynamic> _userData = _dbUser.data()! as Map<String, dynamic>;
    user = ChatUser.fromJSON(
      {
        "uid": _auth.currentUser!.uid,
        "name": _userData["name"],
        "email": _userData["email"],
        "last_active": _userData["last_active"],
        "image": _userData["image"],
      },
    );
    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
