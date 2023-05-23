import 'dart:async';
import 'dart:math';
import 'package:fitness_app/providers/live_transactions_provider.dart';
import 'package:fitness_app/providers/tab_navigation_provider.dart';
import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:fitness_app/screens/activity_screen.dart';
import 'package:fitness_app/screens/home_screen.dart';
import 'package:fitness_app/screens/user_screen.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class TabbedLayoutComponent extends StatefulWidget {
  final Map<String, dynamic> userData;

  const TabbedLayoutComponent({Key? key, required this.userData})
      : super(key: key);

  @override
  State<TabbedLayoutComponent> createState() => _TabbedLayoutComponentState();
}

class _TabbedLayoutComponentState extends State<TabbedLayoutComponent> {
  Timer? _updateTimer;
  int _currentTabIndex = 0;
  int totalTransactionRequests = 0;

  final LabeledGlobalKey<HomeScreenState> homeScreenKey =
      LabeledGlobalKey("Home Screen");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _updateTimer = Timer.periodic(
        Duration(minutes: [1, 2, 3, 4][Random().nextInt(4)]), (Timer t) {
      // Provider.of<LiveUpdateProvider>(context, listen: false).update();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _updateTimer!.cancel();
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
      ActivityScreen(
          user: widget.userData, userAuthKey: userAuthKey, setTab: setTab),
      UserInfo(user: widget.userData, userAuthKey: userAuthKey, setTab: setTab),
    ];

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: const Color(0xFF362e36),
        extendBodyBehindAppBar: true,
        bottomNavigationBar: googleNavBar(),
        body: screens.isEmpty
            ? const Text("Loading...")
            : screens[_currentTabIndex],
      ),
    );
  }

  Widget googleNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.18, vertical: 1),
      child: GNav(
        tabBackgroundColor: const Color(0xFF524752),
        hoverColor: const Color(0xFFFF94D4),
        activeColor: const Color(0xFFFF94D4),
        haptic: false,
        gap: 6,
        iconSize: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        duration: const Duration(milliseconds: 300),
        color: const Color(0xFFFF94D4),
        tabs: const [
          GButton(
            icon: LineIcons.home,
            text: 'Home',
          ),
          GButton(
            icon: LineIcons.running,
            text: 'Activity',
          ),
          GButton(
            icon: LineIcons.user,
            text: 'My',
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
