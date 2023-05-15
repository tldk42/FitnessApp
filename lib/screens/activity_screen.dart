import 'package:filter_list/filter_list.dart';
import 'package:fitness_app/components/main_app_screen/tabbed_appbar_component.dart';
import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:fitness_app/resources/randomGenerator.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String? userAuthKey;
  final Function setTab;

  const ActivityScreen(
      {Key? key,
      required this.user,
      required this.userAuthKey,
      required this.setTab})
      : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class Activity {
  final String? name;

  Activity({this.name});
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<Map<String, dynamic>>? classes;

  List<Activity> userList = [
    Activity(name: "Personal Training"),
    Activity(name: "Pilates"),
    Activity(name: "Ballet"),
    Activity(name: "Yoga"),
  ];

  List<Activity> selectedUserList = [];

  void openFilterDialog() async {
    await FilterListDialog.display<Activity>(
      context,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (user) => user!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },
      headlineText: "Filter",
      themeData: FilterListThemeData.light(context),
    );
  }

  Future _fetchClasses() async {
    final response = await sendData(
      urlPath: 'manager/get_all_class.php',
    );

    if (response != null) {
      setState(() {
        print('UPDATE');
        final List<dynamic> list = response;
        classes = list.map((e) => e as Map<String, dynamic>).toList();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _fetchClasses();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _fetchClasses();
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF393239),
        appBar: TabbedAppBar(title: 'Activities'),
        body: SafeArea(
          child: GestureDetector(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Color(0xFF393239),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                // color: Color(0x430F1113),
                                color: Colors.transparent,
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: Container(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 18, 0),
                            alignment: Alignment.topRight,
                            child: FloatingActionButton(
                                backgroundColor: const Color(0xFFFF94D4),
                                onPressed: openFilterDialog,
                                child: const Icon(
                                  IconData(0xf068, fontFamily: 'MaterialIcons'),
                                ))

                            // TextFormField(),
                            ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: classes?.length ?? 0,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return ActivityList(classData: classes![index]);
                  },
                  // children: [
                  //
                  //   // ActivityList(
                  //   //     imageUrl:
                  //   //         'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8d29ya291dHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60'),
                  //   // ActivityList(
                  //   //   imageUrl:
                  //   //       'https://images.unsplash.com/photo-1581009137042-c552e485697a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                  //   // ),
                  // ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityList extends StatefulWidget {
  final Map<String, dynamic> classData;

  ActivityList({super.key, required this.classData});

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  late DateTime startDate;
  late DateTime endDate;
  late Map<String, dynamic> mergedMap;
  String startDay = '';
  bool enrolled = false;

  Future<bool> _isEnrolled() async {
    final response =
        await sendData(urlPath: 'user/check_enroll.php', data: mergedMap);
    if (response != null) {
      if (response['success']) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      startDate = DateTime.parse(widget.classData['start_date']);
      final DateFormat formatter = DateFormat('EEEE MMMM dd');
      startDay = formatter.format(startDate);

      var tempUserData =
          Provider.of<UserLoginStateProvider>(context, listen: false).user;
      var tempClassData = widget.classData;
      mergedMap = Map.from(tempUserData!)..addAll(tempClassData);
      _isEnrolled().then((value) => enrolled = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
      child: Container(
        width: double.infinity,
        height: 184,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fitWidth, image: RandomImageGenerator().image
              // Image.network(
              //   'https://images.unsplash.com/photo-1616803689943-5601631c7fec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTR8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
              // ).image,
              ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0x65090F13),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          widget.classData['class_name'],
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Expanded(
                        child: Text('30m | High Intensity | Indoor/Outdoor',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF39D2C0),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !enrolled
                                ? Color(0xFFFF94D4)
                                : Color(0xFFC03239),
                          ),
                          onPressed: !enrolled
                              ? () async {
                                  final response = await sendData(
                                      urlPath: 'user/enroll_class.php',
                                      data: mergedMap);
                                  if (response != null) {
                                    if (response['success']) {
                                      print('enrolled');
                                      setState(() {
                                        enrolled = true;
                                      });
                                    }
                                  }
                                }
                              : () async {
                                  final response = await sendData(
                                      urlPath: 'user/cancel_enroll.php',
                                      data: mergedMap);
                                  if (response != null) {
                                    if (response['success']) {
                                      print('canceled');
                                      setState(() {
                                        enrolled = false;
                                      });
                                    }
                                  }
                                },
                          icon: Icon(
                              !enrolled
                                  ? Icons.add_rounded
                                  : Icons.cancel_rounded,
                              color: Colors.white,
                              size: 15),
                          label: Text(!enrolled ? 'Reserve' : 'Cancel'),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                child: Text(
                                    startDate.hour.toString() +
                                        ':' +
                                        startDate.minute.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Text(startDay,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xB4FFFFFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
