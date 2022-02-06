//Package
import 'package:flutter/material.dart';

//Resource
import 'package:chat_app_custom/resource/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onPressed;

  const RoundedButton({
    required this.name,
    required this.height,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.25),
        color: AppColors.mainColorTeal,
      ),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 22,
            color: AppColors.white,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
