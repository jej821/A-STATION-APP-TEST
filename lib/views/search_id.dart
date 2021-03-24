import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 데이터 처리 지원

class SearchID extends StatefulWidget {
  @override
  SearchIDState createState() => SearchIDState();
}

class SearchIDState extends State<SearchID> {
  final _formKey = GlobalKey<FormState>();
  String userName, userPhoneNo = '';
  FocusNode userNameFocusNode, userPhoneNoFocusNode = FocusNode();

  Future<String> _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          // resizeToAvoidBottomPadding: false,
          appBar: AppBar(title: Text('아이디 찾기')),
          body: new Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: (_futureUser == null)
                      ? Column(children: <Widget>[
                          InputUserNameContainer(),
                          SizedBox(
                            height: 16,
                          ),
                          InputUserPhoneNumberContainer(),
                          SizedBox(
                            height: 16,
                          ),
                          SubmitButton(),
                        ], mainAxisAlignment: MainAxisAlignment.center)
                      : FutureBuilder<String>(
                          future: _futureUser,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // return Text(snapshot.data.id + "/" +snapshot.data.pw);
                              return Text(str);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            return CircularProgressIndicator();
                          },
                        ),
                ),
              )),
        );
  }

  Widget InputUserNameContainer() {
    return Container(
      width: 300,
      child: TextFormField(
        focusNode: userNameFocusNode,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "이름",
        ),
        textInputAction: TextInputAction.next,
        validator: (name) {
          if (name.isEmpty) {
            return '이름을 입력하세요.';
          }
          return null;
        },
        onSaved: (name) => userName = name,
        onFieldSubmitted: (_) {
          // fieldFocusChange(context, _user_idFocusNode, _user_pwFocusNode);
        },
      ),
    );
  }

  Widget InputUserPhoneNumberContainer() {
    return Container(
      width: 300,
      child: TextFormField(
        focusNode: userPhoneNoFocusNode,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "휴대폰 번호",
            hintText: '전화 번호 입력 예: +910000000000',
            hintStyle: TextStyle(fontSize: 13)),
        textInputAction: TextInputAction.next,
        validator: (phoneNo) {
          if (phoneNo.isEmpty) {
            return '휴대폰 번호를 입력하세요.';
          }
          return null;
        },
        onSaved: (phoneNo) => userPhoneNo = phoneNo,
        onFieldSubmitted: (_) {
          // fieldFocusChange(context, _user_idFocusNode, _user_pwFocusNode);
        },
      ),
    );
  }

  Widget SubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: RaisedButton(
          child: Text('찾기', style: TextStyle(fontSize: 21)),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              setState(() {
                _futureUser = createUser(userName, userPhoneNo);
              });
            }
          }),
    );
  }

  // 토스트 창
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER);
  }

  String str = '';

  Future<String> createUser(String name, String phone) async {
    final http.Response response = await http.post(
      'http://10.0.2.2:8080/search_id',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Charset': 'utf-8'
      },
      body: jsonEncode(<String, String>{'name': name, 'phone': phone}),
    );

    if (response.statusCode == 200) {
      str = response.body;
      return str;
    } else {
      throw Exception('Failed.' + response.statusCode.toString());
    }
  }
}
