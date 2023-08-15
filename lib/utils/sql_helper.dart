import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        'CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, full_name TEXT, email TEXT, password TEXT,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,updatedAt TIMESTAMP  DEFAULT CURRENT_TIMESTAMP)');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS assets(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, asset_name TEXT, asset_type TEXT, quantity INTEGER, createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updatedAt TIMESTAMP  DEFAULT CURRENT_TIMESTAMP)');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('assets.db', version: 1,
        onCreate: (db, version) async {
      await createTables(db);
    });
  }
//user queries
  //create a new user

  static Future<int> createUser(
      String full_name, String email, String password) async {
    final db = await SQLHelper.db();
    final dataToInsert = {
      'full_name': full_name,
      'email': email,
      'password': password
    };
    final id = await db.insert('user', dataToInsert);
    return id;
  }

  //read all users

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await SQLHelper.db();
    final users = await db.query('user', orderBy: "id");
    return users;
  }

  //get by userId
  static Future<List<Map<String, dynamic>>> getUserById(int id) async {
    final db = await SQLHelper.db();
    final user = await db.query('user', where: "id = ?", whereArgs: [id]);
    return user;
  }

  //update user

  static Future<int> updateUser(
      int id, String full_name, String email, String password) async {
    final db = await SQLHelper.db();
    final dataToUpdate = {
      'full_name': full_name,
      'email': email,
      'password': password,
      'updateAt': DateTime.now().toString()
    };
    final user =
        await db.update('user', dataToUpdate, where: "id = ?", whereArgs: [id]);
    return user;
  }

  //delete user
  static Future<void> deleteUser(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('user', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print(err);
    }
  }

  //login
  static Future<bool> login(String email, String password) async {
    final db = await SQLHelper.db();
    final user = await db.query('user',
        where: "email = ? AND password = ?", whereArgs: [email, password]);
    return user.isNotEmpty;
  }

  //assets
  //create asset
  static Future<int> createAsset(
    String asset_name,
    String asset_type,
    int quantity,
  ) async {
    final db = await SQLHelper.db();
    final dataToInsert = {
      'asset_name': asset_name,
      'asset_type': asset_type,
      'quantity': quantity,
    };
    final id = await db.insert('assets', dataToInsert);
    return id;
  }

  //read all assets
  static Future<List<Map<String, dynamic>>> getAllAssets() async {
    final db = await SQLHelper.db();
    final assets = await db.query('assets', orderBy: "id");
    return assets;
  }

  //get asset by id

  static Future<List<Map<String, dynamic>>> getAssetById(int id) async {
    final db = await SQLHelper.db();
    final asset = await db.query('assets', where: "id = ?", whereArgs: [id]);
    return asset;
  }

  //edit asset

  static Future<int> updateAsset(
      int id, String asset_name, int quantity, String asset_type) async {
    final db = await SQLHelper.db();
    final dataToUpdate = {
      'asset_name': asset_name,
      'quantity': quantity,
      'asset_type': asset_type,
      'updatedAt': DateTime.now().toString()
    };
    final asset = await db
        .update('assets', dataToUpdate, where: "id = ?", whereArgs: [id]);
    return asset;
  }

  //delete asset

  static Future<void> deleteAsset(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('assets', where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print(err);
    }
  }
}
