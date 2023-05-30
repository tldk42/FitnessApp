import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ClassEditModal extends StatefulWidget {
  final Function(ClassItem) onSave;

  ClassEditModal({required this.onSave});

  @override
  _ClassEditModalState createState() => _ClassEditModalState();
}

class _ClassEditModalState extends State<ClassEditModal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _activeDays;
  int? _credit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(
            10, 10, 0, MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(25)), // 상단 모서리를 둥글게 설정
        ),
        child: Theme(
          data: Theme.of(context).copyWith(primaryColor: Color(0xfff975c4)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: nameController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Capacity'),
                  keyboardType: TextInputType.number,
                  controller: capacityController,
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                          _startDate = date;
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                        "Start Date: ${_startDate != null ? "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}" : ''}"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                          _endDate = date;
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                        "End Date: ${_endDate != null ? "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}" : ''}"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      // currentTime: TimeOfDay.now().toDateTime(DateTime.now()).toLocal(),
                      onConfirm: (time) {
                        setState(() {
                          _startTime = TimeOfDay.fromDateTime(time);
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                        "Start Time: ${_startTime != null ? "${_startTime!.hour}:${_startTime!.minute}" : ''}"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      // currentTime: TimeOfDay.now().toDateTime(DateTime.now()).toLocal(),
                      onConfirm: (time) {
                        setState(() {
                          _endTime = TimeOfDay.fromDateTime(time);
                        });
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                        "End Time: ${_endTime != null ? "${_endTime!.hour}:${_endTime!.minute}" : ''}"),
                  ),
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: 'Active Days (e.g. 월, 수, 금)'),
                  onChanged: (value) {
                    setState(() {
                      _activeDays = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Credit'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(() {
                      _credit = int.tryParse(value);
                    });
                  },
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Save'),
                        onPressed: () {
                          widget.onSave(ClassItem(
                            class_name: nameController.text,
                            capacity: int.parse(capacityController.text),
                            start_date: _startDate!,
                            end_date: _endDate!,
                            start_time: _startTime!,
                            end_time: _endTime!,
                            active_days: _activeDays!,
                            credit: _credit!
                          ));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
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

class ClassItem {
  final String class_name;
  final int capacity;
  final DateTime start_date;
  final DateTime end_date;
  final TimeOfDay start_time;
  final TimeOfDay end_time;
  final String active_days;
  final int credit;

  ClassItem({
    required this.class_name,
    required this.capacity,
    required this.start_date,
    required this.end_date,
    required this.start_time,
    required this.end_time,
    required this.active_days,
    required this.credit
  });
}
