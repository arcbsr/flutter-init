import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  BasicAppBar({required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: TextStyle(
        color: Colors.black, // Set the color of the title text to white
        ),
      ),


      backgroundColor: Colors.white,
      // leading: IconButton(
      //   icon: Icon(Icons.menu),
      //   onPressed: () {
      //     // Do something
      //   },
      // ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Do something
          },
        ),IconButton(
          icon: Icon(Icons.qr_code),
          onPressed: () {
            // Do something
          },
        ),IconButton(
          icon: Icon(Icons.notification_important),
          onPressed: () {
            // Do something
          },
        ),
      ],

    );
  }
}