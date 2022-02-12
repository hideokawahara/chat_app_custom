import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("更新できました"),
        // content: Text("This is the content"),
      );
    },
  );
}

void showFailedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("更新失敗しました"),
        // content: Text("This is the content"),
      );
    },
  );
}
