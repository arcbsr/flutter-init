import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BasicAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
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
          icon: const Icon(Icons.search),
          onPressed: () {
            // Do something
          },
        ),
        IconButton(
          icon: const Icon(Icons.qr_code),
          onPressed: () {
            // Do something
          },
        ),
        IconButton(
          icon: const Icon(Icons.notification_important),
          onPressed: () {
            // Do something
          },
        ),
      ],
    );
  }
}
