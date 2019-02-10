import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("HackDavis Barcode Scanner"),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Container(
                child: new MaterialButton(
                  onPressed: scan, child: new Text("Scan")),
                padding: const EdgeInsets.all(8.0),
              ),
              new Text(barcode)
            ],
          ),
        )),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant he camera permission'; 
        });
      } else {
        setState(() => this.barcode = 'Unkown error: $e');
      } 
    } on FormatException {
      setState(() => this.barcode = 'null (User returned using the "back"- button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unkown error: $e');
    }
  }
}

