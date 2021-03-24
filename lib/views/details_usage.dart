import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class DetailsUsage extends StatefulWidget {
  @override
  DetailsUsageState createState() => DetailsUsageState();
}

class DetailsUsageState extends State<DetailsUsage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 40.0,
              child: Row(
                children: <Widget>[
                  Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.all(1.0),
                      width: 129.0,
                      child: Text(
                        "날짜",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.all(1.0),
                      width: 138.0,
                      child: Text(
                        "충전기",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      color: Colors.grey,
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.all(1.0),
                      width: 138.0,
                      child: Text(
                        "이용금액",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(4.0),
                          width: 130.0,
                          child: Text(
                            "날짜 $index",
                            style: TextStyle(fontSize: 18),
                          )),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        width: 140.0,
                        child: Text(
                          "충전기 $index",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4.0),
                        width: 140.0,
                        child: Text(
                          "이용금액 $index",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}
