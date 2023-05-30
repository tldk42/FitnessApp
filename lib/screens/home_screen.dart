import 'dart:convert';
import 'dart:io';

import 'package:fitness_app/components/main_app_screen/tabbed_appbar_component.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  List<Map<String, dynamic>> userClassList = List.empty();

  Map<String, double> userInbodyInfo = {
    'height': 0,
    'weight': 0,
    'fat': 0,
    'muscle': 0
  };

  Future<void> _saveUserInbodyInfo() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/storedInbodyInfo.json');
    await file.writeAsString(jsonEncode(userInbodyInfo));
  }

  Future<void> _loadUserInbodyInfo() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/storedInbodyInfo.json');
      final contents = await file.readAsString();
      print(contents);
      setState(() {
        Map<String, dynamic> decodedContents = jsonDecode(contents);
        userInbodyInfo = decodedContents.map((key, value) => MapEntry(key, value.toDouble()));
      });
    } catch (e) {
      setState(() {
        _initializeUserInbodyInfo();
      });
    }
    print(userInbodyInfo);
  }

  void _initializeUserInbodyInfo() {
    userInbodyInfo = {
      'height': 0,
      'weight': 0,
      'fat': 0,
      'muscle': 0
    };
  }


  Future<String> _fetchAllClasses() async {
    var response = await sendData(
        urlPath: 'user/get_all_classes.php',
        data: {'member_id': widget.user['member_id']});
    setState(() {
      if (response != null) {
        final List<dynamic> list = response;
        userClassList = list.map((e) => e as Map<String, dynamic>).toList();
      } else {
        userClassList = List.empty();
      }
    });
    return 'Loaded';
  }

  @override
  void initState() {
    super.initState();

    _fetchAllClasses();
    _loadUserInbodyInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Actions = [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
        child: IconButton(
          hoverColor: const Color(0xFF524752),
          icon: const Icon(Icons.notifications_none,
              color: Color(0xFFFF94D4), size: 24),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
      )
    ];

    Widget _buildInfoRow(String title, String value) {
      return Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Text(
            value ?? '-',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      );
    }

    Widget _buildTextField(String title, String value) {
      final controller = TextEditingController(text: value);
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFFF94D4),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '$title 입력',
                border: const OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  switch (title) {
                    case 'Height':
                      userInbodyInfo['height'] = double.parse(text);
                      break;
                    case 'Weight':
                      userInbodyInfo['weight'] = double.parse(text);
                      break;
                    case 'Fat':
                      userInbodyInfo['fat'] = double.parse(text);
                      break;
                    case 'Muscle':
                      userInbodyInfo['muscle'] = double.parse(text);
                      break;
                    default:
                  }
                });
              },
            ),
          ],
        ),
      );
    }

    void _showEditDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Edit Profile',
              style: TextStyle(color: Color(0xFFFF94D4), fontSize: 24, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField('Height', '${userInbodyInfo['height']}'),
                  _buildTextField('Weight', '${userInbodyInfo['weight']}'),
                  _buildTextField('Fat', '${userInbodyInfo['fat']}'),
                  _buildTextField('Muscle', '${userInbodyInfo['muscle']}'),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: Text('Exit'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  // 정보 저장 처리

                  _saveUserInbodyInfo();

                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    List<Widget> dashboardContents = [
      SafeArea(
          child: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Text(
                              "Enrolled",
                              style: TextStyle(
                                fontSize: 21,
                                fontFamily: 'Outfit',
                                color: Color(0xFFFF94D4),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              child: const Text("View all",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                              onTap: () {},
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
              userClassList.isEmpty
                  ? Container(
                      width: double.infinity,
                      height: 240,
                      decoration: const BoxDecoration(color: Color(0xFF8b4f73)),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Center(
                          child: Text(
                            'Register for a new activity!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Dancing Script'),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 240,
                      decoration: const BoxDecoration(
                        color: Color(0xFF393239),
                      ),
                      child: ListView.builder(
                        itemCount: userClassList.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return ActivityHomeView(
                              classInfo: userClassList[index]);
                        },
                      ),
                    ),
              const SizedBox(height: 30),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Health Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('Height', '${userInbodyInfo['height']}'),
                      _buildInfoRow('Weight', '${userInbodyInfo['weight']}'),
                      _buildInfoRow('Fat', '${userInbodyInfo['fat']}'),
                      _buildInfoRow('Muscle', '${userInbodyInfo['muscle']}'),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.settings, color: Color(0xFFFF94D4)),
                            onPressed: _showEditDialog,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ))
    ];
    List<Widget> homeScreenContents = <Widget>[
      Stack(
        children: dashboardContents,
      ),
      Container(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF393239),
      appBar: TabbedAppBar(
        title: 'My Activity',
        actions: Actions,
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: homeScreenContents,
          ),
        )
      ]),
    );
  }
}

class ActivityHomeView extends StatelessWidget {
  Map<String, dynamic> classInfo;

  ActivityHomeView({super.key, required this.classInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x44111417),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E3E7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10)),
                              Text(
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  '${classInfo['start_date']}  -  ${classInfo['end_date']}'),
                              Padding(padding: EdgeInsets.all(20)),
                              Text(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  '${classInfo['start_time'].substring(0, 5)} ~ ${classInfo['end_time'].substring(0, 5)}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                      child: Text(
                        classInfo['class_name'],
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF0F1113),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
