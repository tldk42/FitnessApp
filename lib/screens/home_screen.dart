import 'package:fitness_app/components/main_app_screen/tabbed_appbar_component.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
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
  late List<Map<String, dynamic>> userClassList;
  late Future<String> _loadDataStatusFuture;
  String _height = '177cm';
  String _weight = '65';
  String _fatRate = '20';
  String _muscleMass = '34';

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

    _loadDataStatusFuture = _fetchAllClasses();
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
              style: TextStyle(
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            TextField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '$title 입력',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  switch (title) {
                    case '키':
                      _height = text;
                      break;
                    case '몸무게':
                      _weight = text;
                      break;
                    case '체지방률':
                      _fatRate = text;
                      break;
                    case '근육량':
                      _muscleMass = text;
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
            title: const Text('Edit Profile'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField('height', _height),
                  _buildTextField('weight', _weight),
                  _buildTextField('fat', _fatRate),
                  _buildTextField('muscle', _muscleMass),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: Text('취소'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('저장'),
                onPressed: () {
                  // 정보 저장 처리
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
              Container(
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
                    return ActivityHomeView(classInfo: userClassList[index]);
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
                        '신체 정보',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildInfoRow('키', _height!),
                      _buildInfoRow('몸무게', _weight!),
                      _buildInfoRow('체지방률', _fatRate!),
                      _buildInfoRow('근육량', _muscleMass!),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.settings),
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
          child: FutureBuilder(
            future: _loadDataStatusFuture,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  children: homeScreenContents,
                );
              }
            },
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
