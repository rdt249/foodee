import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    @override
    void initState() {
        super.initState();
        startScanner();
    }

    String barcode = 'welcome';
    var scanner = new StreamController<String>();

    void readBarcode(reading) {
        if((reading != -1) && (reading != barcode)) {
            if(reading != '-1') {
                barcode = reading as String;
                scanner.add(barcode);
                HapticFeedback.lightImpact();
            }
        }
    }

    Future<void> startScanner() async {
        final stream = FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#FF4CAF50','Details',true,ScanMode.BARCODE);
        final subscription = stream!.listen(readBarcode);
    }

    Widget getDetails(String id) {
        if(id == 'welcome') return Text(id);
        var content = 'none';
        // var url = Uri.parse('https://world.openfoodfacts.org/api/v0/product/$id.json');
        // var response = http.get(url);
        // if (response.statusCode == 200) content = jsonDecode(response);
        // print(content);
        return Text(content);
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: "foodee",
            theme: ThemeData(primarySwatch: Colors.green),
            home: Scaffold(
                appBar: AppBar(title: const Text('Product Details')),

                body: StreamBuilder<String>(
                    stream: scanner.stream,
                    builder: (context, snapshot) {
                        print(snapshot.toString());
                        print(barcode);
                        return getDetails(barcode);
                    }
                ),

                floatingActionButton: FloatingActionButton.extended(
                    onPressed: () => startScanner(),
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan'),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            )
        );
    }
}