import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyApp extends StatefulWidget {
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyApp> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FocusNode myFocusNode = FocusNode();

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
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo,
          // OPT를 보낼 전화 번호
          codeAutoRetrievalTimeout: (String verId) {
            // 주어진 전화 번호에 대한 전화 번호 확인 프로세스 시작
            // 지정된 전화 번호로 6자리 코드가 포함된 sms를 보내거나 사용자가 로그인하면 [verificationCompleted]가 호출
            this.verificationId = verId;
          },
          codeSent: smsOTPSent,
          // 코드를 전송하면 OTP를 입력하기 위해 대화 상자를 연다.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            // print(phoneAuthCredential);
            showToast('phoneAuthCredential');
          },
          verificationFailed: (AuthException error) {
            switch ('${error.code}') {
              case 'firebaseAuth':
                showToast(
                    '이 앱은 Firebase 인증을 사용할 권한이 없습니다. Firebase 콘솔에 올바른 패키지 이름과 SHA-1이 구성되어 있는지 확인하세요.');
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
          (await _auth.signInWithCredential(credential)).user;
      final FirebaseUser currentUser = await _auth.currentUser();
      if (user.uid == currentUser.uid) {
        showToast('인증 성공');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration:
                    InputDecoration(hintText: '전화 번호 입력 예: +910000000000'),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                verifyPhone();
              },
              child: Text('인증 코드 전송'),
              textColor: Colors.white,
              elevation: 7,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
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
