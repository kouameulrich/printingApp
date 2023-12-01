// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printer_app/db/local.service.dart';
import 'package:printer_app/di/service_locator.dart';
import 'package:printer_app/misc/printer_service.dart';
import 'package:printer_app/model/dto/facture.dart';
import 'package:printer_app/ui/pages/home.page.dart';
import 'package:printer_app/ui/pages/printing.page.dart';
import 'package:printer_app/widgets/Text.Zone.dart';
import 'package:printer_app/widgets/Zone.Saisie.dart';
import 'package:printer_app/widgets/default.colors.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class FacturePage extends StatefulWidget {
  const FacturePage({super.key});

  @override
  State<FacturePage> createState() => _FacturePageState();
}

class _FacturePageState extends State<FacturePage> {
  final _formKey = GlobalKey<FormState>();
  final dbHandler = locator<LocalService>();
  final printerService = locator<PrinterService>();

  Facture? facture;
  int _factureCounter = 0;

  TextEditingController nomPatientController = TextEditingController();
  TextEditingController interventionController = TextEditingController();
  TextEditingController coutController = TextEditingController();
  TextEditingController montantPayeController = TextEditingController();
  TextEditingController monnaieController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Ajoutez l'écouteur au contrôleur du montant payé
    montantPayeController.addListener(() {
      updateMonnaieField();
    });
  }

  void updateMonnaieField() {
    double cout = double.tryParse(coutController.text) ?? 0;
    double montantPaye = double.tryParse(montantPayeController.text) ?? 0;
    double monnaie = montantPaye - cout;

    // Mettez à jour le champ "Monnaie" avec le résultat
    monnaieController.text = monnaie.toStringAsFixed(2);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Defaults.blueFondCadre,
      appBar: AppBar(
        backgroundColor: Defaults.blueAppBar,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('NOUVELLE FACTURE'),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Defaults.blueFondCadre),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Theme(
                  data: ThemeData(primarySwatch: Defaults.primaryBleuColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 13, right: 13),
                        child: Column(
                          children: [
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Nom du patient')),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ZoneSaisie(context, nomPatientController),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Intervention')),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextZone(context, interventionController),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // Champs de saisie pour le coût
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Coût')),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: coutController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Defaults.white,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Defaults.white),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Defaults.white),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'Entrez le montant payé',
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // Champs de saisie pour le montant payé
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Montant payé')),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: montantPayeController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Defaults.white,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Defaults.white),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Defaults.white),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'Entrez le montant réçu',
                                ),
                                keyboardType: TextInputType.number,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Entrer un montant';
                                //   } else if (double.parse(value) >
                                //       double.parse(coutController.toString())) {
                                //     return 'Entrer un montant supérieur ou égal à ${double.parse(coutController.toString())}';
                                //   } else if (double.parse(value) < 100) {
                                //     return 'Entrer un montant superieur ou égal à 100';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            // Champs de saisie pour la monnaie
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Monnaie')),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: monnaieController,
                                enabled: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Defaults.white,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Defaults.white),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Defaults.white),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  hintText: 'Montant de la monnaie',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 0, right: 0, top: 15),
                              child: ElevatedButton(
                                onPressed: () async {
                                  onSave();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Defaults.bluePrincipal)),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 15, left: 0, right: 0, top: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.save_alt_rounded,
                                        color: Defaults.white,
                                      ),
                                      Text(
                                        'Valider',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Defaults.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSave() async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    if (_formKey.currentState!.validate()) {
      // Calcule automatique de la monnaie en fonction du coût et du montant payé
      double cout = double.parse(coutController.text.toString());
      double montantPaye = double.parse(montantPayeController.text.toString());

      // Générer un numéro de facture dans le format FAC-000000-CDI
      String numeroFacture =
          'FAC-${_factureCounter.toString().padLeft(6, '0')}-CDI';

      // Incrémenter le compteur pour le prochain numéro de facture
      _factureCounter++;

      // Affichez une boîte de dialogue de confirmation si le membre n'existe pas
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Alerte Nouvelle Facture',
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              height: 150,
              child: Column(
                children: [
                  Lottie.asset(
                    'animations/notifs.json',
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.cover,
                    height: 110,
                  ),
                  const Text(
                    'Voulez-vous valider la facture ?',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Non'),
              ),
              TextButton(
                onPressed: () async {
                  facture = Facture(
                    id: Random().nextInt(50),
                    dateEdition: dateFormat.format(DateTime.now()),
                    intervention: interventionController.text,
                    monnaie: double.parse(monnaieController.text.toString()),
                    montantApayer: double.parse(coutController.text.toString()),
                    montantPaye:
                        double.parse(montantPayeController.text.toString()),
                    nomDocteur: 'Dr Hilaire KOUAKOU',
                    nomPatient: nomPatientController.text,
                    numeroFacture: numeroFacture,
                  );
                  await dbHandler.SaveFacture(facture!);
                  pw.Document docPage1 =
                      await printerService.printFacture(facture!);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => PrintingPage(docPage: docPage1),
                  //     ));
                },
                child: const Text('Oui'),
              )
            ],
          );
        },
      );

      print('Membre enregistré');
    }
  }
}
