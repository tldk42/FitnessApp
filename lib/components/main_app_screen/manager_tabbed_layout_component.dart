import 'package:fitness_app/screens/manager_class_member.dart';
import 'package:fitness_app/screens/manager_class_screen.dart';
import 'package:fitness_app/screens/manager_home_screen.dart';
import 'package:flutter/material.dart';

class ManagerTabbedLayoutComponent extends StatefulWidget {
  const ManagerTabbedLayoutComponent({Key? key}) : super(key: key);

  @override
  State<ManagerTabbedLayoutComponent> createState() =>
      _ManagerTabbedLayoutState();
}

class _ManagerTabbedLayoutState extends State<ManagerTabbedLayoutComponent> {
  final List<Tab> tabs = <Tab>[
    Tab(text: '회원 정보'),
    Tab(text: '클래스 정보'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: TabBarView(
          children: [
            ManagerHomeScreen(),
            ManagerClassScreen()
            // ManagerClassUserScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.pink,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: tabs,
        ),
      ),
    );
  }
}
