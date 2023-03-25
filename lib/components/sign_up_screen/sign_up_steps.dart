import 'package:fitness_app/components/sign_up_screen/step_get_id_password.dart';
import 'package:fitness_app/components/sign_up_screen/step_get_name.dart';
import 'package:fitness_app/components/sign_up_screen/step_get_phone.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class SignUpSteps extends StatefulWidget {
  const SignUpSteps({Key? key}) : super(key: key);

  @override
  State<SignUpSteps> createState() => _SignUpStepsState();
}

class _SignUpStepsState extends State<SignUpSteps> {
  late PageController _signUpStepController;
  final nameFormKey = LabeledGlobalKey<FormState>("nameForm");
  final idPasswordFormKey = LabeledGlobalKey<FormState>("idPasswordForm");
  final phoneNumberFormKey = LabeledGlobalKey<FormState>("phoneNumberForm");

  Map<String, String> signUpDetails = {
    'fullname': '',
    'id': '',
    'password': '',
    'phone': ''
  };

  Map<String, String> registrationDetails() => signUpDetails;
  int _currentStep = 0;
  List<bool> stepHasError = [false, false, false];
  List<bool> stepCompletedSuccessfully = [false, false, false];
  late List<Widget> signUpStepContent;
  bool confirmSignUpButton = false;

  @override
  void initState() {
    // TODO: implement initState
    _signUpStepController = PageController();
    signUpStepContent = [
      StepGetName(
        registrationDetails: registrationDetails,
        updateSignUpDetails: updateSignUpDetails,
        nameFormKey: nameFormKey,
        proceedToNextStep: _proceddToNextStep,
      ),
      StepGetIDPassword(
          registrationDetails: registrationDetails,
          updateSignUpDetails: updateSignUpDetails,
          idPasswordFormKey: idPasswordFormKey,
          proceedToNextStep: showConfirmSignUpButton)
      StepGetPhone(
          registrationDetails: registrationDetails,
          updateSignUpDetails: updateSignUpDetails,
          phoneFormKey: phoneNumberFormKey,
          showConfirmSignUpButton: showConfirmSignUpButton,
          finalStepProcessing: _finalStepProcessing)
    ];
    super.initState();
  }

  @override
  void dispose() {
    _signUpStepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2]
                    .map((e) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => changeStepOnTap(e),
                      child: CircleAvatar(
                          backgroundColor: stepHasError[e]
                              ? Colors.red.shade600
                              : !stepCompletedSuccessfully[e]
                              ? Color(0xffF5F7FA)
                              : Colors.green.shade600,
                          foregroundColor: !stepCompletedSuccessfully[e]
                              ? Color(0xFF0070BA)
                              : Colors.white,
                          radius: 18,
                          child: stepHasError[e]
                              ? Icon(
                            FluentIcons.warning_16_filled,
                            color: Colors.white,
                          )
                              : stepCompletedSuccessfully[e]
                              ? Icon(
                              FluentIcons.checkmark_16_regular)
                              : _currentStep == e
                              ? Icon(FluentIcons.edit_16_filled)
                              : Text("${e + 1}")),
                    ),
                    if (e < 2)
                      Container(
                        height: 10,
                        width: 70,
                        color: stepCompletedSuccessfully[e]
                            ? Colors.green.shade600
                            : Colors.transparent,
                      ),
                  ],
                ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: _currentStep == 2 ? 230 : 300,
              child: PageView(
                clipBehavior: Clip.none,
                controller: _signUpStepController,
                physics: NeverScrollableScrollPhysics(),
                children: signUpStepContent,
              ),
            ),
            if(_currentStep==2) Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 3.6, horizontal: 10),
                child: RichText(
                    text: TextSpan(
                        text: 'By signing up you are agreeing to the ',
                        style:
                        TextStyle(fontSize: 14, color: Color(0xFF929BAB)),
                        children: <InlineSpan>[
                          TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(fontSize: 14, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Future.delayed(
                                      Duration(milliseconds: 300),
                                          () => Navigator.push(
                                          context,
                                          SlideRightRoute(
                                              page: HadWinMarkdownViewer(
                                                screenName: "Terms & Conditons",
                                                urlRequested:
                                                'https://raw.githubusercontent.com/brownboycodes/HADWIN/master/docs/TERMS_AND_CONDITIONS.md',
                                              ))));
                                }),
                          TextSpan( text: ' and our ',
                            style:
                            TextStyle(fontSize: 14, color: Color(0xFF929BAB)),),
                          TextSpan(
                              text: 'End User License Agreement',
                              style: TextStyle(fontSize: 14, color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Future.delayed(
                                      Duration(milliseconds: 300),
                                          () => Navigator.push(
                                          context,
                                          SlideRightRoute(
                                              page: HadWinMarkdownViewer(
                                                screenName: "End User License Agreement",
                                                urlRequested:
                                                'https://raw.githubusercontent.com/brownboycodes/HADWIN/master/docs/END_USER_LICENSE_AGREEMENT.md',
                                              ))));
                                })
                        ]))),
            confirmSignUpButton
                ? Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey.shade100,
                      offset: Offset(0, 4),
                      blurRadius: 5.0)
                ],
                gradient: RadialGradient(
                    colors: [Color(0xff0070BA), Color(0xff1546A0)],
                    radius: 8.4,
                    center: Alignment(-0.24, -0.36)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                  onPressed: _finalStepProccessing,
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )),
            )
                : Row(
              children: [
                if (_currentStep > 0 && confirmSignUpButton == false)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                        onPressed: _goBackToPreviousStep,
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 3.2,
                            children: [
                              Icon(
                                FluentIcons.arrow_left_16_filled,
                                color: Colors.blue,
                                size: 18,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16),
                              ),
                            ]),
                        style: TextButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                  ),
                Spacer(),
                if (_currentStep < signUpStepContent.length - 1)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                        onPressed: _proceedToNextStep,
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 3.2,
                            children: [
                              Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16),
                              ),
                              Icon(
                                FluentIcons.arrow_right_16_filled,
                                color: Colors.blue,
                                size: 18,
                              )
                            ]),
                        style: TextButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                  ),
              ],
            ),
          ],
        ));
  }

  void _finalStepProcessing() {
    FocusManager.instance.primaryFocus?.unfocus();
    _performErrorCheck(_currentStep + 1);
  }
}
