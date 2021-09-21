import 'package:qattan/constant.dart';
import 'package:qattan/model/favorite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoriteDataBaseServices {
  final String favoriteTable = 'favorite_table';
  final String prodId = 'prodId';
  final String favId = 'favId';
  final String customerId = 'customersId';
  final String prodTitle = 'prodFavTitle';
  final String prodImage = 'prodFavImage';
  final String prodPrice = 'prodFavPrice';
  final String prodDateTime = 'prodFavDateTime';

  static Database? _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await createDB();
    return _db!;
  }

  createDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "favorites.db");
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $favoriteTable ($prodId INTEGER PRIMARY KEY , $favId INTEGER NOT NULL, $customerId TEXT NULL, $prodTitle TEXT NULL, $prodPrice TEXT NULL, $prodImage TEXT NULL, $prodDateTime TEXT NULL)',
        );
      },
    );
    return db;
  }

  Future<int> addToFavorite(FavoriteModel favoriteModel) async {
    var dbref = await db;
    var result = await dbref.insert(
      favoriteTable,
      favoriteModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // var result = await dbref.rawInsert(
    //     'insert into $favoriteTable ($prodId,$favId,$customerId,$prodTitle,$prodPrice,$prodImage) values(${favoriteModel.prodId},${favoriteModel.favId},${favoriteModel.customerId},${favoriteModel.prodTitle},${favoriteModel.prodPrice},${favoriteModel.prodImage})');

    print("222222  $result");
    return result;
  }

  Future<int> deleteFavorite(int id) async {
    var dbref = await db;
    // var result =
    //     await dbref.delete(favoriteTable, where: "$favId = ?", whereArgs: [id]);
    var result = await dbref.rawDelete(
        'delete from $favoriteTable where $favId = ? and $customerId = ?',
        [id, userId]);
    // print("Delete result is  $result");
    return result;
  }

  // List<int> prodFavIds = [];

  Future<List<FavoriteModel>> showAllFavorites() async {
    var dbref = await db;
    List<Map<String, dynamic>> maps = await dbref.query(
      favoriteTable,
      where: "$customerId = ?",
      whereArgs: [userId],
      // orderBy: "$prodDateTime DESC"
    );
    List<FavoriteModel> favoriteList = maps.isNotEmpty
        ? maps.map((favorite) => FavoriteModel.fromJson(favorite)).toList()
        : [];
    // favoriteList.forEach((element) {
    //   prodFavIds.add(element.favId!);
    // });
    // print("favIds==> $prodFavIds");
    return favoriteList;
  }

  // Future<int> updateFavorite(FavoriteModel favoriteModel) async {
  //   var dbref = await db;
  //   var result = await dbref.update(favoriteTable, favoriteModel.toJson(),
  //       where: "$favId = ?", whereArgs: [favoriteModel.favId]);

  //   return result;
  // }

  Future<int> getCount() async {
    var dbref = await db;
    var result = await dbref.rawQuery("SELECT COUNT(*) FROM $favoriteTable");
    return Sqflite.firstIntValue(result)!;
  }

  Future close() async {
    var dbref = await db;
    return dbref.close();
  }
}
