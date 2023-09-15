import 'package:flutter/material.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

void main() {
  runApp(const Qrcode());
}

/// Creates The UPI Payment QRCode
class Qrcode extends StatefulWidget {
  const Qrcode({Key? key}) : super(key: key);

  @override
  State<Qrcode> createState() => _MyAppState();
}

class _MyAppState extends State<Qrcode> {
  //TODO Change UPI ID
  final upiDetails = UPIDetails(
      upiID: "jack.sardhara01@okicici",
      payeeName: "Jay Sardhara",
      amount:1,
      transactionNote: "Hello World");
  final upiDetailsWithoutAmount = UPIDetails(
    upiID: "jack.sardhara01@okicici",
    payeeName: "Jay Sardhara",
    transactionNote:"vayo ja",

  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:Text('UPI Payment QRCode Generator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text("UPI Payment QRCode without Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              UPIPaymentQRCode(
                upiDetails: upiDetailsWithoutAmount,
                size:220,
                embeddedImagePath: 'assets/images/logo.png',
                embeddedImageSize:Size(60, 60),
                eyeStyle:QrEyeStyle(
                  eyeShape: QrEyeShape.circle,
                  color: Colors.black,
                ),
                dataModuleStyle:QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: Colors.black,
                ),
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color:Colors.grey[600], letterSpacing: 1.2),
              ),
              SizedBox(
                height: 20,
              ),
              Text("UPI Payment QRCode with Amount",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              UPIPaymentQRCode(
                upiDetails: upiDetails,
                size: 220,
                upiQRErrorCorrectLevel: UPIQRErrorCorrectLevel.low,
              ),
              Text(
                "Scan QR to Pay",
                style: TextStyle(color: Colors.grey[600], letterSpacing: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}