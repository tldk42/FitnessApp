import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String? userAuthKey;
  final Function setTab;

  const HomeScreen(
      {Key? key,
      required this.user,
      required this.userAuthKey,
      required this.setTab})
      : super(key: key);


  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late List<Map<String, dynamic>> response;
  Map<String, dynamic>? error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Actions = [
      // GestureDetector(
      //   onTap: ,
      // )
    ];
    List<Widget> Contents = [
      Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Color(0xFF0070BA),
            color: Color(0xff1546A0),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(36),
            ),
          )),
      Positioned(
          child: Opacity(
            opacity: 0.16,
            child: Image.asset(
              "assets/images/hadwin_system/magicpattern-blob-1652765120695.png",
              color: Colors.white,
              height: 480,
            ),
          ),
          left: -156,
          top: -96),
    ];

    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          actions: Actions,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: Contents,
              ))
        ]));
  }
}
