//Packages
import 'package:flutter/material.dart';

//Resources
import 'package:chat_app_custom/resource/app_colors.dart';

class MySettingsPage extends StatelessWidget {
  const MySettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColorTeal,
        title: Text("マイページ"),
      ),
    );
  }
}
