import 'package:fitness_app/components/main_app_screen/modal_add_new_class.dart';
import 'package:fitness_app/screens/mamager_class_info.dart';
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
            return Dismissible(
              key: Key(classes![index]['class_name']),
              onDismissed: (direction) {
                setState(() {
                  classes!.removeAt(index);
                  print('hello');
                });
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight, // 아이콘 및 텍스트를 왼쪽 정렬
                child: Padding(
                  padding: const EdgeInsets.all(10), // 서브 위젯의 간격 설정
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.white),
                      // 삭제 아이콘 추가
                      Text('Delete', style: TextStyle(color: Colors.white)),
                      // 삭제 텍스트 추가
                    ],
                  ),
                ),
              ),
              child: ListTile(
                title: Text(classes![index]['class_name']),
                subtitle: Text(classes![index]['capacity']),
                onTap: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassInfo(
                                classData: classes![index],
                                managerName: widget.managerData['manager_name'],
                              )));
                  if (result != null && result == "update") {
                    await _getManagerData();
                  }
                },
              ),
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
                      'class_id':
                          '${classItem.class_name}_${DateTime.now().month}_${DateTime.now().day}',
                      'class_name': classItem.class_name,
                      'manager_id': widget.managerData['manager_id'],
                      'capacity': classItem.capacity.toString(),
                      'start_date': classItem.start_date.toString(),
                      'end_date': classItem.end_date.toString(),
                      'start_time':
                          '${classItem.start_time.hour}:${classItem.start_time.minute}',
                      'end_time':
                          '${classItem.end_time.hour}:${classItem.end_time.minute}',
                      'active_days': classItem.active_days
                    });
                    print(response);
                    print(classItem);
                    _getManagerData();
                  },
                );
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
