import 'package:fitness_app/components/main_app_screen/tabbed_layout_component.dart';
import 'package:fitness_app/db/login_info_storage.dart';
import 'package:fitness_app/db/user_data_storage.dart';
import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:fitness_app/screens/welcome_screen.dart';
import 'package:fitness_app/utilities/display_error_alert.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormComponent extends StatefulWidget {
  const LoginFormComponent({Key? key}) : super(key: key);

  @override
  State<LoginFormComponent> createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends State<LoginFormComponent> {
  LoginInfoStorage loginInfoStorage = LoginInfoStorage();
  final _formKey = GlobalKey<FormState>();
  String errorMSG = "";
  String errorMSG2 = "";
  String userInput = "";
  String password = "";

  void errorMessageSetter(int fieldNumber, String message) {
    setState(() {
      if (fieldNumber == 1) {
        errorMSG = message;
      } else {
        errorMSG2 = message;
      }
    });
  }

  Future<bool> _saveLoggedInUserData(String loggedInUserAuthKey,
      Map<String, dynamic> user) async {
    try {
      final isUserSaved = await Future.wait([
        UserDataStorage().saveUserData(user),
        loginInfoStorage.setPersistentLoginData(
            user['id'].toString(), loggedInUserAuthKey)
      ]);

      if (mounted) {
        Provider.of<UserLoginStateProvider>(context, listen: false)
            .setAuthKeyValue(loggedInUserAuthKey);

        if (isUserSaved[0] && isUserSaved[1]) {
          debugPrint("user data saved");
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void tryLoggingIn() async {
    final dataReceived = await sendData(
        urlPath: 'user/login.php',
        data: {'member_id': userInput, 'member_password': password});
    if (dataReceived['success']) {
      final status = await Future.wait([
        _saveLoggedInUserData('empty', dataReceived['userData'])
      ]);

      if (status[0] == true) {
        ScaffoldMessenger
            .of(context)
            .showSnackBar(SnackBar(
          content: Text("Login Successful"), backgroundColor: Colors.green,))
            .closed
            .then((value) =>
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) =>
                    TabbedLayoutComponent(
                        userData: dataReceived['userData'])), (
                route) => false));
      } else {
        showErrorAlert(context, dataReceived);
      }
    }
  }

    @override
    Widget build(BuildContext context) {
      // return const Placeholder();
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: Colors.pink.shade300),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0.618,
                        offset: Offset(-3, -3),
                        // color: Colors.white38
                        color: Color(0xfff975c4)),
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0.618,
                        offset: Offset(3, 3),
                        color: Color(0xfff975c4))
                    // color: Colors.blueGrey.shade100
                  ]),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    errorMessageSetter(
                        1, 'you must provide a email-id or username');
                  } else {
                    errorMessageSetter(1, "");
                    setState(() {
                      userInput = value;
                    });
                  }
                  return null;
                },
                autocorrect: false,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "id or phone number",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xff393239),
                      fontWeight: FontWeight.w600),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            if (errorMSG != '')
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                child: Text(
                  "\t\t\t\t$errorMSG",
                  style: const TextStyle(fontSize: 10, color: Colors.red),
                ),
              ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0, color: const Color(0xFFF5F7FA)),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      // blurRadius: 6.18,
                        spreadRadius: 0.618,
                        blurRadius: 6.18,
                        // spreadRadius: 6.18,
                        offset: Offset(-3, -3),
                        // color: Colors.white38
                        color: Color(0xfff975c4)),
                    BoxShadow(
                        blurRadius: 6.18,
                        // spreadRadius: 6.18,
                        spreadRadius: 0.618,
                        offset: Offset(3, 3),
                        color: Color(0xfff975c4)),
                    // color: Colors.blueGrey.shade100
                    // color: Color(0xFFF5F7FA)
                  ]),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                // onFieldSubmitted: (value) => _validateLoginDetails(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    errorMessageSetter(2, 'password cannot be empty');
                  } else {
                    errorMessageSetter(2, "");
                    setState(() {
                      password = value;
                    });
                  }
                  return null;
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "password",
                  hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xff393239),
                      fontWeight: FontWeight.w600),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            if (errorMSG2 != '')
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                child: Text(
                  "\t\t\t\t$errorMSG2",
                  style: const TextStyle(fontSize: 10, color: Colors.red),
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.blueGrey.shade100,
                //       offset: const Offset(0, 4),
                //       blurRadius: 5.0)
                // ],
                gradient: const RadialGradient(
                    colors: [Color(0xff1e2428), Colors.black87],
                    radius: 8.4,
                    center: Alignment(-0.24, -0.36)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                  onPressed: _validateLoginDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff)),
                  )),
            ),
          ],
        ),
      );
    }

    void _validateLoginDetails() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (_formKey.currentState!.validate()) {
        if (errorMSG != "" || errorMSG2 != "") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please Provide all required details'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            onVisible: tryLoggingIn,
            content: const Text('Processing...'),
            backgroundColor: Colors.blue,
          ));
        }
      }
    }
  }
