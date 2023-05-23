import 'dart:convert';

import 'package:fitness_app/components/main_app_screen/modal_add_new_class.dart';
import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';

class ManagerClassScreen extends StatefulWidget {
  final Map<String, dynamic> managerData;

  const ManagerClassScreen({Key? key, required this.managerData})
      : super(key: key);

  @override
  State<ManagerClassScreen> createState() => _ManagerClassScreenState();
}

class _ManagerClassScreenState extends State<ManagerClassScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>>? classes;

  String _className = '';
  String _capacity = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future _getManagerData() async {
    final response = await sendData(
        urlPath: 'manager/get_class.php',
        data: {'manager_id': widget.managerData['manager_id']});

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
    classes = <Map<String, dynamic>>[];
    _getManagerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getManagerData();
        },
        child: ListView.builder(
          itemCount: classes?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(classes![index]['class_name']),
              subtitle: Text(classes![index]['capacity']),
              onTap: () {
                // 선택한 클래스 정보 보기
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfff975c4),
        child: Icon(
          Icons.add,
        ),
        onPressed: () async {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return ClassEditModal(
                  onSave: (classItem) async {
                    var response =
                        sendData(urlPath: 'manager/insert_class.php', data: {
                      'class_id': '${_className}_${DateTime.now()}',
                      'class_name': classItem.class_name,
                      'manager_id': widget.managerData['manager_id'],
                      'capacity': classItem.capacity,
                      'start_date': classItem.start_date,
                      'end_date': classItem.end_date
                    });
                    Navigator.of(context).pop();
                  },
                );

                //   BottomSheet(
                //
                //   onClosing: () {},
                //   builder: (BuildContext context) {
                //     return SingleChildScrollView(
                //       child: Container(
                //         padding: EdgeInsets.only(
                //             bottom: MediaQuery.of(context).viewInsets.bottom),
                //         child: Form(
                //           key: _formKey,
                //           child: Column(
                //             children: [
                //               TextFormField(
                //                 decoration:
                //                     InputDecoration(labelText: 'Class Name'),
                //                 onChanged: (value) => _className = value,
                //               ),
                //               TextFormField(
                //                 decoration:
                //                     InputDecoration(labelText: 'Capacity'),
                //                 onChanged: (value) => _capacity = value,
                //               ),
                //               Row(
                //                 children: [
                //                   Text('Start Date\t\t\t\t\t'),
                //                   ElevatedButton(
                //                       onPressed: () async {
                //                         final selectedDate =
                //                             await showDatePicker(
                //                           context: context,
                //                           initialDate: _startDate,
                //                           firstDate: DateTime(2023),
                //                           lastDate: DateTime(2024),
                //                         );
                //                         if (selectedDate != null) {
                //                           print(_startDate);
                //                           setState(() {
                //                             _startDate = selectedDate;
                //                           });
                //                         }
                //                       },
                //                       child: Text(
                //                           "${_startDate.year.toString()}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')}")),
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Text('End Date\t\t\t\t\t\t\t\t'),
                //                   ElevatedButton(
                //                       onPressed: () async {
                //                         final selectedDate =
                //                             await showDatePicker(
                //                           context: context,
                //                           initialDate: _endDate,
                //                           firstDate: DateTime(2023),
                //                           lastDate: DateTime(2024),
                //                         );
                //                         if (selectedDate != null) {
                //                           print(_endDate);
                //                           setState(() {
                //                             _endDate = selectedDate;
                //                           });
                //                         }
                //                       },
                //                       child: DateText(endDate: _endDate)),
                //                 ],
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   ElevatedButton(
                //                     child: Text('취소'),
                //                     onPressed: () async {
                //                       Navigator.of(context).pop();
                //                     },
                //                   ),
                //                   ElevatedButton(
                //                     style: ButtonStyle(
                //                       backgroundColor:
                //                           MaterialStateProperty.all<Color>(
                //                               Colors.black),
                //                       foregroundColor:
                //                           MaterialStateProperty.all<Color>(
                //                               Colors.white),
                //                     ),
                //                     child: Text(
                //                       '추가',
                //                     ),
                //                     onPressed: () async {
                //                       // TODO: 클래스 추가 기능 구현
                //                       sendData(
                //                           urlPath: 'manager/insert_class.php',
                //                           data: {
                //                             'class_id': '${_className}_${DateTime.now()}',
                //                             'class_name': _className,
                //                             'manager_id': widget
                //                                 .managerData['manager_id'],
                //                             'capacity': _capacity,
                //                             'start_date': "2023-05-03 12:00:00",
                //                             'end_date': "2023-05-03 13:00:00"
                //                           });
                //                       Navigator.of(context).pop();
                //                     },
                //                   ),
                //                 ],
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // );
              });
        },
      ),
    );
  }
}

class DateText extends StatefulWidget {
  const DateText({
    super.key,
    required DateTime endDate,
  }) : _endDate = endDate;

  final DateTime _endDate;

  @override
  State<DateText> createState() => _DateTextState();
}

class _DateTextState extends State<DateText> {
  late DateTime _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = widget._endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        "${_selectedDate.year.toString()}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}");
  }

  void setDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }
}
