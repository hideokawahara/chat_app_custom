import 'package:flutter/material.dart';

//Resource
import 'package:chat_app_custom/resource/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obsucureText;

  CustomTextFormField({
    required this.onSaved,
    required this.regEx,
    required this.hintText,
    required this.obsucureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (_value) => onSaved(_value!),
      cursorColor: AppColors.white,
      style: TextStyle(color: AppColors.white),
      obscureText: obsucureText,
      validator: (_value) {
        return RegExp(regEx).hasMatch(_value!) ? null : 'Enter a valid value';
      },
      decoration: InputDecoration(
        fillColor: AppColors.mainColorTeal,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.hintTextGrey),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Function(String) onEditingComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? icon;

  CustomTextField({
    required this.onEditingComplete,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: () => onEditingComplete(controller.value.text),
      cursorColor: AppColors.white,
      style: TextStyle(color: AppColors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: AppColors.mainColorTeal,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.hintTextGrey),
        prefixIcon: Icon(
          icon,
          color: AppColors.hintTextGrey,
        ),
      ),
    );
  }
}
