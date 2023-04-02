import 'dart:async';
import 'dart:math';

import 'package:fitness_app/screens/chat_screen.dart';
import 'package:fitness_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabbedLayoutComponent extends StatefulWidget {
  const TabbedLayoutComponent({Key? key}) : super(key: key);

  @override
  State<TabbedLayoutComponent> createState() => _TabbedLayoutComponentState();
}

class _TabbedLayoutComponentState extends State<TabbedLayoutComponent> {
  Timer? _updateTransactionTimer;
  int _currentTabIndex = 0;
  int totalTransactionRequests = 0;

  final labeledGlobalKey<HomeDashboardScreenState> dashboardScreenKey =
  LabeledGlobalKey("Dashboard Screen");
  final labeledGlobalKey<AllTransactionActivitiesState>
  trasactionActivitiesScreenKey =
  LabeledGlobalKey("Transaction Activities Screen");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _updateTransactionTimer = Timer.periodic(
        Duration(minutes: [1, 2, 3, 4][Random().nextInt(4)]), (Timer t) {
      Provider.of<LiveTransactionsProvider>(context, listen: false)
          .updateTransactionRequests();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _updateTransactionTimer!.cancel();
    super.dispose();
  }

  void setTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userAuthKey = Provider
        .of<UserLoginStateProvider>(context)
        .userLoginAuthKey;

    List<Widget> screens = [
      ActivityScreen(
      ),
      ChatScreen(),
    ];
    
    return WillPopScope(child: Scaffold(
        backgroundColor: Color(0xfffefefe),

        extendBodyBehindAppBar: true,

        bottomNavigationBar: googleNavBar(),

        body: screens.isEmpty ? Text("Loading...") : screens[_currentTab], ,
    ), onWillPop: _onBackPress)
  }
}
