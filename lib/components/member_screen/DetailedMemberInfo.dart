import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailMemberInfoWidget extends StatefulWidget {
  Map<String, dynamic> userInfo;

  DetailMemberInfoWidget({Key? key, required this.userInfo}) : super(key: key);

  @override
  _DetailMemberInfoWidgetState createState() => _DetailMemberInfoWidgetState();
}

class _DetailMemberInfoWidgetState extends State<DetailMemberInfoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                    color: Color(0xFFE0E3E7),
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 32, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                          child: Text(
                            widget.userInfo!['member_name'],
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFFFF94D4),
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              'images/logo.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment(-1, 0),
                    child: TabBar(
                      isScrollable: true,
                      labelStyle: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      labelColor: Color(0xFFFF96D5),
                      unselectedLabelColor: Color(0xFF57636C),
                      // backgroundColor: Color(0xFF393239),
                      // unselectedBackgroundColor: Color(0xFFE0E3E7),
                      // borderColor: Color(0xFF393239),
                      // borderWidth: 2,
                      // borderRadius: 12,
                      // elevation: 0,
                      labelPadding:
                          EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      // buttonMargin:
                      // EdgeInsetsDirectional.fromSTEB(16, 12, 0, 12),
                      tabs: [
                        Tab(
                          child: Text('Details'),
                        ),
                        Tab(
                          child: Text('Enrolled Clsses'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              width: 100,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Color(0xFFF1F4F8),
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Phone : ${widget.userInfo['member_phone']}',
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF14181B),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Color(0xFFF1F4F8),
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.fitness_center,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Member Since : ${widget.userInfo['created_on']}',
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF14181B),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Color(0xFFF1F4F8),
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.fitness_center,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Cloth Rental : ${widget.userInfo['cloth_rental'] != 0 ? 'false' : 'true'}',
                                        style: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF14181B),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x25000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 4, 4, 4),
                                        child: Container(
                                          width: 4,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF393239),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 12, 16, 12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Project Name',
                                              style: TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Color(0xFF14181B),
                                                fontSize: 24,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                '4 Folders',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: Color(0xFF57636C),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 4, 0, 0),
                                              child: Text(
                                                '3 upcoming due dates',
                                                style: TextStyle(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color: Color(0xFF393239),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
