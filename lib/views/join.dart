import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 데이터 처리 지원

class Join extends StatefulWidget {
  @override
  JoinState createState() => JoinState();
}

class JoinState extends State<Join> {
  final _formKey = GlobalKey<FormState>();
  String _user_id, _user_name, _user_pw, _user_pw_check, _user_phone_no = '';
  FocusNode _user_idFocusNode = FocusNode();
  FocusNode _user_nameFocusNode = FocusNode();
  FocusNode _user_pwFocusNode = FocusNode();
  FocusNode _user_pw_checkFocusNode = FocusNode();
  FocusNode _user_phone_numberFocusNode = FocusNode();

  // SMS 인증을 위한 변수들
  String phoneNo;
  String smsOTP;
  String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance; // 검증해주는 객체
  bool _isAuthPhone = false; // 인증이 완료되면 true

  Future<String> _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          // resizeToAvoidBottomPadding: false,
          appBar: AppBar(title: Text('회원가입')),
          body: new Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 20.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: (_futureUser == null)
                      ? Column(children: <Widget>[
                          InputUserIdContainer(),
                          SizedBox(
                            height: 16,
                          ),
                          InputUserNameContainer(),
                          SizedBox(
                            height: 16,
                          ),
                          InputUserPwContainer(),
                          SizedBox(
                            height: 16,
                          ),
                          InputUserPwCheckContainer(),
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
                )),
          )
    );
  }

  Widget InputUserIdContainer() {
    return Container(
      width: 300,
      child: TextFormField(
        focusNode: _user_idFocusNode,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "아이디",
        ),
        textInputAction: TextInputAction.next,
        validator: (id) {
          if (id.isEmpty) {
            return '아이디를 입력하세요.';
          }
          return null;
        },
        onSaved: (id) => _user_id = id,
        onFieldSubmitted: (_) {
          // fieldFocusChange(context, _user_idFocusNode, _user_pwFocusNode);
        },
      ),
    );
  }

  Widget InputUserNameContainer() {
    return Container(
      width: 300,
      child: TextFormField(
        focusNode: _user_nameFocusNode,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "이름",
        ),
        textInputAction: TextInputAction.next,
        validator: (name) {
          if (name.isEmpty) {
            return '이름 입력하세요.';
          }
          return null;
        },
        onSaved: (name) => _user_name = name,
        onFieldSubmitted: (_) {
          // fieldFocusChange(context, _user_idFocusNode, _user_pwFocusNode);
        },
      ),
    );
  }

  Widget InputUserPwContainer() {
    return Container(
      width: 300,
      child: TextFormField(
        focusNode: _user_pwFocusNode,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        obscureText: true,
        // 비밀번호 입력
        maxLength: 15,
        decoration: InputDecoration(
          labelText: "비밀번호",
        ),
        textInputAction: TextInputAction.next,
        validator: (password) {
          if (password.isEmpty) {
            return '비밀번호를 입력하세요.';
          }
          return null;
        },
        onChanged: (password) {
          _user_pw = password;
        },
        onSaved: (password) => _user_pw = password,
        onFieldSubmitted: (_) {
          //fieldFocusChange(context, _user_idFocusNode, _emailFocusNode);
        },
      ),
    );
  }

  Widget InputUserPwCheckContainer() {
    return Container(
      width: 300,
      child: TextFormField(
        focusNode: _user_pw_checkFocusNode,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        obscureText: true,
        // 비밀번호 입력
        maxLength: 15,
        decoration: InputDecoration(
          labelText: "비밀번호 확인",
        ),
        textInputAction: TextInputAction.next,
        validator: (password) {
          if (password.isEmpty) {
            return '비밀번호 확인을 입력하세요.';
          } else {
            if (password != _user_pw) {
              return '비밀번호와 비밀번호 확인이 일치하지 않습니다.';
            }
          }
          return null;
        },
        onSaved: (password) => _user_pw_check = password,
        onFieldSubmitted: (_) {
          //fieldFocusChange(context, _user_idFocusNode, _emailFocusNode);
        },
      ),
    );
  }

  Widget InputUserPhoneNumberContainer() {
    return Container(
        width: 300,
        child: Row(children: <Widget>[
          Container(
              width: 220,
              child: TextFormField(
                focusNode: _user_phone_numberFocusNode,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "휴대폰 번호",
                    hintText: '전화 번호 입력 예: +910000000000',
                    hintStyle: TextStyle(fontSize: 13)),
                textInputAction: TextInputAction.next,
                validator: (phoneNo) {
                  if (phoneNo.isEmpty)
                    return '휴대폰 번호를 입력하세요.';
                  else {
                    if (_isAuthPhone == false) return '휴대폰 인증을 해주세요.';
                  }
                  return null;
                },
                onChanged: (phoneNo) {
                  this.phoneNo = phoneNo;
                },
                onSaved: (phoneNo) => _user_phone_no = phoneNo,
                onFieldSubmitted: (_) {
                  //fieldFocusChange(context, _user_idFocusNode, _emailFocusNode);
                },
              )),
          SizedBox(width: 10),
          Container(
              width: 70,
              alignment: Alignment.center,
              child: RaisedButton(
                disabledColor: Colors.black,
                child: Text('전송',
                    style: TextStyle(
                      fontSize: 10,
                    )),
                onPressed: () {
                  verifyPhone();
                },
              ))
        ]));
  }

  Widget SubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: RaisedButton(
          child: Text('회원가입', style: TextStyle(fontSize: 21)),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              setState(() {
                _futureUser =
                    createUser(_user_id, _user_pw, _user_name, _user_phone_no);
              });
            }
          }),
    );
  }

  // Firebase 관련
  Future<void> verifyPhone() async {
    // Firebase가 제공된 전화 번호로 SMS 코드를 보낼 때 처리하기 위한 typedef
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context);
/*      smsOTPDialog(context).then((value) {
        // print('sign in');
        showToast('sign in $value');
      });*/
    };

    try {
      // 핸드폰 번호 검증
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          // OPT를 보낼 전화 번호
          codeAutoRetrievalTimeout: (String verId) {
            // 주어진 전화 번호에 대한 전화 번호 확인 프로세스 시작
            // 지정된 전화 번호로 6자리 코드가 포함된 sms를 보내거나 사용자가 로그인하면 [verificationCompleted]가 호출
            this.verificationId = verId;
          },
          // 코드를 전송하면 OTP를 입력하기 위해 대화 상자를 연다.
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            // print(phoneAuthCredential);
            showToast('phoneAuthCredential');
          },
          verificationFailed: (AuthException error) {
            switch ('${error.code}') {
              case 'firebaseAuth':
                // showToast('이 앱은 Firebase 인증을 사용할 권한이 없습니다. Firebase 콘솔에 올바른 패키지 이름과 SHA-1이 구성되어 있는지 확인하세요.');
                showToast('Firebase에 등록된 전화번호가 아닙니다.');
                break;
              case 'invalidCredential':
                showToast(
                    '잘못된 전화 번호 형식입니다. [+] [국가 번호] [지역 번호를 포함한 가입자 번호] 형식으로 입력해 주세요.');
                break;
              default:
                showToast('${error.code}');
                break;
            }
          });
    } catch (e) {
      handleError(e);
    }
  }

  // 인증번호 입력 Dialog
  FocusNode myFocusNode = FocusNode();

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('인증번호 입력'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  maxLength: 6,
                  focusNode: myFocusNode,
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
/*                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacementNamed('/homepage');
                      showToast('user != null');
                    } else {
                      signIn();
                    }
                  });
                },*/
                onPressed: () {
                  signIn();
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user; // 주어진 자격 증명
      final FirebaseUser currentUser =
          await _auth.currentUser(); // Firebase에 있는 사용자의 계정
      if (user.uid == currentUser.uid) {
        showToast('인증 성공');
        _isAuthPhone = true;
        Navigator.pop(context);
      } else {
        showToast('user.uid != currentUser.uid');
      }
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    // showToast(error.code);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        showToast('잘못된 인증 코드입니다. 다시 입력해 주세요.');
        FocusScope.of(context).requestFocus(myFocusNode);
        break;
      case 'error':
        showToast('null 입력');
        FocusScope.of(context).requestFocus(myFocusNode);
        break;
      default:
        showToast(error.message);
        break;
    }
  }
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

Future<String> createUser(
    String id, String pw, String name, String phone) async {
  final http.Response response = await http.post(
    'http://10.0.2.2:8080/test',
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Charset': 'utf-8'
    },
    body: jsonEncode(
        <String, String>{'id': id, 'pw': pw, 'name': name, 'phone': phone}),
  );

  if (response.statusCode == 200) {
    str = response.body;
    return str;
  } else {
    throw Exception('Failed.' + response.statusCode.toString());
  }
}
