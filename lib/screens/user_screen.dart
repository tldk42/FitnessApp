import 'dart:io';

import 'package:fitness_app/components/main_app_screen/tabbed_appbar_component.dart';
import 'package:fitness_app/providers/tab_navigation_provider.dart';
import 'package:fitness_app/providers/user_login_state_provider.dart';
import 'package:fitness_app/screens/credit_details.dart';
import 'package:fitness_app/screens/new_setting_screen.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:fitness_app/utilities/slide_right_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

class UserInfo extends StatefulWidget {
  final Map<String, dynamic> user;
  final String? userAuthKey;
  final Function setTab;

  const UserInfo(
      {Key? key,
      required this.user,
      required this.userAuthKey,
      required this.setTab})
      : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  var _image;
  bool _showSubPage = false;
  String? _selectedDuration;
  int? _requiredCredit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var action = [
    Builder(
      builder: (context) => IconButton(
        onPressed: () {
          Navigator.push(context, SlideRightRoute(page: NewSettingScreen()));
        },
        icon: const Icon(FluentIcons.settings_28_regular,
            color: Color(0xFFFF94D4)),
      ),
    )
  ];

  DateTime addMonths(DateTime current, int months) {
    int newYear = current.year;
    int newMonth = current.month + months;

    while (newMonth > 12) {
      newYear += 1;
      newMonth -= 12;
    }
    // 월을 더한 후 마지막 날을 고려합니다.
    int newDay = math.min(current.day, _getLastDayOfMonth(newYear, newMonth));

    return DateTime(newYear, newMonth, newDay, current.hour, current.minute,
        current.second, current.millisecond, current.microsecond);
  }

  int _getLastDayOfMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  double _calculateProgress() {
    if (widget.user['valid_on'] == null) return 0;
    DateTime startDate = DateTime.parse(widget.user['created_on']);
    DateTime endDate = DateTime.parse(widget.user['valid_on']);
    DateTime today = DateTime.now();

    int remainingDays = today.difference(startDate).inDays;
    int totalDays = endDate.difference(startDate).inDays;

    return remainingDays / totalDays;
  }

  void _handleDurationChange(String? duration, int? credit) {
    setState(() {
      _selectedDuration = duration;
      _requiredCredit = credit;
    });
  }

  void _handlePayment() async {
    print('Pay 버튼이 클릭되었습니다!');

    int newCredit = int.parse(widget.user['member_credit']) - _requiredCredit!;

    if (newCredit < 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Payment Fail (Not enough Credit)"),
          backgroundColor: Colors.red));
      Navigator.of(context).pop();
      return;
    }
    DateTime newDate;
    if (widget.user['valid_on'] == null) {
      newDate = addMonths(
          DateTime.now(), int.parse(_selectedDuration!.substring(0, 1)));
    } else {
      newDate = addMonths(
          DateTime.parse(widget.user['valid_on']), int.parse(_selectedDuration!.substring(0, 1)));
    }

    int lockerNum;
    if (widget.user['locker_info'] == null){
      lockerNum = math.Random().nextInt(200) + 1;
    }
    else{
      lockerNum = int.tryParse(widget.user['locker_info'])!;
    }

    var result = await sendData(urlPath: 'user/pay.php', data: {
      'member_id': widget.user['member_id'],
      'member_credit': '$newCredit',
      'transaction_key': DateTime.now().toString().substring(0, 19),
      'transaction_value': '-$_requiredCredit (membership)',
      'valid_on': '$newDate',
      'locker_info': '$lockerNum'
    });

    if (result != null) {
      if (result['success']) {
        Provider.of<UserLoginStateProvider>(context, listen: false)
            .updateFromServer();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Payment Successful"),
            backgroundColor: Colors.lightGreen));
        Navigator.of(context).pop();
        return;
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Payment Fail"), backgroundColor: Colors.red));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return _showSubPage
        ? CreditManageWidget(
            onBack: () async {
              setState(() {
                _showSubPage = false;
              });
            },
          )
        : Scaffold(
            backgroundColor: const Color(0xFFF1F4F8),
            appBar: TabbedAppBar(title: 'UserInfo', actions: action),
            body: SafeArea(
              child: GestureDetector(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color(0xFF393239),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(36),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 0, 0),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 0),
                                    child: Container(
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x1F000000),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(36)),
                                        border: Border.all(
                                          color: const Color(0xFFF1F4F8),
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(12, 0, 12, 0),
                                        child: GestureDetector(
                                          onTap: () => print("on tabbed"),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 60,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFF1F4F8),
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment:
                                                    const AlignmentDirectional(
                                                        0, 0),
                                                child: Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color:
                                                      const Color(0xFF393239),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                  ),
                                                  child: IconButton(
                                                      onPressed: () async {
                                                        var picker =
                                                            ImagePicker();
                                                        XFile? tempImg =
                                                            await picker.pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                        setState(() {
                                                          _image = File(
                                                              tempImg!.path);
                                                        });
                                                      },
                                                      icon: _image != null
                                                          ? Image.file(
                                                              _image,
                                                              // width: 40,
                                                              // height: 40,
                                                            )
                                                          : Image.asset(
                                                              'images/super.png')
                                                      // Image.asset(
                                                      //   'images/logo.png'
                                                      // )
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                        12, 12, 12, 12),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Hello, ${widget.user['member_name']}',
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0xFF393239),
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _selectedDuration = '1 month';
                            _requiredCredit = 20;
                          });
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return SubscriptionDialog(
                                onDurationChanged: _handleDurationChange,
                                onPayment: _handlePayment,
                              );
                            },
                          );
                          print('$_selectedDuration, $_requiredCredit');
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 12, 16, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x1F000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFF1F4F8),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 16, 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 12, 12, 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Member Valid',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF14181B),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 4, 0, 0),
                                                child: Text(
                                                  widget.user['valid_on'] ==
                                                          null
                                                      ? 'Membership Expired'
                                                      : widget.user['valid_on']
                                                          .substring(0, 9),
                                                  style: const TextStyle(
                                                    fontFamily: 'Outfit',
                                                    color: Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF1F4F8),
                                            shape: BoxShape.circle,
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: const Color(0xFFE0E3E7),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 12),
                                              child: Icon(
                                                Icons.remember_me_rounded,
                                                color: Color(0xFF14181B),
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                    child: LinearPercentIndicator(
                                      percent: _calculateProgress(),
                                      width: MediaQuery.of(context).size.width *
                                          0.82,
                                      lineHeight: 16,
                                      animation: true,
                                      progressColor: const Color(0xFFFF94D4),
                                      backgroundColor: const Color(0xFFF1F4F8),
                                      barRadius: const Radius.circular(24),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => print("Tab2!"),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 12, 16, 16),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x1F000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFF1F4F8),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 16, 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 12, 12, 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:  [
                                              Text(
                                                'Personal Locker No.${widget.user['locker_info'] ?? 'X'}',
                                                style: const TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF14181B),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF1F4F8),
                                            shape: BoxShape.circle,
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: const Color(0xFFE0E3E7),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 12),
                                              child: Icon(
                                                Icons.lock,
                                                color: Color(0xFF14181B),
                                                size: 24,
                                              ),
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
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            _showSubPage = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 12, 16, 16),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x1F000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFF1F4F8),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 8, 16, 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(4, 12, 12, 12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'My Credit',
                                                style: TextStyle(
                                                  fontFamily: 'Outfit',
                                                  color: Color(0xFF14181B),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(100, 0, 0, 0),
                                          child: Text(
                                            widget.user['member_credit'],
                                            style: const TextStyle(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF362e36),
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF1F4F8),
                                            shape: BoxShape.circle,
                                          ),
                                          alignment:
                                              const AlignmentDirectional(0, 0),
                                          child: Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: const Color(0xFFE0E3E7),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 12),
                                              child: Icon(
                                                Icons.attach_money,
                                                color: Color(0xFF14181B),
                                                size: 24,
                                              ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _viewAllActivities() {
    Provider.of<TabNavigationProvider>(context, listen: false).updateTabs(0);
    widget.setTab(2);
  }
}

class SubscriptionDialog extends StatefulWidget {
  final void Function(String?, int?)? onDurationChanged;
  final VoidCallback? onPayment;

  SubscriptionDialog({this.onDurationChanged, this.onPayment});

  @override
  _SubscriptionDialogState createState() => _SubscriptionDialogState();
}

class _SubscriptionDialogState extends State<SubscriptionDialog> {
  int _amount = 0;
  String _selectedDuration = '1 month';

  void updatePrice(String duration) {
    switch (duration) {
      case '1 month':
        _amount = 20;
        break;
      case '3 months':
        _amount = 50;
        break;
      case '6 months':
        _amount = 80;
        break;
      case '12 months':
        _amount = 120;
        break;
      default:
        _amount = 0;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    updatePrice(_selectedDuration);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Center(
        child: Text(
          'Choose subscription',
          style: GoogleFonts.acme(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: _selectedDuration,
            items: <String>['1 month', '3 months', '6 months', '12 months']
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedDuration = newValue;
                  updatePrice(_selectedDuration);
                });
                widget.onDurationChanged?.call(_selectedDuration, _amount);
              }
            },
          ),
          SizedBox(height: 16),
          Text(
            'Total amount: \$$_amount',
            style: GoogleFonts.archivoBlack(color: Colors.white, fontSize: 20),
          ),
          Text(
            'Membership includes locker period.',
            style: TextStyle(fontSize: 12, color: Color(0xFF14181B)),
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel',
              style: GoogleFonts.archivoBlack(
                color: Colors.white,
              )),
        ),
        ElevatedButton(
          onPressed: widget.onPayment,
          child: Text('Pay',
              style: GoogleFonts.archivoBlack(
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
