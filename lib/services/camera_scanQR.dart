// ignore_for_file: unused_local_variable, prefer_const_constructors, camel_case_types, file_names, unnecessary_import, avoid_unnecessary_containers, await_only_futures, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Starter_Screen/RestaurentScreenAll/Scanned_QRCODE_Select.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(const MaterialApp(home: Camera_ScanQR()));

class Camera_ScanQR extends StatelessWidget {
  const Camera_ScanQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRViewExample(),
            ));
          },
          child: const Text('qrView'),
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  bool powerSwitch = false;
  @override
  Widget build(BuildContext context) {
    bool check = false;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: JumpingText("Searching QR CODE...     "),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(flex: 5, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (result != null)
                        /*Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}',
                          style: TextStyle(color: Colors.amber),
                        )*/
                        Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    side: BorderSide(
                                        width: 2,
                                        color: Color.fromARGB(255, 0, 255, 8))),
                                onPressed: () async {
                                  return Future.delayed(Duration(seconds: 0),
                                      () async {
                                    String? url = await result?.code.toString();
                                    String? format =
                                        await result?.format.toString();
                                    String? socialDistance =
                                        "Not find Social Distancing";
                                    url ??= "No Code";
                                    format ??= "No Format";
                                    if (url.contains("youtube.com")) {
                                      socialDistance = "youtube";
                                    } else if (url.contains("facebook.com")) {
                                      socialDistance = "facebook";
                                    } else if (url.contains("google.com")) {
                                      socialDistance = "google";
                                    } else if (url.contains("line.me")) {
                                      socialDistance = "line";
                                    } else if (url.contains("twich.com") ||
                                        url.contains("twich.tv")) {
                                      socialDistance = "twich";
                                    } else if (url.contains("/user/")) {
                                      socialDistance = "foodApp";
                                    } else if (url.contains("instagram.com")) {
                                      socialDistance = "instagram";
                                    } else {
                                      socialDistance = "Searching...";
                                    }
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Scanned_QRCODE(
                                                  url: url!,
                                                  format: format!,
                                                  socialDistance:
                                                      socialDistance!,
                                                )),
                                        (route) => false);
                                  });
                                },
                                child: Icon(
                                  Icons.next_week_sharp,
                                  size: MediaQuery.of(context).size.width / 15,
                                  color: Color.fromARGB(255, 0, 255, 8),
                                )),
                            Text(
                              "Scan Format : ${result?.format} | link : ${result?.code}",
                              style: TextStyle(color: Colors.amber),
                            )
                          ],
                        )
                      else
                        Text(
                          "กำลังสแกนหา QR Code ${result?.code == null ? "& BarCode" : ""}",
                          style: TextStyle(color: Colors.white),
                        ),
                      powerSwitch
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.all(8),
                                    child: FutureBuilder(
                                      future: controller?.getFlashStatus(),
                                      builder: (context, snapshot) {
                                        return FloatingActionButton(
                                            backgroundColor: Colors.white10,
                                            onPressed: () async {
                                              await controller?.toggleFlash();
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.flash_on_outlined,
                                              color: Colors.amber,
                                              size: 30,
                                            ));
                                      },
                                    )),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: FloatingActionButton(
                                      backgroundColor: Colors.white10,
                                      onPressed: () async {
                                        await controller?.flipCamera();
                                      },
                                      child: FutureBuilder(
                                        future: controller?.getCameraInfo(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data != null) {
                                            //describeEnum(snapshot.data! == "font")
                                            return Icon(
                                              Icons.flip_camera_ios_outlined,
                                              color: Color.fromARGB(
                                                  255, 92, 203, 255),
                                              size: 30,
                                            );
                                          } else {
                                            return const Text('loading');
                                          }
                                        },
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: FloatingActionButton(
                                      backgroundColor: Colors.white10,
                                      onPressed: () async {
                                        await controller?.pauseCamera();
                                      },
                                      child: FutureBuilder(
                                        future: controller?.getCameraInfo(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data != null) {
                                            //describeEnum(snapshot.data! == "font")
                                            return Icon(Icons.pause);
                                          } else {
                                            return const Text('loading');
                                          }
                                        },
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  child: FloatingActionButton(
                                      backgroundColor: Colors.white10,
                                      onPressed: () async {
                                        await controller?.resumeCamera();
                                        setState(() {});
                                      },
                                      child: FutureBuilder(
                                        future: controller?.getCameraInfo(),
                                        builder: (context, snapshot) {
                                          if (snapshot.data != null) {
                                            //describeEnum(snapshot.data! == "font")
                                            return Icon(
                                              Icons.skip_next,
                                              size: 30,
                                            );
                                          } else {
                                            return const Text('loading');
                                          }
                                        },
                                      )),
                                ),
                              ],
                            )
                          : Center(
                              child: FloatingActionButton(
                                backgroundColor:
                                    Color.fromARGB(255, 11, 11, 11),
                                onPressed: () async {
                                  await controller?.resumeCamera();
                                  powerSwitch = true;
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.power_settings_new,
                                  color: Color.fromARGB(255, 28, 213, 255),
                                  size: MediaQuery.of(context).size.width / 12,
                                ),
                              ),
                            )
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller?.pauseCamera();
                              },
                              child: const Text('pause',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller?.resumeCamera();
                              },
                              child: const Text('resume',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          )
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
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
          borderColor: Color.fromARGB(255, 255, 0, 0),
          borderRadius: MediaQuery.of(context).size.width / double.infinity,
          borderLength: 20,
          borderWidth: MediaQuery.of(context).size.width / 35,
          cutOutSize: MediaQuery.of(context).size.width / 1.3),
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
