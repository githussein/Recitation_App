import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Zekr.dart';

class DatabaseHelper {
  static final _databaseName = "azkar_database.db";
  static final _databaseVersion = 1;

  static final favoritesTable = 'favorites';
  static final misbahaTable = 'misbaha';

  static final columnId = 'id';
  static final columnTitle = 'title';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    //Create a table for favorites dynamic list
    await db.execute('''
          CREATE TABLE $favoritesTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle FLOAT NOT NULL
          )
          ''');

    //Create a table for Misbaha dynamic list
    await db.execute('''
       create table $misbahaTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnTitle FLOAT NOT NULL
       )
       ''');

    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('استغفر الله');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('سبحان الله');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('الحمد لله');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('لا إله إلا الله');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('الله أكبر');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('لا حول ولا قوة إلا بالله');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('اللهم صلّ على نبينا محمد');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('سبحان الله وبحمده');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('لا إله إلا أنت سبحانك إني كنت من الظالمين');
    ''');
    await db.execute('''
      INSERT INTO $misbahaTable ($columnTitle) VALUES('وأفوّض أمري إلى الله');
    ''');
  }

  Future<int> insert(Zekr zekr, String tableName) async {
    Database db = await instance.database;
    var res = await db.insert(tableName, zekr.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await instance.database;
    var res = await db.query(tableName, orderBy: "$columnId");
    return res;
  }

  Future<int> delete(int id, String tableName) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> clearTable(String tableName) async {
    Database db = await instance.database;
    return await db.rawQuery("DELETE FROM $tableName");
  }
}
