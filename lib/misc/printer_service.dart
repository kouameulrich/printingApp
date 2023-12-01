import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printer_app/model/dto/facture.dart';

class PrinterService {
  printFacture(Facture facture) async {
    final docPage = pw.Document();
    final logoImage = pw.MemoryImage(
        (await rootBundle.load('images/logo.jpeg')).buffer.asUint8List());
    docPage.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Image(
              alignment: pw.Alignment.center,
              height: 100,
              width: 100,
              logoImage,
            ),
            pw.Divider(),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('${facture.numeroFacture}'),
                  pw.Text('${facture.dateEdition}')
                ]),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text('Intervention',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15)),
            pw.SizedBox(
              height: 10,
            ),
            pw.Row(children: [
              pw.Text('${facture.intervention}'),
            ]),
            pw.SizedBox(
              height: 10,
            ),
            pw.Text('Total: ${facture.montantApayer} FCFA'),
            pw.Text('Montant payé: ${facture.montantPaye}'),
            pw.Text('Monnaie: ${facture.monnaie}'),
            pw.SizedBox(
              height: 20,
            ),
            pw.Text('${facture.nomDocteur}'),
            pw.SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
    return docPage;
  }
}
