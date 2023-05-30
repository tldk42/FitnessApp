import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailMemberInfoWidget extends StatefulWidget {
  Map<String, dynamic> userInfo;
  final Function update;

  DetailMemberInfoWidget(
      {Key? key, required this.userInfo, required this.update})
      : super(key: key);

  @override
  _DetailMemberInfoWidgetState createState() => _DetailMemberInfoWidgetState();
}

class _DetailMemberInfoWidgetState extends State<DetailMemberInfoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool? transactionComplete;
  String? reservedCredit;
  int? credit;

  @override
  void initState() {
    super.initState();
    transactionComplete = widget.userInfo['transaction_state'] == '0';
    reservedCredit = widget.userInfo['reserved_credit'];
    credit = int.tryParse(
        '${reservedCredit?.substring(reservedCredit!.lastIndexOf('\$') + 1, reservedCredit!.length)}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration customBoxDeco = const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          color: Color(0xFF393239),
          offset: Offset(0, 2),
        )
      ],
    );

    TextStyle customTextStyle = const TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      color: Color(0xFF14181B),
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
            child: Container(
              width: double.infinity,
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                          child: Text(
                            widget.userInfo['member_name'],
                            style: const TextStyle(
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
                            decoration: const BoxDecoration(
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
                    alignment: const Alignment(-1, 0),
                    child: TabBar(
                      isScrollable: true,
                      labelStyle: customTextStyle,
                      unselectedLabelStyle: customTextStyle,
                      labelColor: const Color(0xFFFF96D5),
                      unselectedLabelColor: const Color(0xFF57636C),
                      // backgroundColor: Color(0xFF393239),
                      // unselectedBackgroundColor: Color(0xFFE0E3E7),
                      // borderColor: Color(0xFF393239),
                      // borderWidth: 2,
                      // borderRadius: 12,
                      // elevation: 0,
                      labelPadding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      // buttonMargin:
                      // EdgeInsetsDirectional.fromSTEB(16, 12, 0, 12),
                      tabs: const [
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
                              decoration: customBoxDeco,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                      child: Text(
                                        'Phone : ${widget.userInfo['member_phone']}',
                                        style: customTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 70,
                              decoration: customBoxDeco,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.fitness_center,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                      child: Text(
                                        'Member Since : ${widget.userInfo['created_on'].substring(0, 10)}',
                                        style: customTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 70,
                              decoration: customBoxDeco,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.fitness_center,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 0, 0),
                                      child: Text(
                                        'Membership Due : ${widget.userInfo['valid_on'] != null ? widget.userInfo['valid_on'].substring(0, 10) : 'X'}',
                                        style: customTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              width: 100,
                              height: 70,
                              decoration: customBoxDeco,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.lock,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                      child: Text(
                                        'Locker Number : ${widget.userInfo['locker_info'] ?? 'X'}',
                                        style: customTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 70,
                              decoration: customBoxDeco,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.attach_money,
                                      color: Color(0xFF57636C),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                      child: Text(
                                        'Credit : ${widget.userInfo['member_credit']}',
                                        style: customTextStyle,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                        onPressed: transactionComplete!
                                            ? null
                                            : () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                      title: const Text(
                                                          'Enter Coin'),
                                                      content: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextFormField(
                                                            initialValue:
                                                                '$credit',
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            textAlign: TextAlign
                                                                .center,
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              // 경계선 없음
                                                              isDense: true,

                                                              prefixText: '\$',
                                                            ),
                                                            style:
                                                                const TextStyle(
                                                              fontFamily:
                                                                  'Outfit',
                                                              color: Color(
                                                                  0xFF14181B),
                                                              fontSize: 50,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            onChanged:
                                                                (value) async {
                                                              setState(() {
                                                                credit =
                                                                    int.tryParse(
                                                                            value) ??
                                                                        0;
                                                              });
                                                            },
                                                          ),
                                                          const SizedBox(
                                                              height: 40),
                                                          Text(widget.userInfo[
                                                              'reserved_credit']),
                                                          const SizedBox(
                                                              height: 40),
                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                var result =
                                                                    await sendData(
                                                                        urlPath:
                                                                            'manager/add_credit.php',
                                                                        data: {
                                                                      'member_id':
                                                                          widget
                                                                              .userInfo['member_id'],
                                                                      'member_credit':
                                                                          '${(int.tryParse(widget.userInfo['member_credit'])! + credit!)}',
                                                                      'transaction_key':
                                                                          DateTime.now().toString().substring(0,19),
                                                                      'transaction_value':
                                                                          '+$credit'
                                                                    });
                                                                if (result !=
                                                                    null) {
                                                                  setState(() {
                                                                    transactionComplete =
                                                                        true;
                                                                    credit = 0;
                                                                    reservedCredit =
                                                                        '';
                                                                  });
                                                                }
                                                                await widget
                                                                    .update();
                                                                var result2 =
                                                                    await sendData(
                                                                        urlPath:
                                                                            'common/sync_page.php',
                                                                        data: {
                                                                      'member_id':
                                                                          widget
                                                                              .userInfo['member_id']
                                                                    });
                                                                if (result2 !=
                                                                    null) {
                                                                  if (result2[
                                                                      'success']) {
                                                                    print('OK');
                                                                    setState(
                                                                        () {
                                                                      widget.userInfo =
                                                                          result2[
                                                                              'userData'];
                                                                    });
                                                                  }
                                                                }
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "Submit"))
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                        child: const Text("Add"))
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16, 12, 16, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0x25000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(4, 4, 4, 4),
                                        child: Container(
                                          width: 4,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF393239),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(12, 12, 16, 12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
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
