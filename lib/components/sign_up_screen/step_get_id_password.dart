import 'package:flutter/material.dart';

class StepGetIDPassword extends StatefulWidget {
  final LabeledGlobalKey<FormState> idPasswordFormKey;
  final Function updateSignUpDetails;

  final Function registrationDetails;
  final Function proceedToNextStep;

  const StepGetIDPassword(
      {Key? key,
      required this.updateSignUpDetails,
      required this.idPasswordFormKey,
      required this.registrationDetails,
      required this.proceedToNextStep})
      : super(key: key);

  @override
  State<StepGetIDPassword> createState() => _StepGetIDPasswordState();
}

class _StepGetIDPasswordState extends State<StepGetIDPassword> {
  String id = '';
  String password = '';
  String idErrorMSG = '';
  String passwordErrorMSG = '';

  @override
  void initState() {
    super.initState();

    Map<String, String> signUpDetails = widget.registrationDetails();
    if (mounted) {
      setState(() {
        id = signUpDetails['id']!;
        password = signUpDetails['password']!;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.idPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: const Color(0xFFF5F7FA)),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                        blurRadius: 6.18,
                        spreadRadius: 0.618,
                        offset: Offset(-4, -4),
                        color: Colors.white38),
                    BoxShadow(
                        blurRadius: 6.18,
                        spreadRadius: 0.618,
                        offset: const Offset(4, 4),
                        color: Colors.blueGrey.shade100)
                  ]),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                initialValue: id,
                validator: _validateID,
                autofocus: mounted,
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
                  hintText: "email address",
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            if (idErrorMSG != '')
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                child: Text(
                  "\t\t\t\t$idErrorMSG",
                  style: const TextStyle(fontSize: 10, color: Colors.red),
                ),
              ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: const Color(0xFFF5F7FA)),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                        blurRadius: 6.18,
                        spreadRadius: 0.618,
                        offset: Offset(-4, -4),
                        color: Colors.white38),
                    BoxShadow(
                        blurRadius: 6.18,
                        spreadRadius: 0.618,
                        offset: const Offset(4, 4),
                        color: Colors.blueGrey.shade100)
                  ]),
              child: TextFormField(
                initialValue: password,
                validator: _validatePassword,
                autofocus: mounted,
                autocorrect: false,
                obscureText: true,
                enableSuggestions: false,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => widget.proceedToNextStep(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "password",
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                ),
              ),
            ),
            if (passwordErrorMSG != '')
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                child: Text(
                  "\t\t\t\t$passwordErrorMSG",
                  style: const TextStyle(fontSize: 10, color: Colors.red),
                ),
              ),
          ],
        ));
  }

  void errorMessageSetter(String fieldName, String message) {
    setState(() {
      switch (fieldName) {
        case 'ID':
          idErrorMSG = message;
          break;
        case 'PASSWORD':
          passwordErrorMSG = message;
          break;
      }
    });
  }

  String? _validateID(String? value) {
    if (value == null || value.isEmpty) {
      errorMessageSetter('ID', 'you must provide a valid id');
    } else {
      errorMessageSetter('ID', "");

      widget.updateSignUpDetails('id', value);
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      errorMessageSetter('PASSWORD', 'password cannot be empty');
    } else {
      errorMessageSetter('PASSWORD', "");

      widget.updateSignUpDetails('password', value);
    }
    return null;
  }
}
