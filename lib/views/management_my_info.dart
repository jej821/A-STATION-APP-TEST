import 'package:flutter/material.dart';

class ManagementMyInfo extends StatefulWidget {
  ManagementMyInfoState createState() => ManagementMyInfoState();
}

class ManagementMyInfoState extends State<ManagementMyInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*        body: Column(
      children: [
        titleSection,
        infoSection,
        buttonSection
      ],
    )*/

      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(32),
                  child:Text(
                      'User 님',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    )
                )
            ),
            Flexible(
              child: Container(
                alignment: Alignment(0.0, 0.0),
                height: 45,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12)),
                child: Row(children: <Widget>[
                  Container(
                    width: 60,
                    child: Text("Name",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _tec,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input Your Name',
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment(0.0, 0.0),
                height: 45,
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12)),
                child: Row(children: <Widget>[
                  Container(
                    width: 60,
                    child: Text("Address",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _tec2,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input Your Address',
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment(0.0, 0.0),
                height: 45,
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12)),
                child: Row(children: <Widget>[
                  Container(
                    width: 60,
                    child: Text("Phone",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _tec3,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input Your Phone Number',
                            hintStyle: TextStyle(color: Colors.grey[300])),
                        cursorColor: Colors.blue,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            buttonSection
          ],
        ),
      ),
    );
  }
}

TextEditingController _tec = TextEditingController();
TextEditingController _tec2 = TextEditingController();
TextEditingController _tec3 = TextEditingController();

// 하단 버튼
Column _buildButtonColumn(String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FlatButton(
        onPressed: null,
        child: Text(label),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.black)),
        disabledTextColor: Colors.white,
        disabledColor: Colors.black,
      ),
    ],
  );
}

Widget buttonSection = Container(
  margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn('수정'),
      _buildButtonColumn('취소'),
    ],
  ),
);

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);
