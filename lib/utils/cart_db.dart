import 'dart:async';
import 'package:path/path.dart';
import 'package:shradha_design/constant/CartConstants.dart';
import 'package:shradha_design/constant/logger.dart';
import 'package:shradha_design/response/orderlist/order_details_response.dart';
import 'package:shradha_design/response/orderlist/order_list_response.dart';
import 'package:shradha_design/response/product_details_response.dart';
import 'package:sqflite/sqflite.dart';


class ColumDb{

   static const String  PID="pid";
   static const String  TITLE="title";
   static const String  IMAGE="image";
   static const String  CODE="code";
   static const String  QNT="qantity";
   static const String  BOXTYPE="boxtype";
   static const String  SIZE="size";
   static const String  TNA="tna";
   static const  String  PACKING="packing";
   static const  String  PRICE="price";
}


Future<Database> openDB() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'cart_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, pid TEXT,title TEXT,image TEXT,code TEXT,qantity TEXT,boxtype TEXT,size TEXT,tna TEXT,packing TEXT,price TEXT)",
      );
    },
    version: 1,
  );
  return database;
}

Future<bool> insertScore(ProductDetailsResponse response,String qty,String size,final database) async {
  final Database db = await database;

  Map<String,String> dd=Map();


  dd[ColumDb.PID]=response.data.id.toString();
  dd[ColumDb.TITLE]=response.data.title.toString();
  dd[ColumDb.IMAGE]=response.data.productImages[0].toString();
  dd[ColumDb.CODE]=response.data.productCode.toString();
  //dd[ColumDb.QNT]=response.data.qty.toString();
  dd[ColumDb.QNT]=qty;
  dd[ColumDb.BOXTYPE]=(response.data.sellingType!=null && response.data.sellingType.length!=0)?response.data.sellingType.toString():"";
 // dd[ColumDb.SIZE]=(response.data.sizeList!=null && response.data.sizeList.length!=0)?response.data.sizeList.toString():"";
  dd[ColumDb.SIZE]=size;
  dd[ColumDb.TNA]=response.data.tna.toString();
  dd[ColumDb.PRICE]=response.data.price.toString();
  dd[ColumDb.PACKING]=response.data.packing.toString();

  print("xxxxxx :"+dd.toString());

  await db.insert(
    'cart',
    dd,
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );

  return true;
}




Future<bool> insertOrderData(OrderDetail order_detail,final database) async {
  final Database db = await database;

  Map<String,String> dd=Map();

  await deleteScore(order_detail.productId.toString(), database);

  dd[ColumDb.PID]=order_detail.productId.toString();
  dd[ColumDb.TITLE]=order_detail.productTitle.toString();
  dd[ColumDb.IMAGE]=order_detail.imageName.toString();


  List<String> sizeList=[];
  List<String> qtyList=[];

  if(order_detail.quantityType!=null && order_detail.quantityType.length!=0){

    order_detail.quantityType.forEach((element) {

      sizeList.add(element.type);
      qtyList.add(element.value);

    });

    dd[ColumDb.QNT]=qtyList.toString();
    dd[ColumDb.SIZE]=sizeList.toString();

  }else{

    dd[ColumDb.QNT]="["+order_detail.quantity.toString()+"]";
    dd[ColumDb.SIZE]="[Qty]";

  }


  dd[ColumDb.TNA]=order_detail.tna.toString();
  dd[ColumDb.PRICE]=order_detail.price.toString();
  dd[ColumDb.PACKING]=order_detail.packing.toString();

  print("xxxxxx :"+dd.toString());

  await db.insert(
    'cart',
    dd,
    conflictAlgorithm: ConflictAlgorithm.ignore,
  );

  return true;
}




Future<List<CartConstants>> cart(final database) async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('cart');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {




    return CartConstants(id:  maps[i]['id'].toString(),
        pid:  maps[i][ColumDb.PID],
        title:  maps[i][ColumDb.TITLE],
        image:  maps[i][ColumDb.IMAGE],
        code: maps[i][ColumDb.CODE],
        qnt:  maps[i][ColumDb.QNT],
        boxtype:  maps[i][ColumDb.BOXTYPE],
        size:  maps[i][ColumDb.SIZE],
        tna:  maps[i][ColumDb.TNA],
        price: maps[i][ColumDb.PRICE],
        packing:  maps[i][ColumDb.PACKING]
    );



  });
}



Future<bool> updateScore(String pid, final database,String qty) async {

  // get a reference to the database
  // because this is an expensive operation we use async and await
  Database db = await database;



  Map<String,String> dd=Map();


  //dd[ColumDb.PID]=response.id.toString();
  //dd[ColumDb.TITLE]=response.title.toString();
 // dd[ColumDb.IMAGE]=response.image.toString();
 // dd[ColumDb.CODE]=response.code.toString();
  dd[ColumDb.QNT]=qty;

 // dd[ColumDb.BOXTYPE]=response.boxtype.toString();
 // dd[ColumDb.SIZE]=response.size.toString();
 // dd[ColumDb.TNA]=response.tna.toString();
 // dd[ColumDb.PRICE]=response.price.toString();
 // dd[ColumDb.PACKING]=response.packing.toString();




  // do the update and get the number of affected rows
  int updateCount = await db.update(
      'cart',
      dd,
      where: '${ColumDb.PID} = ?',
      whereArgs: [pid]);

  // show the results: print all rows in the db
  print(await db.query('cart'));


  return true;

}



/*
Future<void> updateScore(String dataId, final database) async {
  // Get a reference to the database.
  final db = await database;

  // Update the given Dog.
  await db.update(
    'cart',
    dataId,
    // Ensure that the Dog has a matching id.
    where: "pid = ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [score.id],
  );
}
*/


Future<bool> deleteScore(String id, final database) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Dog from the database.
  await db.delete(
    'cart',
    // Use a `where` clause to delete a specific dog.
    where: ColumDb.PID +"= ?",
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
  

  LogCustom.logd("xxxxxxxxx : delete:");

  return true;

}

Future<bool> deletetable( final database) async {
  // Get a reference to the database.
  final db = await database;


  await db.delete('cart');

  return true;

}




/*
void manipulateDatabase(CartConstants scoreObject, final database) async {
  await insertScore(scoreObject, database);
  print(await cart(database));
}
*/
