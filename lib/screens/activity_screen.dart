import 'package:filter_list/filter_list.dart';
import 'package:fitness_app/components/main_app_screen/tabbed_appbar_component.dart';
import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:fitness_app/resources/randomGenerator.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  Map<String, dynamic> user;
  final String? userAuthKey;
  final Function setTab;

  ActivityScreen(
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
        print('UPDATE Activities Page');
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

    // widget.user =
    //     Provider.of<UserLoginStateProvider>(context).user!;
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
  bool? enrolled;
  late Future<String> _enrollmentStatusFuture;
  late String userId;

  Future<String> _isEnrolled() async {
    final response = await sendData(
        urlPath: 'user/check_enroll.php',
        data: {'class_id': widget.classData['class_id'], 'member_id': userId});
    setState(() {
      if (response != null) {
        if (response['success']) {
          enrolled = true;
        } else {
          enrolled = false;
        }
      } else {
        enrolled = false;
      }
    });
    return 'Loaded';
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 사용자가 다른 영역을 누르면 창이 닫히지 않습니다.
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(enrolled! ? 'Cancel' : 'Register'),
          content:
              Text(enrolled! ? 'Cancel this Class?' : 'Register this Class?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                var userProvider =
                    Provider.of<UserLoginStateProvider>(context, listen: false);
                int currentCredit =
                    int.parse(userProvider.user!['member_credit']);

                int classCredit = int.parse(widget.classData['credit']);

                var newCredit = 0;

                if (!enrolled!) {
                  newCredit = (currentCredit) - classCredit;

                  print(newCredit);
                  if (newCredit < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("You do not have enough credit"),
                        backgroundColor: Colors.red));

                    Navigator.of(context).pop();
                    return;
                  }

                  final response =
                      await sendData(urlPath: 'user/enroll_class.php', data: {
                    'class_id': widget.classData['class_id'],
                    'member_id': userId,
                    'member_credit': '$newCredit',
                    'transaction_key':
                        DateTime.now().toString().substring(0, 19),
                    'transaction_value':
                        '-$classCredit (${widget.classData['class_name']})'
                  });
                  if (response != null) {
                    if (response['success']) {
                      print('enrolled');
                    }
                  }
                } else {
                  newCredit =
                      currentCredit + int.parse(widget.classData['credit']);

                  final response =
                      await sendData(urlPath: 'user/cancel_enroll.php', data: {
                    'class_id': widget.classData['class_id'],
                    'member_id': userId,
                    'member_credit': '$newCredit',
                    'transaction_key':
                        DateTime.now().toString().substring(0, 19),
                    'transaction_value':
                        '+$classCredit (${widget.classData['class_name']})'
                  });
                  if (response != null) {
                    if (response['success']) {
                      print('canceled');
                    }
                  }
                }

                userProvider.updateFromServer();

                setState(() {
                  enrolled = !enrolled!;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      userId = Provider.of<UserLoginStateProvider>(context, listen: false)
          .user!['member_id'];
      _enrollmentStatusFuture = _isEnrolled();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
      child: FutureBuilder(
        future: _enrollmentStatusFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (enrolled != null) {
              return Container(
                width: double.infinity,
                height: 184,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: RandomImageGenerator().image),
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 16, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.classData['class_name'],
                                  style: const TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 4, 16, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Expanded(
                                child: Text(
                                    '30m | High Intensity | Indoor/Outdoor',
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16, 4, 16, 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: !enrolled!
                                        ? const Color(0xFFFF94D4)
                                        : const Color(0xFFC03239),
                                  ),
                                  onPressed: _showConfirmationDialog,
                                  icon: Icon(
                                      !enrolled!
                                          ? Icons.add_rounded
                                          : Icons.cancel_rounded,
                                      color: Colors.white,
                                      size: 15),
                                  label:
                                      Text(!enrolled! ? 'Reserve' : 'Cancel'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: Text(
                                    '\$${widget.classData['credit']}',
                                    style: const TextStyle(
                                        color: Colors.yellowAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 4),
                                        child: Text(
                                            '${widget.classData['start_time'].substring(0, 5)} ~ ${widget.classData['end_time'].substring(0, 5)}',
                                            style: const TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w900,
                                            )),
                                      ),
                                      Text(startDay,
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: const Color(0xFFFF94D4),
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
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}
