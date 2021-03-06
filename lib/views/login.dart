// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_charger_app/views/main_menu.dart';
import 'package:pro_charger_app/views/navi.dart';
import 'package:pro_charger_app/views/join.dart';
import 'package:pro_charger_app/views/search_id.dart';
import 'package:pro_charger_app/views/search_pw.dart';

class Login extends StatefulWidget
{
  @override
  State createState() => LoginState();
}

class LoginState extends State<Login> {
  String userName = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Column(
        children: <Widget>[
          makeRowContainer('아이디', true),
          makeRowContainer('비밀번호', false),
          Container(child: RaisedButton(
              child: Text('로그인', style: TextStyle(fontSize: 21)),
              onPressed: () {
                // 사용자 이름과 비밀번호가 일치한다면!
                if(userName == 'cas' && password == '1') {
                  // 세터로 초기화를 했기 때문에 build 함수 자동 호출하면서
                  // 아이디와 비밀번호 텍스트필드가 빈 문자열로 초기화된다.
                  setState(() {
                    userName = '';
                    password = '';
                  });
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MainMenu()));
                }
                else
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('일치하지 않습니다!!')));
              }
          ),
            margin: EdgeInsets.only(top: 12),
          ),
          Container(
            child: TextButton(
              child: Text('회원가입'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Join()));
              },
            )
          ),
          Container(
              child: TextButton(
                child: Text('아이디 찾기'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchID()));
                },
              )
          ),
          Container(
              child: TextButton(
                child: Text('비밀번호 찾기'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPW()));
                },
              )
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget makeRowContainer(String title, bool isUserName) {
    return Container(
      child: Row(
        children: <Widget>[
          makeText(title),
          makeTextField(isUserName),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.only(left: 60, right: 60, top: 8, bottom: 8),
    );
  }

  // Cascade 문법 사용. 주석으로 막은 코드보다 ..을 사용한 한 줄 코드가 훨씬 낫다.
  // Cascade 문법은 아래에서 따로 설명한다.
  Widget makeText(String title) {
    // var paint = Paint();
    // paint.color = Colors.green;

    return Text(
      title,
      style: TextStyle(
        fontSize: 21,
        //background: Paint()..color = Colors.green,
        // background: paint,
      ),
    );
  }

  Widget makeTextField(bool isUserName) {
    // TextField 위젯의 크기를 변경하고 padding을 주려면 Container 위젯 필요.
    // TextField 독자적으로는 할 수 없음.
    return Container(
      child: TextField(
        // TextField 클래스는 입력 내용을 갖고 있지 않고, TextEditingController 클래스에 위임.
        // 입력 내용에 접근할 때는 controller.text라고 쓰면 된다.
        // 여기서는 로그인에 성공했을 때 초기화를 위한 용도로만 사용한다. 아래처럼 초기값을 줄 수도 있다.
        // controller: TextEditingController()..text = '플러터',
        controller: TextEditingController(),
        style: TextStyle(fontSize: 21, color: Colors.black),
        textAlign: TextAlign.center,
        // 테두리 출력. enabledBorder 옵션을 사용하지 않으면 변경 불가.
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                //color: Colors.red,
                width: 0.0,
            ),
          ),
          contentPadding: EdgeInsets.all(12),
        ),
        onChanged: (String str) {
          // 입력이 변경될 때마다 갱신이 필요하지 않기 때문에 세터 사용 안함
          // 아이디와 비밀번호 중에서 하나를 갱신한다.
          if(isUserName)
            userName = str;
          else
            password = str;
        },
      ),
      // TextField 위젯의 크기를 설정하려면 Container 위젯을 부모로 가져야 한다.
      // 컨테이너의 크기가 텍스트필드의 크기가 된다.
      width: 200,
      padding: EdgeInsets.only(left: 16),
    );
  }
}
