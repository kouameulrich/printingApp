class Facture {
  int id = 0;
  String? numeroFacture;
  String? dateEdition;
  double? montantApayer;
  double? montantPaye;
  double? monnaie;
  String? nomPatient;
  String? intervention;
  String? nomDocteur;

  Facture({
    required this.id,
    this.numeroFacture,
    this.dateEdition,
    this.montantApayer,
    this.montantPaye,
    this.monnaie,
    this.nomPatient,
    this.intervention,
    this.nomDocteur,
  });

  Facture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numeroFacture = json['numeroFacture'];
    dateEdition = json['dateEdition'];
    montantApayer = json['montantApayer'];
    montantPaye = json['montantPaye'];
    monnaie = json['monnaie'];
    nomPatient = json['nomPatient'];
    intervention = json['intervention'];
    nomDocteur = json['nomDocteur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['numeroFacture'] = numeroFacture;
    data['dateEdition'] = dateEdition;
    data['montantApayer'] = montantApayer;
    data['montantPaye'] = montantPaye;
    data['monnaie'] = monnaie;
    data['intervention'] = intervention;
    data['nomDocteur'] = nomDocteur;
    return data;
  }
}
