import 'package:fitness_app/components/setting_screen/app_setting.dart';
import 'package:flutter/material.dart';

class NewSettingScreen extends StatelessWidget {
  NewSettingScreen({Key? key}) : super(key: key);

  final AppBar appBar = AppBar(
    title: Text('Settings'),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xff243656),
    elevation: 0,
  );

  @override
  Widget build(BuildContext context) {
    Column appSettings = Column(
      children: [
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 180,
            child: AppSettingComponent(),
          ),
        )
      ],
    );
    return Scaffold(
      backgroundColor: Color(0xFFe1dbd7),
      appBar: appBar,
      body: appSettings,
    );
  }
}
