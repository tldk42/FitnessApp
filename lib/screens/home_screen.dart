import 'package:fitness_app/components/main_app_screen/tabbed_appbar_component.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final String? userAuthKey;
  final Function setTab;

  const HomeScreen({Key? key,
    required this.user,
    required this.userAuthKey,
    required this.setTab})
      : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late List<Map<String, dynamic>> response;
  Map<String, dynamic>? error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Actions = [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
        child: IconButton(
          hoverColor: const Color(0xFF524752),
          icon: const Icon(Icons.notifications_none,
              color: Color(0xFFFF94D4), size: 24),
          onPressed: () {
            print('IconButton pressed ...');
          },
        ),
      )
    ];
    List<Widget> dashboardContents = [
      SafeArea(
          child: GestureDetector(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 420,
                    decoration: const BoxDecoration(
                      color: Color(0xFF393239),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ActivityHomeView(),
                        ActivityHomeView(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
    ];

    List<Widget> homeScreenContents = <Widget>[
      Stack(
        children: dashboardContents,
      ),
      Container(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
          ),
        ),
      ),
      Expanded(
          flex: 1,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Outfit',
                            color: Color(0xFFFF94D4),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          child: const Text("View all",
                              style:
                              TextStyle(fontSize: 16, color: Colors.grey)),
                          onTap: () {},
                        )
                      ],
                    ),
                    width: double.infinity,
                  ),
                  Expanded(
                    child: Container(
                      height: 145,
                      // child: Builder(builder: _buildTransactionActivities),
                    ),
                  )
                ],
              )))
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF393239),
      appBar: TabbedAppBar(
        title: 'My Activity',
        actions: Actions,
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: homeScreenContents,
          ),
        )
      ]),
    );
  }
}

class ActivityHomeView extends StatelessWidget {
  const ActivityHomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.7,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x44111417),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding:
          const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment
                      .center,
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E3E7),
                        borderRadius: BorderRadius.circular(
                            8),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional
                            .fromSTEB(
                            2, 2, 2, 2),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(6),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1500468756762-a401b6f17b46?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1288&q=80',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsetsDirectional
                          .fromSTEB(
                          0, 8, 0, 4),
                      child: Text(
                        '액티비티 제목',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          color: Color(0xFF0F1113),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 4),
                            child: Text(
                              '세부사항 작성',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight
                                    .normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
