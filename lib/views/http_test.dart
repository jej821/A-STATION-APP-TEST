import 'dart:async'; // await 지원, 선언하지 않아도 이용가능
import 'dart:convert'; // JSON 데이터 처리 지원
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

/*class HttpTest extends StatefulWidget {
  HttpTest({Key key}) : super(key: key);

  @override
  HttpTestState createState() => HttpTestState();
}

class HttpTestState extends State<HttpTest> {
  var _text = "Http Example";

  // 웹 서버에서 데이터 수신
  void getHttp() async {
    var response = await http.get('http://10.0.2.2:8080/test');
        // 웹 서버로부터 정상(200) 데이터 수신
    if (response.statusCode == 200) {
        setState(() {
       _text = response.body;
        });
    }
    else{
      throw Exception('데이터 수신 실패!');
    }
  }


  void postHttp() async {
    Map<String, String> data = {
      'key1' : "key1 value",
      'key2' : "key2 value"
    };
    String body = json.encode(data);

    var response = await http.post(
        'http://10.0.2.2:8080/test',
      headers: <String, String> {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: data,
    );
  }

  @override
  void initState(){
    super.initState();
    postHttp();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: new Text(_text),
      ),
    );
  }
}*/

String str = '';
Future<String> createMember(String id, String pw) async {
  final http.Response response = await http.post(
    'http://10.0.2.2:8080/test',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    },
    body: jsonEncode(<String, String>{
     'id': id,
      'pw': pw,
    }),
  );

  if (response.statusCode == 200) {
    //print(json.decode(response.body));
    str = response.body;
    // return Member.fromJson(json.decode(response.body));
    return str;
  } else {
    throw Exception('Failed to create album.'+response.statusCode.toString());
  }
}


class Member {
  final String id;
  final String pw;

  Member({this.id, this.pw});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      pw: json['pw'],
    );
  }
}

void main() {
  runApp(HttpTest());
}

class HttpTest extends StatefulWidget {
  HttpTest({Key key}) : super(key: key);

  @override
  HttpTestState createState() {
    return HttpTestState();
  }
}

class HttpTestState extends State<HttpTest> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  Future<String> _futureMember;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureMember == null)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller1,
                decoration: InputDecoration(hintText: 'Enter ID'),
              ),
              TextField(
                controller: _controller2,
                decoration: InputDecoration(hintText: 'Enter PW'),
              ),
              RaisedButton(
                child: Text('Create Member'),
                onPressed: () {
                  setState(() {
                    _futureMember = createMember(_controller1.text, _controller2.text);
                  });
                },
              ),
            ],
          )
              : FutureBuilder<String>(
            future: _futureMember,
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
        )
    );
  }
}