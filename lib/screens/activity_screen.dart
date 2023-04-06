import 'package:filter_list/filter_list.dart';
import 'package:fitness_app/components/main_app_screen/tabbed_appbar_component.dart';
import 'package:flutter/material.dart';

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

class Activity{
  final String? name;

  Activity({this.name});
}

class _ActivityScreenState extends State<ActivityScreen> {


  List<Activity> userList = [
    Activity(name: "Personal Training"),
    Activity(name: "Pilates"),
    Activity(name: "Ballet"),
    Activity(name: "Yoga"),
  ];

  List<Activity> selectedUserList =[];

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                           padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 18, 0),
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
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                        child: Container(
                          width: double.infinity,
                          height: 184,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: Image.network(
                                'https://images.unsplash.com/photo-1616803689943-5601631c7fec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTR8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                              ).image,
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
                              padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: const [
                                        Expanded(
                                          child: Text(
                                            'Class Name',
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
                                        children: [
                                          // FFButtonWidget(
                                          //   onPressed: () {
                                          //     print('Button-Reserve pressed ...');
                                          //   },
                                          //   text: 'Reserve',
                                          //   icon: const Icon(
                                          //     Icons.add_rounded,
                                          //     color: Colors.white,
                                          //     size: 15,
                                          //   ),
                                          //   options: FFButtonOptions(
                                          //     width: 120,
                                          //     height: 40,
                                          //     padding:
                                          //     const EdgeInsetsDirectional.fromSTEB(
                                          //         0, 0, 0, 0),
                                          //     iconPadding:
                                          //     const EdgeInsetsDirectional.fromSTEB(
                                          //         0, 0, 0, 0),
                                          //     color: const Color(0xFFFF96D5),
                                          //     textStyle: GoogleFonts.getFont(
                                          //       'Lexend Deca',
                                          //       color: Colors.white,
                                          //       fontSize: 14,
                                          //     ),
                                          //     elevation: 3,
                                          //     borderSide: const BorderSide(
                                          //       color: Colors.transparent,
                                          //       width: 1,
                                          //     ),
                                          //   ),
                                          // ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 4),
                                                  child: Text('10:00am',
                                                      style: TextStyle(
                                                        fontFamily: 'Lexend Deca',
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                ),
                                                Text('Thursday June 22',
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
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );

  }
}