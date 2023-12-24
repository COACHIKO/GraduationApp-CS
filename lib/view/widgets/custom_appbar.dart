import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.black,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      leading: Container(
        padding: const EdgeInsets.only(top: 15, left: 10),
        child: const Text(
          "PRO",
          style: TextStyle(
            color: Color(0xFFFBCC12),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
