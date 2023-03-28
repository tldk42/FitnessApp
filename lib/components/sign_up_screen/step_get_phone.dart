import 'package:flutter/material.dart';

class StepGetPhone extends StatefulWidget {
  final LabeledGlobalKey<FormState> phoneFormKey;
  final Function updateSignUpDetails;
  final Function registrationDetails;
  final Function showConfirmSignUpButton;
  final Function finalStepProcessing;

  const StepGetPhone(
      {Key? key,
      required this.updateSignUpDetails,
      required this.phoneFormKey,
      required this.registrationDetails,
      required this.showConfirmSignUpButton,
      required this.finalStepProcessing})
      : super(key: key);

  @override
  State<StepGetPhone> createState() => _StepGetPhoneState();
}

class _StepGetPhoneState extends State<StepGetPhone> {
  String phoneNum = '';
  String phoneNumErrorMSG = '';

  @override
  void initState() {
    super.initState();

    Map<String, String> signUpDetails = widget.registrationDetails();
    if (mounted) {
      setState(() {
        phoneNum = signUpDetails['member_phone']!;
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
        key: widget.phoneFormKey,
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
                initialValue: phoneNum,
                onChanged: _toggleSignUpButtonVisibility,
                validator: _validatePhone,
                autofocus: mounted,
                autocorrect: false,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    widget.finalStepProcessing();
                  }
                },
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "phone number(010XXXXXXXXX)",
                  hintStyle: TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                ),
                style: const TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
              ),
            ),
            if (phoneNumErrorMSG != '')
              Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                child: Text(
                  "\t\t\t\t$phoneNumErrorMSG",
                  style: const TextStyle(fontSize: 10, color: Colors.red),
                ),
              ),
          ],
        ));  }

  void errorMessageSetter(String message) {
    setState(() {
      phoneNumErrorMSG = message;
    });
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      errorMessageSetter('you must provide a valid phone number');
    } else if (value.length > 12) {
      errorMessageSetter('phone number cannot contain more than 12 characters');
    } else {
      errorMessageSetter("");

      setState(() {
        phoneNum = value;
      });
    }
    return null;
  }

  void _toggleSignUpButtonVisibility(String value) {
    widget.updateSignUpDetails('member_phone', value);
    if (value.isNotEmpty) {
      widget.showConfirmSignUpButton(true);
    } else {
      widget.showConfirmSignUpButton(false);
    }
  }
}
