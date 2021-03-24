import 'package:flutter/material.dart';

class Navi extends StatefulWidget
{
  @override
  State createState() => NaviState();
}

class NaviState extends State<Navi> {
  String userName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(color: Colors.blue
      ),
    );
  }

}