import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';

class StepGetName extends StatefulWidget {
  final LabeledGlobalKey<FormState> nameFormKey;
  final Function updateSignUpDetails;
  final Function registrationDetails;
  final Function proceedToNextStep;

  const StepGetName(
      {Key? key,
      required this.updateSignUpDetails,
      required this.nameFormKey,
      required this.registrationDetails,
      required this.proceedToNextStep})
      : super(key: key);

  @override
  State<StepGetName> createState() => _StepGetNameState();
}

class _StepGetNameState extends State<StepGetName> {
  String fullName = '';
  String fullNameErrorMSG = '';
  String gender = '';

  @override
  void initState() {
    super.initState();

    Map<String, String> signUpDetails = widget.registrationDetails();
    if (mounted) {
      setState(() {
        fullName = signUpDetails['member_name']!;
        gender = signUpDetails['member_gender']!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.nameFormKey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border.all(width: 1.0, color: const Color(0xFFF5F7FA)),
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
                initialValue: fullName,
                validator: _validateName,
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
                  hintText: "full name",
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
            ),
            if (fullNameErrorMSG != '')
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                width: double.infinity,
                child: Text(
                  "\t\t\t\t$fullNameErrorMSG",
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              alignment: Alignment.bottomCenter,
              child: GenderPickerWithImage(
                showOtherGender: false,
                verticalAlignedText: true,
                // to show what's selected on app opens, but by default it's Male
                selectedGender: Gender.Male,
                selectedGenderTextStyle: const TextStyle(
                    color: Color(0xfff975c4), fontWeight: FontWeight.bold),
                unSelectedGenderTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
                onChanged: (Gender? gender) {
                  widget.updateSignUpDetails(
                      'member_gender', gender == Gender.Male ? 'M' : 'F');
                  if (kDebugMode) {
                    print(gender);
                  }
                },
                //Alignment between icons
                equallyAligned: true,
                animationDuration: const Duration(milliseconds: 300),
                isCircular: true,
                opacityOfGradient: 0.4,
                padding: const EdgeInsets.all(3),
                size: 50, //default : 40
              ),
            )
          ],
        ));
  }

  void errorMessageSetter(String message) {
    setState(() {
      fullNameErrorMSG = message;
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      errorMessageSetter('you must provide your name');
    } else if (value.length > 20) {
      errorMessageSetter('name cannot contain more than 20 characters');
    } else {
      errorMessageSetter('');
      widget.updateSignUpDetails('member_name', value);
    }
    return null;
  }

  void _validateGender() {}
}
