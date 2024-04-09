import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/constants/color.dart';
import 'package:demo_app/screens/qr_code_scanner/appointment_details.dart';
import 'package:demo_app/widgets/primary_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:velocity_x/velocity_x.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  bool isLoading = false;
  Map<String, dynamic>? documentData;

  void fetchDocument(String documentId) async {
    setState(() {
      isLoading = true;
    });

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('appointment')
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        setState(() {
          documentData = documentSnapshot.data() as Map<String, dynamic>;
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching document: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  result == null
                      ? const Text('Scan a code')
                      :
                      // Container(
                      //     height: 50,
                      //     // width: 60,
                      //     margin: const EdgeInsets.all(8),
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      //     child: const Text('See Details',
                      //         style: TextStyle(fontSize: 20)),
                      //     decoration: BoxDecoration(color: primaryColor),
                      //   ).onTap(() {
                      //     fetchDocument(result!.code!);
                      //     // print('hhhjhkhkhkjhhhjjjjjjjjjjjjjjjj');
                      //     Get.to(() => AppointmentDetails(
                      //           patientName: documentData!['appointmentName'],
                      //           phoneNo: documentData!['appointmentMobileNo'],
                      //           date: documentData!['appointmentDate'],
                      //           time: documentData!['appointmentTime'],
                      //         ));
                      //     controller?.pauseCamera();
                      //   }),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5),
                          child: PrimaryButton(
                              title: 'See Details',
                              isActive: true,
                              onTap: () {
                                fetchDocument(result!.code!);
                                Get.to(() => AppointmentDetails(
                                      patientName:
                                          documentData!['appointmentName'],
                                      phoneNo:
                                          documentData!['appointmentMobileNo'],
                                      date: documentData!['appointmentDate'],
                                      time: documentData!['appointmentTime'],
                                    ));
                                controller?.pauseCamera();
                              }),
                        ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.toggleFlash();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getFlashStatus(),
                  //             builder: (context, snapshot) {
                  //               return Text('Flash: ${snapshot.data}');
                  //             },
                  //           )),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(8),
                  //       child: ElevatedButton(
                  //           onPressed: () async {
                  //             await controller?.flipCamera();
                  //             setState(() {});
                  //           },
                  //           child: FutureBuilder(
                  //             future: controller?.getCameraInfo(),
                  //             builder: (context, snapshot) {
                  //               if (snapshot.data != null) {
                  //                 return Text(
                  //                     'Camera facing ${describeEnum(snapshot.data!)}');
                  //               } else {
                  //                 return const Text('loading');
                  //               }
                  //             },
                  //           )),
                  //     )
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.pauseCamera();
                      //     },
                      //     child: const Text('pause',
                      //         style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: SizedBox(
                          height: 30,
                          width: 80,
                          child: PrimaryButton(
                            title: 'Pause',
                            isActive: false,
                            onTap: () async {
                              await controller?.pauseCamera();
                            },
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.resumeCamera();
                      //     },
                      //     child: const Text('resume',
                      //         style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: SizedBox(
                          height: 30,
                          width: 80,
                          child: PrimaryButton(
                            title: 'Resume',
                            isActive: false,
                            onTap: () async {
                              await controller?.resumeCamera();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
