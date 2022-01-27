import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/models/chat_message.dart';

class Chat {
  final String uid;
  final String currentUserUid;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;

  late final List<ChatUser> _recipients;

  Chat({
    required this.uid,
    required this.currentUserUid,
    required this.members,
    required this.messages,
    required this.activity,
    required this.group,
  }) {
    _recipients = members.where((_i) => _i.uid != currentUserUid).toList();
  }

  List<ChatUser> recipients() {
    return _recipients;
  }

  String title() {
    return !group
        ? _recipients.first.name
        : _recipients.map((_user) => _user.name).join(", ");
  }

  String imageURL() {
    return !group
        ? _recipients.first.imageURL
        : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSXwm30uVvhY-yUBRRlUzr6DvMxuYCPdxL3A&usqp=CAU";
  }
}
