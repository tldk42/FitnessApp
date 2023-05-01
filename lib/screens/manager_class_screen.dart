import 'package:flutter/material.dart';

class ManagerClassScreen extends StatefulWidget {
  const ManagerClassScreen({Key? key}) : super(key: key);

  @override
  State<ManagerClassScreen> createState() => _ManagerClassScreenState();
}

class _ManagerClassScreenState extends State<ManagerClassScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount:2,
        itemBuilder: (BuildContext context, int index) {

          return ListTile(
          title: Text('Class'),
          subtitle: Text('sub-class'),
          onTap: () {
          // 선택한 클래스 정보 보기
          },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New Activity'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Class Name'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Capacity'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Start'),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Room'),
                      ),
                      // TODO: 나머지 입력 필드 추가
                    ],
                  ),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text('추가'),
                    onPressed: () {
                      // TODO: 클래스 추가 기능 구현
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
