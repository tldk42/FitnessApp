import 'package:fitness_app/components/login_screen/form_component.dart';
import 'package:fitness_app/screens/sign_up_screen.dart';
import 'package:fitness_app/utilities/slide_right_route.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Widget helpInfoBox = SizedBox(
      width: double.infinity,
      height: 36,
      child: Center(
        child: InkWell(
          onTap: getLoginHelp,
          child: const Text(
            'Having trouble logging in?',
            style: TextStyle(fontSize: 14, color: Color(0xfff975c4)),
          ),
        ),
      ),
    );

    Widget signUpBox = SizedBox(
      width: double.infinity,
      height: 36,
      child: Center(
        child: InkWell(
          onTap: goToSignUpScreen,
          child: const Text(
            'Sign up',
            style: TextStyle(fontSize: 14, color: Color(0xfff975c4)),
          ),
        ),
      ),
    );

    List<Widget> loginScreenContents = <Widget>[
      _spacing(64),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Image.asset('images/super_b.png'),
      ),
      _spacing(64),
      LoginFormComponent(),
      _spacing(30),
      helpInfoBox,
      _spacing(10),
      signUpBox
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF393239),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(45),
        child: Column(
          children: loginScreenContents,
        ),
      ),
    );


    // return Scaffold(
    //   backgroundColor: Colors.grey[350],
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         Hero(
    //           tag: 'logo',
    //           child: SizedBox(
    //             height: 200.0,
    //             child: Image.asset('images/fitness_logo.png'),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 48.0,
    //         ),
    //         TextField(
    //           onChanged: (value) {
    //             // TODO: ID 검증
    //           },
    //           decoration: const InputDecoration(
    //             hintText: 'ID를 입력하세요.',
    //             contentPadding:
    //             EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
    //             ),
    //             enabledBorder: OutlineInputBorder(
    //               borderSide:
    //               BorderSide(color: Colors.orangeAccent, width: 1.0),
    //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderSide:
    //               BorderSide(color: Colors.orangeAccent, width: 2.0),
    //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 8.0,
    //         ),
    //         TextField(
    //           onChanged: (value) {
    //             // TODO: PW 검증
    //           },
    //           decoration: const InputDecoration(
    //             hintText: 'PW를 입력하세요.',
    //             contentPadding:
    //             EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
    //             ),
    //             enabledBorder: OutlineInputBorder(
    //               borderSide:
    //               BorderSide(color: Colors.orangeAccent, width: 1.0),
    //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderSide:
    //               BorderSide(color: Colors.orangeAccent, width: 2.0),
    //               borderRadius: BorderRadius.all(Radius.circular(32.0)),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(
    //           height: 24.0,
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 16.0),
    //           child: Material(
    //             color: Colors.orangeAccent,
    //             borderRadius: const BorderRadius.all(Radius.circular(30.0)),
    //             elevation: 5.0,
    //             child: MaterialButton(
    //               onPressed: () {
    //                 // TODO: Implement login functionality.
    //                 // TODO: DB에 회원 정보 등록하고 검증하기.
    //               },
    //               minWidth: 200.0,
    //               height: 42.0,
    //               child: const Text(
    //                 'Log In',
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
  void getLoginHelp() {
    // Navigator.push(
    //   context,
    //   SlideRightRoute(
    //     page:
    //   )
    // )
  }

  void goToSignUpScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

  SizedBox _spacing(double height) =>
      SizedBox(
        height: height,
      );
}
