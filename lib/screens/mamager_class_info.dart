import 'package:fitness_app/components/member_screen/BriefMemberInfo.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';

class ClassInfo extends StatefulWidget {
  Map<String, dynamic> classData;
  String managerName;

  ClassInfo({Key? key, required this.classData, required this.managerName})
      : super(key: key);

  @override
  _ClassInfoState createState() => _ClassInfoState();
}

class _ClassInfoState extends State<ClassInfo> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  late String newTimeString;
  late String newDateString;

  List<Map<String, dynamic>>? memberList;

  Future _getMemberList() async {
    final response = await sendData(
        urlPath: 'manager/get_enrolled_members.php',
        data: {'class_id':widget.classData['class_id']});

    print(response);
    if (response != null) {
      setState(() {
        final List<dynamic> list = response;
        memberList = list.map((e) => e as Map<String, dynamic>).toList();
      });
    }else{
      memberList = List.empty();
    }

  }

  @override
  void initState() {
    super.initState();

    var startTime = widget.classData['start_time'].substring(0, 5);
    var endTime = widget.classData['end_time'].substring(0, 5);

    var startDate = widget.classData['start_date'].substring(0, 10);
    var endDate = widget.classData['end_date'].substring(0, 10);

    newTimeString = '$startTime~$endTime';
    newDateString = '$startDate ~ $endDate';

    _getMemberList();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Class Info", style: TextStyle(color: Color(0xfff975c4))),
          backgroundColor: Color(0xFF393239),
          automaticallyImplyLeading: false,
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Colors.transparent, width: 1)),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF101213),
                size: 30,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newDateString,
                        style: const TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF57636C),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: Text(
                              widget.classData['class_name'],
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF101213),
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                            InkWell(
                              customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                      color: Color(0xFFE0E3E7), width: 1)),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Color(0xFF57636C),
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                        color: Color(0xFFE0E3E7), width: 1)),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Color(0xFF57636C),
                                    size: 24,
                                  ),
                                  onPressed: () async {
                                    var result = sendData(
                                        urlPath: 'manager/delete_class.php',
                                        data: {
                                          'class_id':
                                              widget.classData['class_id']
                                        });
                                    Navigator.pop(context, "update");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE0E3E7),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'By',
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF57636C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            52, 0, 0, 0),
                                        child: Text(
                                          widget.managerName,
                                          style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF101213),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFF94D4),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            color: Color(0xFFFF94D4),
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 8, 12, 8),
                                          child: Text(
                                            widget.classData['active_days'],
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF101213),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 12, 16, 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    // ClipRRect(
                                    //   borderRadius: BorderRadius.circular(40),
                                    //   child: Image.asset(
                                    //     'assets/images/brooklyn_nets_logo_alternate_20133961.png',
                                    //     width: 50,
                                    //     height: 50,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 0, 0),
                                      child: Text(
                                        newTimeString,
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF101213),
                                          fontSize: 36,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(0xFFE0E3E7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Text(
                        'Enrolled Members',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF57636C),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment(-1, 0),
                            child: TabBar(
                              isScrollable: true,
                              labelColor: Color(0xFF101213),
                              unselectedLabelColor: Color(0xFF57636C),
                              labelPadding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                              labelStyle: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF101213),
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                              ),
                              indicatorColor: Colors.white,
                              indicatorWeight: 2,
                              tabs: [
                                Tab(
                                  text: 'Members',
                                ),
                                Tab(
                                  text: 'Not yet',
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                /**@ 등록한 회원들 */
                                ListView.builder(
                                  itemCount: memberList?.length ?? 0,
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int index) {
                                    return UserIconWithInfo(memberInfo: memberList![index]);
                                  },
                                  // children: [
                                  //   Padding(
                                  //     padding:
                                  //         const EdgeInsetsDirectional.fromSTEB(
                                  //             0, 0, 0, 1),
                                  //     child: Container(
                                  //       width: 300,
                                  //       decoration: const BoxDecoration(
                                  //         color: Colors.white,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             blurRadius: 0,
                                  //             color: Color(0xFFE0E3E7),
                                  //             offset: Offset(0, 1),
                                  //           )
                                  //         ],
                                  //       ),
                                  //       child: Padding(
                                  //         padding: const EdgeInsetsDirectional
                                  //             .fromSTEB(8, 8, 8, 8),
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.max,
                                  //           children: [
                                  //             // ClipRRect(
                                  //             //   borderRadius:
                                  //             //       BorderRadius.circular(40),
                                  //             //   child: Image.asset(
                                  //             //     'assets/images/cto5f_i.png',
                                  //             //     width: 50,
                                  //             //     height: 50,
                                  //             //     fit: BoxFit.cover,
                                  //             //   ),
                                  //             // ),
                                  //             Expanded(
                                  //               child: Column(
                                  //                 mainAxisSize:
                                  //                     MainAxisSize.max,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   const Padding(
                                  //                     padding:
                                  //                         EdgeInsetsDirectional
                                  //                             .fromSTEB(
                                  //                                 12, 0, 0, 0),
                                  //                     child: Text(
                                  //                       'Mike Conley',
                                  //                       style: TextStyle(
                                  //                         fontFamily: 'Outfit',
                                  //                         color:
                                  //                             Color(0xFF101213),
                                  //                         fontSize: 18,
                                  //                         fontWeight:
                                  //                             FontWeight.w500,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   const Padding(
                                  //                     padding:
                                  //                         EdgeInsetsDirectional
                                  //                             .fromSTEB(
                                  //                                 12, 4, 0, 0),
                                  //                     child: Text(
                                  //                       '6\' 3\" Point Guard',
                                  //                       style: TextStyle(
                                  //                         fontFamily:
                                  //                             'Plus Jakarta Sans',
                                  //                         color:
                                  //                             Color(0xFF57636C),
                                  //                         fontSize: 14,
                                  //                         fontWeight:
                                  //                             FontWeight.w500,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             const Padding(
                                  //               padding: EdgeInsetsDirectional
                                  //                   .fromSTEB(4, 4, 4, 4),
                                  //               child: Icon(
                                  //                 Icons
                                  //                     .keyboard_arrow_right_rounded,
                                  //                 color: Color(0xFF57636C),
                                  //                 size: 24,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   Padding(
                                  //     padding:
                                  //         const EdgeInsetsDirectional.fromSTEB(
                                  //             0, 0, 0, 1),
                                  //     child: Container(
                                  //       width: 300,
                                  //       decoration: const BoxDecoration(
                                  //         color: Colors.white,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             blurRadius: 0,
                                  //             color: Color(0xFFE0E3E7),
                                  //             offset: Offset(0, 1),
                                  //           )
                                  //         ],
                                  //       ),
                                  //       child: Padding(
                                  //         padding: const EdgeInsetsDirectional
                                  //             .fromSTEB(8, 8, 8, 8),
                                  //         child: Row(
                                  //           mainAxisSize: MainAxisSize.max,
                                  //           children: [
                                  //             // ClipRRect(
                                  //             //   borderRadius:
                                  //             //       BorderRadius.circular(40),
                                  //             //   child: Image.asset(
                                  //             //     'assets/images/i-3.png',
                                  //             //     width: 50,
                                  //             //     height: 50,
                                  //             //     fit: BoxFit.cover,
                                  //             //   ),
                                  //             // ),
                                  //             Expanded(
                                  //               child: Column(
                                  //                 mainAxisSize:
                                  //                     MainAxisSize.max,
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   const Padding(
                                  //                     padding:
                                  //                         EdgeInsetsDirectional
                                  //                             .fromSTEB(
                                  //                                 12, 0, 0, 0),
                                  //                     child: Text(
                                  //                       'Jordan Clarkson',
                                  //                       style: TextStyle(
                                  //                         fontFamily: 'Outfit',
                                  //                         color:
                                  //                             Color(0xFF101213),
                                  //                         fontSize: 18,
                                  //                         fontWeight:
                                  //                             FontWeight.w500,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   const Padding(
                                  //                     padding:
                                  //                         EdgeInsetsDirectional
                                  //                             .fromSTEB(
                                  //                                 12, 4, 0, 0),
                                  //                     child: Text(
                                  //                       '6\' 4\" Point Guard',
                                  //                       style: TextStyle(
                                  //                         fontFamily:
                                  //                             'Plus Jakarta Sans',
                                  //                         color:
                                  //                             Color(0xFF57636C),
                                  //                         fontSize: 14,
                                  //                         fontWeight:
                                  //                             FontWeight.w500,
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             const Padding(
                                  //               padding: EdgeInsetsDirectional
                                  //                   .fromSTEB(4, 4, 4, 4),
                                  //               child: Icon(
                                  //                 Icons
                                  //                     .keyboard_arrow_right_rounded,
                                  //                 color: Color(0xFF57636C),
                                  //                 size: 24,
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   UserIconWithInfo(memberInfo: memberInfo)
                                  // ],
                                ),
                                /**@ 기능 테스트 */
                                ListView(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 1),
                                      child: Container(
                                        width: 300,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 0,
                                              color: Color(0xFFE0E3E7),
                                              offset: Offset(0, 1),
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(8, 8, 8, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12, 0, 0, 0),
                                                      child: Text(
                                                        '회원 이름',
                                                        style: TextStyle(
                                                          fontFamily: 'Outfit',
                                                          color:
                                                              Color(0xFF101213),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12, 4, 0, 0),
                                                      child: Text(
                                                        '회원 전화번호',
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Plus Jakarta Sans',
                                                          color:
                                                              Color(0xFF57636C),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(4, 4, 4, 4),
                                                child: Icon(
                                                  Icons
                                                      .keyboard_arrow_right_rounded,
                                                  color: Color(0xFF57636C),
                                                  size: 24,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
