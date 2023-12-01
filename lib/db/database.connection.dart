import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var path = join(await getDatabasesPath(), 'vhm_crud');
    await deleteDatabase(path);
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    // String sqlNewMembers =
    //     "CREATE TABLE newMembers (id INTEGER PRIMARY KEY, memberLastName TEXT, memberFirstName TEXT, memberPhone TEXT, memberDateOfEntry TEXT, memberInvitedBy TEXT, memberGender TEXT, churchId INTEGER, memberTypeId INTEGER);";
    // await database.execute(sqlNewMembers);

    String sqlFacture =
        "CREATE TABLE facture (id INTEGER PRIMARY KEY, numeroFacture TEXT, dateEdition TEXT, montantApayer REAL, montantPaye REAL, monnaie REAL, nomPatient TEXT, intervention TEXT, nomDocteur TEXT);";
    await database.execute(sqlFacture);
  }
}
