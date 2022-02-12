//Packages
import 'package:chat_app_custom/resource/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

//Resources
import 'package:chat_app_custom/resource/app_colors.dart';

//Services
import 'package:chat_app_custom/services/media_service.dart';
import 'package:chat_app_custom/services/database_service.dart';
import 'package:chat_app_custom/services/cloud_storage_service.dart';

//Widgets
import 'package:chat_app_custom/widgets/custom_input_fields.dart';
import 'package:chat_app_custom/widgets/rounded_button.dart';
import 'package:chat_app_custom/widgets/rounded_image.dart';

//Providers
import 'package:chat_app_custom/providers/authentication_provider.dart';

class MySettingsPage extends StatefulWidget {
  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late DatabaseService _db;
  late CloudStorageService _cloudStorage;

  String? _email;
  String? _password;
  String? _name;
  PlatformFile? _profileImage;

  final _updateFormKey = GlobalKey<FormState>();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseService>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColorTeal,
        title: Text("マイページ"),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImageField(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _registerForm(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _updateButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then(
          (_file) {
            setState(
              () {
                _profileImage = _file;
              },
            );
          },
        );
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
            key: UniqueKey(),
            image: _profileImage!,
            size: _deviceHeight * 0.15,
          );
        } else {
          return RoundedImageNetwork(
            key: UniqueKey(),
            imagePath: _auth.user.imageURL,
            size: _deviceHeight * 0.15,
          );
        }
      }(),
    );
  }

  Widget _registerForm() {
    _nameEditingController.text = _auth.user.name;
    _emailEditingController.text = _auth.user.email;
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _updateFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              controller: _nameEditingController,
              onSaved: (_value) {
                setState(() {
                  _name = _value;
                });
              },
              regEx: r".{8,}",
              hintText: "Name",
              obsucureText: false,
            ),
            CustomTextFormField(
              controller: _emailEditingController,
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              hintText: "Email",
              obsucureText: false,
            ),
            // CustomTextFormField(
            //   onSaved: (_value) {
            //     setState(() {
            //       _password = _value;
            //     });
            //   },
            //   regEx: r".{8,}",
            //   hintText: "Password",
            //   obsucureText: true,
            // ),
          ],
        ),
      ),
    );
  }

  Widget _updateButton() {
    return RoundedButton(
      name: AppStrings.updateButton,
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        print("press!");
        if (_updateFormKey.currentState!.validate() && _profileImage != null) {
          print("enter!");
          _updateFormKey.currentState!.save();
          String? _uid = await _auth.update(name: _name!, email: _email!);
          String? _imageURL =
              await _cloudStorage.saveUserImageToStorage(_uid!, _profileImage!);
          await _db.updateUser(_uid, _email!, _name!, _imageURL!);

          // await _auth.logout();
          // _navigation.goBack();
          // await _auth.loginUsingEmailAndPassword(_email!, _password!);
          print("success");
          // setState(() {});
        }
      },
    );
  }
}
