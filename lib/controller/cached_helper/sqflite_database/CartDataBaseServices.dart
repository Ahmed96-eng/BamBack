import 'package:qattan/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../constant.dart';

class CartDataBaseServices {
  final String cartTable = 'cart_table';
  final String cartId = 'cartId';
  final String prodId = 'prodId';
  final String customerId = 'customerId';
  final String prodTitle = 'prodTitle';
  final String prodImage = 'prodImage';
  final String prodPrice = 'prodPrice';
  final String prodDateTime = 'proddateTime';
  final String prodQuantity = 'prodQuantity';
  final String prodSize = 'prodSize';
  final String prodColor = 'prodColor';

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
    String path = join(databasePath, "cart.db");
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $cartTable ($cartId TEXT PRIMARY KEY , $prodId TEXT NOT NULL, $customerId TEXT NOT NULL, $prodTitle TEXT NOT NULL, $prodImage TEXT NOT NULL, $prodPrice TEXT NOT NULL,$prodDateTime TEXT NOT NULL,$prodQuantity INTEGER NOT NULL,$prodSize TEXT NOT NULL,$prodColor TEXT NOT NULL)',
        );
      },
    );
    return db;
  }

  Future<int> addToCart(CartModel cart) async {
    var dbref = await db;
    var result = await dbref.insert(
      cartTable,
      cart.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("222222  $result");
    return result;
  }

  // Future addToCart({
  //   String? prodId,
  //   String? customerId,
  //   String? prodTitle,
  //   String? prodImage,
  //   String? prodPrice,
  //   String? prodDateTime,
  //   String? prodQuantity,
  //   String? prodSize,
  //   String? prodColor,
  // }) async {
  //   var dbref = await db;
  //   await dbref.transaction((txn) async {
  //     var result = await txn.rawInsert(
  //         'INSERT INTO $cartTable($prodId, $customerId, $prodTitle, $prodImage, $prodPrice, $prodDateTime,$prodQuantity, $prodSize, $prodColor) VALUES("$prodId", "$customerId", "$prodTitle","$prodImage", "$prodPrice", "$prodDateTime","$prodQuantity", "$prodSize", "$prodColor")');
  //     print('inserted1: $result');
  //     return result;
  //   });
  // }

  Future<int> updateCart(CartModel cart) async {
    var dbref = await db;
    var result = await dbref.update(cartTable, cart.toJson(),
        where: "$cartId = ?", whereArgs: [cart.cartId]);

    return result;
  }

  Future<int> deleteCart(String id) async {
    var dbref = await db;
    var result =
        await dbref.delete(cartTable, where: "$cartId = ?", whereArgs: [id]);
    // print("Delete result is  $result");
    return result;
  }

  Future<int> deleteAllCart() async {
    var dbref = await db;
    var result = await dbref.delete(cartTable);
    print("Delete All Carts result is  $result");
    return result;
  }

  Future<List<CartModel>> showAllCarts() async {
    var dbref = await db;
    List<Map<String, dynamic>> maps = await dbref.query(
      cartTable,
      where: "$customerId = ?",
      whereArgs: [userId],
      orderBy: "$prodDateTime DESC",
    );
    List<CartModel> cartList = maps.isNotEmpty
        ? maps.map((cart) => CartModel.fromJson(cart)).toList()
        : [];
    return cartList;
  }

  Future<List> showCarts() async {
    var dbref = await db;
    var result = await dbref.query(
      cartTable,
      orderBy: "$prodDateTime DESC",
      columns: [
        cartId,
        prodId,
        customerId,
        prodTitle,
        prodImage,
        prodPrice,
        prodDateTime,
        prodQuantity,
      ],
    );
    return result;
  }

  Future<int> getCount() async {
    var dbref = await db;
    var result = await dbref.rawQuery("SELECT COUNT(*) FROM $cartTable");
    return Sqflite.firstIntValue(result)!;
  }

  Future close() async {
    var dbref = await db;
    return dbref.close();
  }
}
