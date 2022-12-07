import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    }
    return _db;
  }

  Future<Database> initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'todo.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 2,

   //   onUpgrade: _onUpgrade,
    );
    print('Data base is opend * * * * * * *');
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "tasks" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "time" TEXT NOT NULL,
    "status" TEXT NOT NULL
    )
    ''');
    print('create data base and tabls***********************');
  }

  // _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   print('onupgrade * * *  * *  *  ** * * * * * *  * * *  *  * ******');
  //   await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  // }

  // SELECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    // SELECT * FROM 'notes'
    return response;
  }

// INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!
        .rawInsert(sql); //"INSERT INTO 'notes' ('note') VALUES ('note one ')"
    return response;
  }

//UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!
        .rawUpdate(sql); //UPDATE 'notes' SET 'note' = 'note six' WHERE id = 1
    return response;
  }

//DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response =
        await mydb!.rawDelete(sql); //DELETE  FROM 'notes' WHERE id = 2
    return response;
  }

  myDeleteDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'dodo.db');
    await deleteDatabase(path);
  }

  //-----------------------------advanced-----------------------
  // SELECT
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table); //SELECT * FROM 'notes'
    return response;
  }

// INSERT
  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(
        table, values); //"INSERT INTO 'notes' ('note') VALUES ('note one ')"
    return response;
  }

//UPDATE
  Future<int> update(String table, Map<String, Object?> values, String myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values,
        where: myWhere); //UPDATE 'notes' SET 'note' = 'note six' WHERE id = 1
    return response;
  }

//DELETE
  Future<int> delete(String table, String myWhere) async {
    Database? mydb = await db;
    int response = await mydb!
        .delete(table, where: myWhere); //DELETE  FROM 'notes' WHERE id = 2
    return response;
  }
}
