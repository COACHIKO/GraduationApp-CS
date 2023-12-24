import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePage createState() => _HomePage();
}
class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Home', style: TextStyle(color: Colors.white)),
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
      ));
  }
}