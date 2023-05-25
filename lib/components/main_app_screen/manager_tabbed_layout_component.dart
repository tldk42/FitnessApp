import 'package:fitness_app/db/user_data_storage.dart';
import 'package:fitness_app/screens/login_screen.dart';
import 'package:fitness_app/screens/manager_class_member.dart';
import 'package:fitness_app/screens/manager_class_screen.dart';
import 'package:fitness_app/screens/manager_home_screen.dart';
import 'package:flutter/material.dart';

import '../../db/login_info_storage.dart';

class ManagerTabbedLayoutComponent extends StatefulWidget {
  final Map<String, dynamic> managerData;

  const ManagerTabbedLayoutComponent({Key? key, required this.managerData})
      : super(key: key);

  @override
  State<ManagerTabbedLayoutComponent> createState() =>
      _ManagerTabbedLayoutState();
}

class _ManagerTabbedLayoutState extends State<ManagerTabbedLayoutComponent> {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'Members'),
    Tab(text: 'Classes'),
  ];

  Future<bool> _deleteLoggedInUserData() async {
    List<bool> deletionStatus = await Future.wait(
        [LoginInfoStorage().deleteFile(), UserDataStorage().deleteFile()]);
    return deletionStatus.first && deletionStatus.last;
  }

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manager Mode", style: TextStyle(color: Color(0xfff975c4))),
        backgroundColor: Color(0xFF393239),
        actions: [
          ElevatedButton(
              onPressed: () async {
                bool logOutStatus = await _deleteLoggedInUserData();
                if (logOutStatus) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                }
              },
              child: Text('Logout', style: TextStyle(color: Colors.white70)),
              style: buttonStyle)
        ],
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          body: TabBarView(
            children: [
              ManagerClassUserScreen(
                managerData: widget.managerData,
              ),
              ManagerClassScreen(managerData: widget.managerData),
              // ManagerClassUserScreen(),
            ],
          ),
          bottomNavigationBar: TabBar(
            labelColor: Color(0xfff975c4),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
