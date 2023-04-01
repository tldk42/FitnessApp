import 'package:fitness_app/screens/login_screen.dart';
import 'package:fitness_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    // Animation을 이용할 경우 Controller의 UpperBound가 1을 넘으면 안됌
    // animation =
    //     CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.grey, end: Colors.orange)
        .animate(animationController);

    animationController.forward();
    animationController.addListener(() {
      setState(() {});
      print(animationController.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _unfocusNode.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF393239),
        appBar: AppBar(
          backgroundColor: const Color(0xFF393239),
          automaticallyImplyLeading: false,
          title: const Text(
            'Activity',
            style: TextStyle(
              color: Color(0xFFFF94D4),
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Material(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Color(0xFF393239),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x430F1113),
                                offset: Offset(0, 2),
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              20, 4, 20, 0),
                          child: TextFormField(),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
                      child: Container(
                        width: double.infinity,
                        height: 184,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1616803689943-5601631c7fec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTR8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                            ).image,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0x65090F13),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      Expanded(
                                        child: Text(
                                          'Class Name',
                                          style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 4, 16, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      Expanded(
                                        child: Text(
                                            '30m | High Intensity | Indoor/Outdoor',
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Color(0xFF39D2C0),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 4, 16, 16),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // FFButtonWidget(
                                        //   onPressed: () {
                                        //     print('Button-Reserve pressed ...');
                                        //   },
                                        //   text: 'Reserve',
                                        //   icon: const Icon(
                                        //     Icons.add_rounded,
                                        //     color: Colors.white,
                                        //     size: 15,
                                        //   ),
                                        //   options: FFButtonOptions(
                                        //     width: 120,
                                        //     height: 40,
                                        //     padding:
                                        //     const EdgeInsetsDirectional.fromSTEB(
                                        //         0, 0, 0, 0),
                                        //     iconPadding:
                                        //     const EdgeInsetsDirectional.fromSTEB(
                                        //         0, 0, 0, 0),
                                        //     color: const Color(0xFFFF96D5),
                                        //     textStyle: GoogleFonts.getFont(
                                        //       'Lexend Deca',
                                        //       color: Colors.white,
                                        //       fontSize: 14,
                                        //     ),
                                        //     elevation: 3,
                                        //     borderSide: const BorderSide(
                                        //       color: Colors.transparent,
                                        //       width: 1,
                                        //     ),
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 4),
                                                child: Text('10:00am',
                                                    style: TextStyle(
                                                      fontFamily: 'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                              Text('Thursday June 22',
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: 'Lexend Deca',
                                                    color: Color(0xB4FFFFFF),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        )
        );
  }
}

// Widget build(BuildContext context) {
//   return Scaffold(
//     key: scaffoldKey,
//     backgroundColor: const Color(0xFF393239),
//     appBar: AppBar(
//       backgroundColor: const Color(0xFF393239),
//       automaticallyImplyLeading: false,
//       title: Text(
//         'Activity',
//         style: FlutterFlowTheme.of(context).displaySmall.override(
//               fontFamily: 'Lexend Deca',
//               color: const Color(0xFFFF94D4),
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//       ),
//       actions: [],
//       centerTitle: false,
//       elevation: 0,
//     ),
//     body: SafeArea(
//       child: GestureDetector(
//         onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Material(
//                   color: Colors.transparent,
//                   elevation: 0,
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 60,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF393239),
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4,
//                           color: Color(0x430F1113),
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
//                       child: TextFormField(
//                         controller: _model.searchFieldController,
//                         obscureText: false,
//                         decoration: InputDecoration(
//                           hintText: 'Type to search here...',
//                           hintStyle:
//                               FlutterFlowTheme.of(context).bodySmall.override(
//                                     fontFamily: 'Lexend Deca',
//                                     color: const Color(0xFF95A1AC),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Color(0xFFF1F4F8),
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Color(0x00000000),
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Color(0x00000000),
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Color(0x00000000),
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.search_rounded,
//                             color: Color(0xFF95A1AC),
//                           ),
//                         ),
//                         style: FlutterFlowTheme.of(context).bodyMedium.override(
//                               fontFamily: 'Lexend Deca',
//                               color: const Color(0xFF090F13),
//                               fontSize: 14,
//                               fontWeight: FontWeight.normal,
//                             ),
//                         maxLines: null,
//                         validator: _model.searchFieldControllerValidator
//                             .asValidator(context),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 scrollDirection: Axis.vertical,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 20),
//                     child: Container(
//                       width: double.infinity,
//                       height: 184,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(
//                           fit: BoxFit.fitWidth,
//                           image: Image.network(
//                             'https://images.unsplash.com/photo-1616803689943-5601631c7fec?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTR8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
//                           ).image,
//                         ),
//                         boxShadow: [
//                           const BoxShadow(
//                             blurRadius: 3,
//                             color: Color(0x33000000),
//                             offset: Offset(0, 2),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: const Color(0x65090F13),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     16, 16, 16, 0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         'Class Name',
//                                         style: FlutterFlowTheme.of(context)
//                                             .displaySmall
//                                             .override(
//                                               fontFamily: 'Lexend Deca',
//                                               color: Colors.white,
//                                               fontSize: 24,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                       ),
//                                     ),
//                                     const Icon(
//                                       Icons.chevron_right_rounded,
//                                       color: Colors.white,
//                                       size: 24,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     16, 4, 16, 0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         '30m | High Intensity | Indoor/Outdoor',
//                                         style: FlutterFlowTheme.of(context)
//                                             .bodySmall
//                                             .override(
//                                               fontFamily: 'Lexend Deca',
//                                               color: const Color(0xFF39D2C0),
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.normal,
//                                             ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsetsDirectional.fromSTEB(
//                                       16, 4, 16, 16),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       FFButtonWidget(
//                                         onPressed: () {
//                                           print('Button-Reserve pressed ...');
//                                         },
//                                         text: 'Reserve',
//                                         icon: const Icon(
//                                           Icons.add_rounded,
//                                           color: Colors.white,
//                                           size: 15,
//                                         ),
//                                         options: FFButtonOptions(
//                                           width: 120,
//                                           height: 40,
//                                           padding:
//                                               const EdgeInsetsDirectional.fromSTEB(
//                                                   0, 0, 0, 0),
//                                           iconPadding:
//                                               const EdgeInsetsDirectional.fromSTEB(
//                                                   0, 0, 0, 0),
//                                           color: const Color(0xFFFF96D5),
//                                           textStyle: GoogleFonts.getFont(
//                                             'Lexend Deca',
//                                             color: Colors.white,
//                                             fontSize: 14,
//                                           ),
//                                           elevation: 3,
//                                           borderSide: const BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1,
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.max,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsetsDirectional
//                                                   .fromSTEB(0, 0, 0, 4),
//                                               child: Text(
//                                                 '10:00am',
//                                                 style:
//                                                     FlutterFlowTheme.of(context)
//                                                         .headlineSmall
//                                                         .override(
//                                                           fontFamily:
//                                                               'Lexend Deca',
//                                                           color: Colors.white,
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                               ),
//                                             ),
//                                             Text(
//                                               'Thursday June 22',
//                                               textAlign: TextAlign.end,
//                                               style: FlutterFlowTheme.of(
//                                                       context)
//                                                   .bodyMedium
//                                                   .override(
//                                                     fontFamily: 'Lexend Deca',
//                                                     color: const Color(0xB4FFFFFF),
//                                                     fontSize: 14,
//                                                     fontWeight:
//                                                         FontWeight.normal,
//                                                   ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                     child: Container(
//                       width: double.infinity,
//                       height: 184,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(
//                           fit: BoxFit.fitWidth,
//                           image: Image.asset(
//                             'assets/images/john-arano-h4i9G-de7Po-unsplash.jpg',
//                           ).image,
//                         ),
//                         boxShadow: [
//                           const BoxShadow(
//                             blurRadius: 3,
//                             color: Color(0x33000000),
//                             offset: Offset(0, 2),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: const Color(0x65090F13),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Class Name',
//                                       style: FlutterFlowTheme.of(context)
//                                           .displaySmall
//                                           .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: Colors.white,
//                                             fontSize: 24,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.chevron_right_rounded,
//                                     color: Colors.white,
//                                     size: 24,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       '30m | High Intensity | Indoor/Outdoor',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodySmall
//                                           .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: const Color(0xFF39D2C0),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     16, 4, 16, 16),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button-Reserve pressed ...');
//                                       },
//                                       text: 'Reserve',
//                                       icon: const Icon(
//                                         Icons.add_rounded,
//                                         color: Colors.white,
//                                         size: 15,
//                                       ),
//                                       options: FFButtonOptions(
//                                         width: 120,
//                                         height: 40,
//                                         padding: const EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 0, 0),
//                                         iconPadding:
//                                             const EdgeInsetsDirectional.fromSTEB(
//                                                 0, 0, 0, 0),
//                                         color: const Color(0xFFFF96D5),
//                                         textStyle: GoogleFonts.getFont(
//                                           'Lexend Deca',
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                         ),
//                                         elevation: 3,
//                                         borderSide: const BorderSide(
//                                           color: Colors.transparent,
//                                           width: 1,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsetsDirectional.fromSTEB(
//                                                     0, 0, 0, 4),
//                                             child: Text(
//                                               '10:00am',
//                                               style: FlutterFlowTheme.of(
//                                                       context)
//                                                   .headlineSmall
//                                                   .override(
//                                                     fontFamily: 'Lexend Deca',
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                             ),
//                                           ),
//                                           Text(
//                                             'Thursday June 22',
//                                             textAlign: TextAlign.end,
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Lexend Deca',
//                                                   color: const Color(0xB4FFFFFF),
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.normal,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                     child: Container(
//                       width: double.infinity,
//                       height: 184,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(
//                           fit: BoxFit.fitWidth,
//                           image: Image.network(
//                             'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8d29ya291dHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60',
//                           ).image,
//                         ),
//                         boxShadow: [
//                           const BoxShadow(
//                             blurRadius: 3,
//                             color: Color(0x33000000),
//                             offset: Offset(0, 2),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: const Color(0x65090F13),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Class Name',
//                                       style: FlutterFlowTheme.of(context)
//                                           .displaySmall
//                                           .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: Colors.white,
//                                             fontSize: 24,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.chevron_right_rounded,
//                                     color: Colors.white,
//                                     size: 24,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       '30m | High Intensity | Indoor/Outdoor',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodySmall
//                                           .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: const Color(0xFF39D2C0),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     16, 4, 16, 16),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button-Reserve pressed ...');
//                                       },
//                                       text: 'Reserve',
//                                       icon: const Icon(
//                                         Icons.add_rounded,
//                                         color: Colors.white,
//                                         size: 15,
//                                       ),
//                                       options: FFButtonOptions(
//                                         width: 120,
//                                         height: 40,
//                                         padding: const EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 0, 0),
//                                         iconPadding:
//                                             const EdgeInsetsDirectional.fromSTEB(
//                                                 0, 0, 0, 0),
//                                         color: const Color(0xFFFF96D5),
//                                         textStyle: GoogleFonts.getFont(
//                                           'Lexend Deca',
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                         ),
//                                         elevation: 3,
//                                         borderSide: const BorderSide(
//                                           color: Colors.transparent,
//                                           width: 1,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsetsDirectional.fromSTEB(
//                                                     0, 0, 0, 4),
//                                             child: Text(
//                                               '10:00am',
//                                               style: FlutterFlowTheme.of(
//                                                       context)
//                                                   .headlineSmall
//                                                   .override(
//                                                     fontFamily: 'Lexend Deca',
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                             ),
//                                           ),
//                                           Text(
//                                             'Thursday June 22',
//                                             textAlign: TextAlign.end,
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Lexend Deca',
//                                                   color: const Color(0xB4FFFFFF),
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.normal,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
//                     child: Container(
//                       width: double.infinity,
//                       height: 184,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         image: DecorationImage(
//                           fit: BoxFit.fitWidth,
//                           image: Image.network(
//                             'https://images.unsplash.com/photo-1581009137042-c552e485697a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
//                           ).image,
//                         ),
//                         boxShadow: [
//                           const BoxShadow(
//                             blurRadius: 3,
//                             color: Color(0x33000000),
//                             offset: Offset(0, 2),
//                           )
//                         ],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           color: const Color(0x65090F13),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       'Class Name',
//                                       style: FlutterFlowTheme.of(context)
//                                           .displaySmall
//                                           .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: Colors.white,
//                                             fontSize: 24,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.chevron_right_rounded,
//                                     color: Colors.white,
//                                     size: 24,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       '30m | High Intensity | Indoor/Outdoor',
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodySmall
//                                           .override(
//                                             fontFamily: 'Lexend Deca',
//                                             color: const Color(0xFF39D2C0),
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     16, 4, 16, 16),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     FFButtonWidget(
//                                       onPressed: () {
//                                         print('Button-Reserve pressed ...');
//                                       },
//                                       text: 'Reserve',
//                                       icon: const Icon(
//                                         Icons.add_rounded,
//                                         color: Colors.white,
//                                         size: 15,
//                                       ),
//                                       options: FFButtonOptions(
//                                         width: 120,
//                                         height: 40,
//                                         padding: const EdgeInsetsDirectional.fromSTEB(
//                                             0, 0, 0, 0),
//                                         iconPadding:
//                                             const EdgeInsetsDirectional.fromSTEB(
//                                                 0, 0, 0, 0),
//                                         color: const Color(0xFF39D2C0),
//                                         textStyle: GoogleFonts.getFont(
//                                           'Lexend Deca',
//                                           color: Colors.white,
//                                           fontSize: 14,
//                                         ),
//                                         elevation: 3,
//                                         borderSide: const BorderSide(
//                                           color: Colors.transparent,
//                                           width: 1,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsetsDirectional.fromSTEB(
//                                                     0, 0, 0, 4),
//                                             child: Text(
//                                               '10:00am',
//                                               style: FlutterFlowTheme.of(
//                                                       context)
//                                                   .headlineSmall
//                                                   .override(
//                                                     fontFamily: 'Lexend Deca',
//                                                     color: Colors.white,
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                             ),
//                                           ),
//                                           Text(
//                                             'Thursday June 22',
//                                             textAlign: TextAlign.end,
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Lexend Deca',
//                                                   color: const Color(0xB4FFFFFF),
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.normal,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
