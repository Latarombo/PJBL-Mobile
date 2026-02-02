import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text(
          'GAME START',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
