import 'dart:async';
import 'dart:math';
import 'package:fitness_app/providers/tab_navigation_provider.dart';
import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:fitness_app/screens/home_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:fitness_app/screens/chat_screen.dart';
import 'package:fitness_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabbedLayoutComponent extends StatefulWidget {
  final Map<String, dynamic> userData;

  const TabbedLayoutComponent({Key? key, required this.userData})
      : super(key: key);

  @override
  State<TabbedLayoutComponent> createState() => _TabbedLayoutComponentState();
}

class _TabbedLayoutComponentState extends State<TabbedLayoutComponent> {
  // Timer? _updateTransactionTimer;
  int _currentTabIndex = 0;
  int totalTransactionRequests = 0;

  final LabeledGlobalKey<HomeScreenState> homeScreenKey =
      LabeledGlobalKey("Home Screen");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _updateTransactionTimer!.cancel();
    super.dispose();
  }

  void setTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userAuthKey =
        Provider.of<UserLoginStateProvider>(context).userLoginAuthKey;

    List<Widget> screens = [
      HomeScreen(
        user: widget.userData,
        userAuthKey: userAuthKey,
        setTab: setTab,
        key: homeScreenKey,
      ),
      const ChatScreen(),
    ];

    return WillPopScope(
        child: Scaffold(
          backgroundColor: const Color(0xfffefefe),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: googleNavBar(),
          // body: screens.isEmpty
          //     ? const Text("Loading...")
          //     : screens[_currentTabIndex],
          body: screens[0],
        ),
        onWillPop: _onBackPress);
  }

  Widget googleNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.18, vertical: 1),
      child: GNav(
        haptic: false,
        gap: 6,
        activeColor: const Color(0xFF0070BA),
        iconSize: 24,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        duration: const Duration(milliseconds: 300),
        color: const Color(0xFF243656),
        tabs: const [
          GButton(
            icon: FluentIcons.home_32_regular,
            iconSize: 36,
            text: 'Home',
          ),
          GButton(
            icon: FluentIcons.comment_24_regular,
            iconSize: 36,
            text: 'chat',
          )
        ],
        selectedIndex: _currentTabIndex,
        onTabChange: _onTabChange,
      ),
    );
  }

  void _onTabChange(index) {
    if (_currentTabIndex == 0 || _currentTabIndex == 1) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    print("currentTabIndex : {$_currentTabIndex}");
    print("index : {$index}");
    Provider.of<TabNavigationProvider>(context, listen: false)
        .updateTabs(_currentTabIndex);

    setState(() {
      _currentTabIndex = index;
    });
  }

  Future<bool> _onBackPress() {
    if (_currentTabIndex == 0) {
      return Future.value(true);
    }
    int lastTab =
        Provider.of<TabNavigationProvider>(context, listen: false).lastTab;
    Provider.of<TabNavigationProvider>(context, listen: false).removeLastTab();
    setTab(lastTab);
    return Future.value(false);
  }
}
