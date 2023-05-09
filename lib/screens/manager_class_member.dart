import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';

class ManagerClassUserScreen extends StatefulWidget {
  final Map<String, dynamic> managerData;

  const ManagerClassUserScreen({Key? key, required this.managerData})
      : super(key: key);

  @override
  State<ManagerClassUserScreen> createState() => _ManagerClassUserScreenState();
}

class _ManagerClassUserScreenState extends State<ManagerClassUserScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>>? _users;
  String _searchKeyword = '';

  Future _fetchAllUser() async {
    var response = await sendData(urlPath: 'manager/get_all_user.php');
    if (response != null) {
      print('UPDATE');
      setState(() {
        final List<dynamic> list = response;
        _users = list.map((e) => e as Map<String, dynamic>).toList();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _users = <Map<String, dynamic>>[];
    _fetchAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: ()  async{
          _fetchAllUser();
        },
        child: GestureDetector(
          onTap: () => {},
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFF1F4F8),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 검색 창
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Search members...',
                              labelStyle: TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF1D2429),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                _searchKeyword = value;
                              });
                            },
                            maxLines: null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: Color(0xFF1D2429),
                              size: 24,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                    child: Text(
                      'Members in my class',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F4F8),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        UserIconWithName(),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                    child: Text(
                      'All Members',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                    child:  ListView.builder(
                        itemCount: _users?.length ?? 0,
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          List<String> items;
                          if (_searchKeyword.isEmpty ||
                              _users![index]['member_name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(_searchKeyword.toLowerCase())) {
                            return UserIconWithInfo(
                              memberInfo: _users![index],
                            );
                          }
                        },

                      ),

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserIconWithInfo extends StatefulWidget {
  final Map<String, dynamic> memberInfo;

  const UserIconWithInfo({Key? key, required this.memberInfo})
      : super(key: key);

  @override
  State<UserIconWithInfo> createState() => _UserIconWithInfoState();
}

class _UserIconWithInfoState extends State<UserIconWithInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x32000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.network(
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.memberInfo['member_name'],
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF1D2429),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            widget.memberInfo['member_phone'],
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserIconWithName extends StatelessWidget {
  const UserIconWithName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      child: Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x34090F13),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                child: Text(
                  'UserName',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    color: Color(0xFF1D2429),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                child: Text(
                  'Remove',
                  style: TextStyle(
                    fontFamily: 'Outfit',
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
    );
  }
}
