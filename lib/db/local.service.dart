import 'package:printer_app/db/repository.dart';
import 'package:printer_app/model/dto/facture.dart';

class LocalService {
  final Repository _repository;

  LocalService(this._repository);

  //read facture to pay
  Future<List<Facture>> readFactureImpayeFromAgent() async {
    List<Facture> factures = [];
    List<Map<String, dynamic>> list = await _repository.readData('facture');
    for (var facture in list) {
      factures.add(Facture.fromJson(facture));
    }
    return factures;
  }

  //read facture by id
  Future<Facture> readFactureById(int factureid) async {
    return await _repository.readDataById('facture', factureid);
  }

  //Save Facture
  SaveFacture(Facture facture) async {
    return await _repository.insertData('facture', facture.toJson());
  }

  // delete Facture
  deleteFacture(factureId) async {
    return await _repository.deleteDataById('facture', factureId);
  }

  // update Facture
  updateFacture(facture) async {
    return await _repository.updateData('facture', facture);
  }
}
