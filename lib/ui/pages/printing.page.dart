import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printer_app/ui/pages/home.page.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintingPage extends StatefulWidget {
  //pw.Document docPage;
  PrintingPage({Key? key}) : super(key: key);

  @override
  State<PrintingPage> createState() => _PrintingPageState();
}

class _PrintingPageState extends State<PrintingPage> {
  // PrintingPage({Key? key, required this.docPage}) : super(key: key);
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  List<BluetoothDevice> _devices = [];

  String _devicesMsg = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {initPrinter()});
  }

  Future<void> initPrinter() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));

    if (!mounted) return;
    bluetoothPrint.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val.cast<BluetoothDevice>());

      if (_devices.isEmpty)
        setState(() {
          _devicesMsg = "No Devices";
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              )),
        ),
        centerTitle: true,
        title: const Text('Preview Page'),
      ),
      // body: PdfPreview(
      //   build: (format) => docPage.save(),
      //   allowPrinting: true,
      //   allowSharing: true,
      //   initialPageFormat: PdfPageFormat.a6,
      //   pdfFileName: 'Recu.pdf',
      // ),
    );
  }
}
