import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class CreditManageWidget extends StatefulWidget {
  Function onBack;

  CreditManageWidget({Key? key, required this.onBack}) : super(key: key);

  @override
  _CreditManageWidgetState createState() => _CreditManageWidgetState();
}

class _CreditManageWidgetState extends State<CreditManageWidget>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  Map<String, dynamic>? userInfo;
  int transactionCredit = 0;
  bool showMasterAccount = false;

  Map<String, dynamic> storedValues = {
    'showMasterAccount': false,
    'transactionCredit': 0,
    'transactionId': '',
  };

  Future<void> _saveValues() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/storedTransactionInfo.json');
    await file.writeAsString(jsonEncode(storedValues));
  }

  Future<void> _loadValues() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/storedTransactionInfo.json');
      final contents = await file.readAsString();
      setState(() {
        storedValues = jsonDecode(contents) as Map<String, dynamic>;
      });
    } catch (e) {
      setState(() {
        _initializeValues();
      });
    }
  }

  void _initializeValues() {
    storedValues = {
      'showMasterAccount': false,
      'transactionCredit': 0,
      'transactionId': '',
    };
  }

  // Future<void> _saveShowMasterAccount(bool value) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/showMasterAccount.txt');
  //   await file.writeAsString(value ? 'true' : 'false');
  // }
  //
  // Future<void> _loadShowMasterAccount() async {
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final file = File('${directory.path}/showMasterAccount.txt');
  //     final contents = await file.readAsString();
  //     setState(() {
  //       showMasterAccount = contents == 'true';
  //     });
  //   } catch (e) {
  //     setState(() {
  //       showMasterAccount = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    userInfo =
        Provider.of<UserLoginStateProvider>(context, listen: false).user!;

    showMasterAccount = userInfo!['transaction_state'] == 1;
    _loadValues();
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              await widget.onBack();
            },
          ),
          backgroundColor: const Color(0xFF393239),
          automaticallyImplyLeading: true,
          title: const Text(
            'Credit Detail',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFFFF96D5),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Text(
                          userInfo!['member_name'],
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF14181B),
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.credit_card,
                          color: Color(0xFF14181B),
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          'Transaction ID:',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Text(
                          '${userInfo!['member_id']}_${userInfo!['member_name']}_\$$transactionCredit',
                          style: const TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF14181B),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 0,
                  runSpacing: 0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 500,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 16, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Enter Credit',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF14181B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                                child: TextFormField(
                                  initialValue: ' $transactionCredit',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none, // 경계선 없음
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 16),
                                    prefixText: '\$',
                                  ),
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF14181B),
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onChanged: (value) async {
                                    setState(() {
                                      transactionCredit =
                                          int.tryParse(value) ?? 0;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var reservedCredit =
                                        '${userInfo!['member_id']}_${userInfo!['member_name']}_\$$transactionCredit';

                                    var result = await sendData(
                                        urlPath:
                                            'user/update_transaction_state.php',
                                        data: {
                                          'member_id': userInfo!['member_id'],
                                          'transaction_state': '1',
                                          'reserved_credit': reservedCredit
                                        });
                                    setState(() {
                                      if (result != null) {
                                        showMasterAccount =
                                            result['success'] ?? false;
                                      } else {
                                        showMasterAccount = false;
                                      }
                                    });
                                    // _saveShowMasterAccount(showMasterAccount);
                                    storedValues['showMasterAccount'] =
                                        showMasterAccount;
                                    storedValues['transactionCredit'] =
                                        transactionCredit;
                                    storedValues['transactionId'] =
                                        reservedCredit;
                                    _saveValues();
                                  },
                                  child: const Text(
                                    'Make a Payment',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: showMasterAccount
                                    ? Text(
                                        'Account : 46730104141808 (KB Bank)\n transaction ID : ${storedValues['transactionId']}\n Total : ${storedValues['transactionCredit']} ')
                                    : const SizedBox(),
                                // child: FFButtonWidget(
                                //   onPressed: () {
                                //     print('Button pressed ...');
                                //   },
                                //   text: 'View Share Notice Details',
                                //   options: FFButtonOptions(
                                //     width: 230,
                                //     height: 40,
                                //     padding: EdgeInsetsDirectional.fromSTEB(
                                //         0, 0, 0, 0),
                                //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                                //         0, 0, 0, 0),
                                //     color: Color(0xFFF1F4F8),
                                //     textStyle: TextStyle(
                                //       fontFamily: 'Plus Jakarta Sans',
                                //       color: Color(0xFFFF96D5),
                                //       fontSize: 16,
                                //       fontWeight: FontWeight.w500,
                                //     ),
                                //     elevation: 0,
                                //     borderSide: BorderSide(
                                //       color: Colors.transparent,
                                //       width: 1,
                                //     ),
                                //   ),
                                // ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 500,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFFF1F4F8),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(12, 16, 12, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Credit\n',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF14181B),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                                child: Text(
                                  'AHP 5500',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Last Payment: April 8th, 2022',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '\$3,556.29',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF14181B),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'of \$5,500.00',
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Resets Jun 30, 2022',
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF57636C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
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
        ),
      ),
    );
  }
}
