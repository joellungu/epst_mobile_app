import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ChatDB {
  Database? database;

  ChatDB() {
    openDB();
  }

  openDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path1 = join(databasesPath, 'plainte1.db');
    String path2 = join(databasesPath, 'plainte2.db');

    // Delete the database
    //await deleteDatabase(path1);

    // open the database
    database = await openDatabase(path1, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("""CREATE TABLE Plainte 
          (
          idmessage VARCHAR,
          provenance TEXT,
          telephoneprovenance TEXT, 
          emailprovenance TEXT,
          destinataire TEXT,
          provinceprovenance TEXT,
          message TEXT,
          idpiecejointe VARCHAR
        )""");
    });
    // open the database
    database = await openDatabase(path2, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("""CREATE TABLE Piecejoint 
          (
          idmessage VARCHAR,
          idpiecejointe TEXT,
          piece blob
        )""");
    });
  }

  savePlainte(Map<String, dynamic> plainte) async {
    // Insert some records in a transaction
    await database!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
    });
// Close the database
  }
}
