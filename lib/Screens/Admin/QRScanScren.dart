import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tvis/constants.dart';

import '../../Widgets/overlay.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key});

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: kBorder,
                child: FloatingActionButton.extended(
                  heroTag: '1',
                  onPressed: () {},
                  icon: Icon(Icons.flash_on),
                  label: Text("Tourch"),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  MobileScanner(
                    allowDuplicates: true,
                    onDetect: ((barcode, args) {
                      String code = barcode.rawValue ?? '---';
                      if (!isScanned) {
                        isScanned = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Text(code),
                          ),
                        );
                      }
                    }),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: ShapeDecoration(
                        shape: QrScannerOverlayShape(
                          borderColor: Colors.white,
                          borderRadius: 10,
                          borderLength: 20,
                          borderWidth: 5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: kBorder,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Scan the Qr Code"),
                    Text("Scanning will be starting automatically"),
                    LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
