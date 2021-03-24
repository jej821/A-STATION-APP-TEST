import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QRCode extends StatefulWidget {
  QRCodeState createState() => QRCodeState();
}
class QRCodeState extends State<QRCode>{
  String qrcode = "오른쪽 아래 카메라 버튼을 클릭해 QR코드를 스캔하세요.";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('QR Code Reader'),
          backgroundColor: Colors.black,
        ),
      body: Center(
              child: Text(qrcode, style: TextStyle(color: Colors.red),),
    )
        ,
      // 플로팅 액션 버튼으로 qr 스캔 함수 생성
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => scan(),
        tooltip: 'scan',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.qrcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.qrcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.qrcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qrcode = 'Unknown error: $e');
    }
  }
}