import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:qr/widget/reloj.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/prueba2-8bf0c.appspot.com/o/logo2.jpg?alt=media&token=8b655399-4cd3-4c8b-b6ab-855280db1e19'),
              ),
              Text(
                "Nombre Empleado",
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "MARNOR",
                style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              //InfoCard(),
              GestureDetector(
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ListTile(
                        leading: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.teal,
                        ),
                        title: Text(
                          "Nombre: $_scanBarcode\n",
                          style: TextStyle(color: Colors.teal, fontSize: 20),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ListTile(
                        leading: Icon(
                          Icons.card_membership,
                          color: Colors.teal,
                        ),
                        title: Text(
                          "Cedula: $_scanBarcode\n",
                          style: TextStyle(color: Colors.teal, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: ElevatedButton(
                      onPressed: () => scanQR(),
                      child: Text("Marcar Entrada"),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: ElevatedButton(
                          onPressed: () {}, child: Text("Registrarse"))),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Reloj(),
              )
            ],
          ),
        ),
      )),
    );
  }
}
