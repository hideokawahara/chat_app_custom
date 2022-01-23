//Packages
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

//Services
import 'package:chatify_app/services/media_service.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/cloud_storage_service.dart';

//Widgets
import 'package:chatify_app/widgets/custom_input_fields.dart';
import 'package:chatify_app/widgets/rounded_button.dart';

//Providers
import 'package:chatify_app/providers/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold();
  }
}
