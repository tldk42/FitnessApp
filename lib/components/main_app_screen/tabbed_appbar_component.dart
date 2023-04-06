import 'package:flutter/material.dart';

class TabbedAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  List<Widget>? actions;

  TabbedAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF393239),
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Outfit',
          color: Color(0xFFFF96D5),
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: actions,
      centerTitle: true,
      elevation: 0,
    );
  }

  // appBar: AppBar(
  //   actions: Actions,
  //   elevation: 0,
  //   centerTitle: false,
  //   backgroundColor: const Color(0xFF393239),
  //   automaticallyImplyLeading: false,
  //   title: const Text(
  //     'My Activity',
  //     style: TextStyle(
  //       fontFamily: 'Outfit',
  //       color: Color(0xFFFF96D5),
  //       fontSize: 32,
  //       fontWeight: FontWeight.w500,
  //     ),
  //   ),
  // ),

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
