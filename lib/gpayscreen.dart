/// Copyright 2023 Google LLC
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     https://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pay/pay.dart';

import 'payment_configurations.dart' as payment_configurations;

void main() {
  runApp(PayMaterialApp());
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class PayMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay for Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:[
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('de', ''),
      ],
      home: PaySampleApp(),
    );
  }
}
class PaySampleApp extends StatefulWidget {
  PaySampleApp({Key? key}) : super(key: key);
  @override
  _PaySampleAppState createState() => _PaySampleAppState();
}
class _PaySampleAppState extends State<PaySampleApp> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('gpay.json');
  }
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }
  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('T-shirt Shop'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding:EdgeInsets.symmetric(horizontal: 20),
        children:[
         Text(
            'Amanda\'s Polo Shirt',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
         Text(
            '\$50.20',
            style: TextStyle(
              color: Color(0xff777777),
              fontSize: 15,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'A versatile full-zip that you can wear all day long and even...',
            style: TextStyle(
              color: Color(0xff777777),
              fontSize: 15,
            ),
          ),
          // Example pay button configured using an asset
          FutureBuilder<PaymentConfiguration>(
              future: _googlePayConfigFuture,
              builder: (context, snapshot) => snapshot.hasData
                  ? GooglePayButton(
                paymentConfiguration: snapshot.data!,
                paymentItems: _paymentItems,
                type: GooglePayButtonType.pay,
                margin:EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator:Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  :SizedBox.shrink()),
          // Example pay button configured using a string
          ApplePayButton(
            paymentConfiguration:PaymentConfiguration.fromJsonString(payment_configurations.defaultApplePay),
            paymentItems: _paymentItems,
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,
            margin:EdgeInsets.only(top: 15.0),
            onPaymentResult: onApplePayResult,
            loadingIndicator:Center(
              child: CircularProgressIndicator(),
            ),
          ),
         SizedBox(height: 15)
        ],
      ),
    );
  }
}



