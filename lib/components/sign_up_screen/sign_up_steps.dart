import 'package:fitness_app/components/sign_up_screen/step_get_id_password.dart';
import 'package:fitness_app/components/sign_up_screen/step_get_name.dart';
import 'package:fitness_app/components/sign_up_screen/step_get_phone.dart';
import 'package:fitness_app/utilities/display_error_alert.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:fitness_app/utilities/slide_right_route.dart';
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
    'member_id': '',
    'member_password': '',
    'member_name': '',
    'member_phone': '',
    'member_gender': ''
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
          proceedToNextStep: _proceedToNextStep),
      StepGetIDPassword(
          registrationDetails: registrationDetails,
          updateSignUpDetails: updateSignUpDetails,
          idPasswordFormKey: idPasswordFormKey,
          proceedToNextStep: _proceedToNextStep),
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
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
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
                                      ? Colors.orange.shade600
                                      : !stepCompletedSuccessfully[e]
                                          ? Colors.white
                                          : const Color(0xfff975c4),
                                  foregroundColor: !stepCompletedSuccessfully[e]
                                      ? const Color(0xfff975c4)
                                      : Colors.white,
                                  radius: 18,
                                  child: stepHasError[e]
                                      ? const Icon(
                                          FluentIcons.warning_16_filled,
                                          color: Colors.white,
                                        )
                                      : stepCompletedSuccessfully[e]
                                          ? const Icon(
                                              FluentIcons.checkmark_16_regular)
                                          : _currentStep == e
                                              ? const Icon(
                                                  FluentIcons.edit_16_filled)
                                              : Text("${e + 1}")),
                            ),
                            if (e < 2)
                              Container(
                                height: 10,
                                width: 70,
                                color: stepCompletedSuccessfully[e]
                                    ? const Color(0xfff975c4)
                                    : Colors.transparent,
                              ),
                          ],
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              height: _currentStep == 2 ? 230 : 300,
              child: PageView(
                clipBehavior: Clip.none,
                controller: _signUpStepController,
                physics: const NeverScrollableScrollPhysics(),
                children: signUpStepContent,
              ),
            ),
            if (_currentStep == 2)
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3.6, horizontal: 10),
                  child: RichText(
                      text: TextSpan(
                          text: 'By signing up you are agreeing to the ',
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFF929BAB)),
                          children: <InlineSpan>[
                        TextSpan(
                            text: 'Terms & Conditions',
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xfff975c4)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                // Future.delayed(
                                //     const Duration(milliseconds: 300),
                                //     () => Navigator.push(
                                //         context,
                                //         SlideRightRoute(
                                //             page: HadWinMarkdownViewer(
                                //           screenName: "Terms & Conditons",
                                //           urlRequested:
                                //               'https://raw.githubusercontent.com/brownboycodes/HADWIN/master/docs/TERMS_AND_CONDITIONS.md',
                                //         ))));
                              }),
                        const TextSpan(
                          text: ' and our ',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF929BAB)),
                        ),
                        TextSpan(
                            text: 'End User License Agreement',
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xfff975c4)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                // Future.delayed(
                                //     const Duration(milliseconds: 300),
                                //     () => Navigator.push(
                                //         context,
                                //         SlideRightRoute(
                                //             page: HadWinMarkdownViewer(
                                //           screenName:
                                //               "End User License Agreement",
                                //           urlRequested:
                                //               'https://raw.githubusercontent.com/brownboycodes/HADWIN/master/docs/END_USER_LICENSE_AGREEMENT.md',
                                //         ))));
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
                            offset: const Offset(0, 4),
                            blurRadius: 5.0)
                      ],
                      gradient: const RadialGradient(
                          colors: [Color(0xff0070BA), Color(0xff1546A0)],
                          radius: 8.4,
                          center: Alignment(-0.24, -0.36)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                        onPressed: _finalStepProcessing,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff975c4),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 3.2,
                                  children: const [
                                    Icon(
                                      FluentIcons.arrow_left_16_filled,
                                      color: Color(0xfff975c4),
                                      size: 18,
                                    ),
                                    Text(
                                      'Back',
                                      style: TextStyle(
                                          color: Color(0xfff975c4),
                                          fontSize: 16),
                                    ),
                                  ])),
                        ),
                      const Spacer(),
                      if (_currentStep < signUpStepContent.length - 1)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                              onPressed: _proceedToNextStep,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 3.2,
                                  children: const [
                                    Text(
                                      'Next',
                                      style: TextStyle(
                                          color: Color(0xfff975c4),
                                          fontSize: 16),
                                    ),
                                    Icon(
                                      FluentIcons.arrow_right_16_filled,
                                      color: Color(0xfff975c4),
                                      size: 18,
                                    )
                                  ])),
                        ),
                    ],
                  ),
          ],
        ));
  }

  void _finalStepProcessing() {
    FocusManager.instance.primaryFocus?.unfocus();
    _performErrorCheck(_currentStep + 1);

    if (stepHasError[_currentStep] == false && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
            const SnackBar(
              content: Text('Processing'),
              backgroundColor: Colors.blue,
            ),
          )
          .closed
          .then((value) => _tryRegistering());
    }
  }

  void _goBackToPreviousStep() {
    FocusManager.instance.primaryFocus?.unfocus();
    _performErrorCheck(_currentStep - 1);
    if (_currentStep > 0) {
      _signUpStepController.animateToPage(_currentStep - 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic);
      setState(() {
        _currentStep--;
      });
    }
  }

  void _proceedToNextStep() {
    FocusManager.instance.primaryFocus?.unfocus();
    _performErrorCheck(_currentStep + 1);
    if (stepHasError[_currentStep] == false) {
      if (_currentStep < signUpStepContent.length - 1) {
        _signUpStepController.animateToPage(_currentStep + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic);
        setState(() {
          _currentStep++;
        });
      }
    }
  }

  void updateSignUpDetails(String key, String value) {
    setState(() {
      signUpDetails[key] = value;
    });
  }

  void showConfirmSignUpButton(bool value) {
    if (value != confirmSignUpButton) {
      setState(() {
        confirmSignUpButton = value;
      });
    }
  }

  void _performErrorCheck(int requestedIndex) {
    if (_currentStep < requestedIndex) {
      for (var i = 0; i < requestedIndex; ++i) {
        bool errorStatus = false;
        switch (i) {
          case 0:
            nameFormKey.currentState?.validate();
            if (signUpDetails['member_name']!.isEmpty) {
              errorStatus = true;
            }
            break;
          case 1:
            idPasswordFormKey.currentState?.validate();
            if (stepCompletedSuccessfully[1]) {
              errorStatus = false;
            } else if (stepCompletedSuccessfully[0] && _currentStep == 1) {
              if (signUpDetails['member_id']!.isEmpty ||
                  signUpDetails['member_password']!.isEmpty) {
                errorStatus = true;
              }
            } else {
              errorStatus = true;
            }
            break;
          case 2:
            phoneNumberFormKey.currentState?.validate();
            if (signUpDetails['member_phone']!.isEmpty) {
              errorStatus = true;
            }
            break;
        }

        setState(() {
          stepHasError[i] = errorStatus;
          stepCompletedSuccessfully[i] = !stepHasError[i];
        });
        if (errorStatus) {
          break;
        }
      }
    } else {
      for (var i = _currentStep; i >= 0; --i) {
        bool errorStatus = false;
        switch (i) {
          case 0:
            nameFormKey.currentState?.validate();
            if (signUpDetails["member_name"]!.isEmpty ||
                signUpDetails["member_gender"]!.isEmpty) {
              errorStatus = true;
            }

            break;
          case 1:
            idPasswordFormKey.currentState?.validate();
            if (stepCompletedSuccessfully[1]) {
              errorStatus = false;
            } else if (stepCompletedSuccessfully[0] && _currentStep == 1) {
              // emailPasswordFormKey.currentState?.validate();
              if (signUpDetails["member_id"]!.isEmpty ||
                  signUpDetails["member_password"]!.isEmpty) {
                errorStatus = true;
              }
            } else {
              errorStatus = true;
            }
            break;
          case 2:
            phoneNumberFormKey.currentState?.validate();
            if (signUpDetails["member_phone"]!.isEmpty) {
              errorStatus = true;
            }

            break;
        }
        setState(() {
          stepHasError[i] = errorStatus;
          stepCompletedSuccessfully[i] = !stepHasError[i];
        });
        if (errorStatus) {
          break;
        }
      }
    }
  }

  void _tryRegistering() {
    // TODO: 서버에 SendData
    sendData(urlPath: 'user/signup.php', data: signUpDetails).then((response) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (response.keys.join().toLowerCase().contains('error')) {
        showErrorAlert(context, response);
      } else {
        //   Navigator.of(context).pushAndRemoveUntil(
        //       MaterialPageRoute(
        //           builder: (context) =>
        //               ChooseUserName(
        //                 userAuthKey: response['authorization_token'],
        //                 userData: response['user'],
        //               )), (route) => false)
        // }
      }
    });
  }

  void changeStepOnTap(int requestedIndex) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (requestedIndex < _currentStep) {
      _signUpStepController.animateToPage(requestedIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic);

      _performErrorCheck(requestedIndex);
      setState(() {
        _currentStep = requestedIndex;
      });
    } else if (requestedIndex > _currentStep) {
      _performErrorCheck(requestedIndex);

      if (!stepHasError.sublist(0, requestedIndex).contains(true)) {
        if (_currentStep < signUpStepContent.length - 1) {
          _signUpStepController.animateToPage(requestedIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic);
          setState(() {
            _currentStep = requestedIndex;
          });
        }
      }
    } else {
      int stepWithError = stepHasError.sublist(0, requestedIndex).indexOf(true);
      _signUpStepController.animateToPage(stepWithError,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic);
      setState(() {
        _currentStep = stepWithError;
      });
    }
  }
}
