//Packages
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Widgets
import 'package:chatify_app/widgets/rounded_image.dart';

//Models
import 'package:chatify_app/models/chat_message.dart';
import 'package:chatify_app/models/chat_user.dart';

class CustomListViewTileWithActivity extends StatelessWidget {
  final double height;
  final String title;
  final String subTitle;
  final String imagePath;
  final bool isActive;
  final bool isActivity;
  final Function onTap;

  CustomListViewTileWithActivity({
    required this.height,
    required this.title,
    required this.subTitle,
    required this.imagePath,
    required this.isActive,
    required this.isActivity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      leading: RoundedImageNetworkWithStatusIndicator(
        key: UniqueKey(),
        size: height / 2,
        imagePath: imagePath,
        isActive: isActive,
      ),
      minVerticalPadding: height * 0.20,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: isActivity
          ? Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitThreeBounce(
                  color: Colors.white54,
                  size: height * 0.10,
                ),
              ],
            )
          : Text(
              subTitle,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
    );
  }
}