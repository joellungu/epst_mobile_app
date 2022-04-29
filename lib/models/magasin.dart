import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Magasin {
  var database;

  Future<Database> openDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path1 = join(databasesPath, 'magasin.db');

    // Delete the database
    //await deleteDatabase(path1);

    // open the database
    database = await openDatabase(path1, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute("""CREATE TABLE magasin 
        (
          id VARCHAR,
          libelle VARCHAR,
          description TEXT,
          piecejointe VARCHAR,
          date VARCHAR,
          types VARCHAR,
          extention VARCHAR
        )""");
    });
    return database;
    /*
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
    */
  }

  savePlainte(Map<String, dynamic> plainte) async {
    List liste = plainte["piecejointe"];
    // Insert some records in a transaction
    await database!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
    });
// Close the database
  }
}
