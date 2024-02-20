import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'card.dart';
import 'profile.dart';

class GenerateQRScreen extends StatelessWidget {
  const GenerateQRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Testing QR Creation',
            ),
            QrImageView(
              data: businessCard.getCardID().toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
