import 'package:fitness_app/components/sign_up_screen/sign_up_steps.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: const Color(0xFF362e36),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(45),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: Image.asset('images/pants-logo.png'),
                ),
                const SizedBox(
                  height: 30,
                ),

                SignUpSteps(),
                const SizedBox(
                  height: 27,
                ),

                SizedBox(
                  width: double.infinity,
                  height: 16,
                  child: Center(
                    child: InkWell(
                      child: const Text(
                        'Already have an account? Sign in',
                        style:
                        TextStyle(fontSize: 14, color: Color(0xFF929BAB)),
                      ),
                      onTap: () {

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 3,
                )
              ],
            ),

          ),
        ), onWillPop: () => Future.value(false));
  }
}
