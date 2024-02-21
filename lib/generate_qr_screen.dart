import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'card.dart';
import 'profile.dart';

class GenerateQRScreen extends StatefulWidget {
  const GenerateQRScreen({Key? key}) : super(key: key);

  @override
  _GenerateQRScreenState createState() => _GenerateQRScreenState();
}

class _GenerateQRScreenState extends State<GenerateQRScreen> {
   //initialize userID variable
  String? userID = "";
  @override
  void initState() {
    super.initState();
    fetchUserID();
  }

  Future<void> fetchUserID() async {
    String userEmail = 'rzvn@example.com';
    String? id = await QueryFunctions.getID(userEmail);
    setState(() {
      userID = id;
    });

  }

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
              data: userID.toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
