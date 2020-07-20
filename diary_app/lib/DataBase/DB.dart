import 'package:diary_app/DataBase/DBMigrator.dart';
import 'package:diary_app/DataBase/DBTable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DB{

  String name="DiaryApp";
  int version=2;
  Future<Database>open()async{
    String path=join(await getDatabasesPath(),name);
   return openDatabase(path,
    version: version,
    onConfigure:onConfigure,
    onCreate: onCreate,
   onUpgrade: onUpgrade);
  }
}

onUpgrade(Database database,int oldVersion,int newVersion){
  if(oldVersion<newVersion){
    print("actualizar antigua $oldVersion nueva $newVersion");
    DBMigrator.MIGRATION_SCRIPTS.forEach((script)async=>await database.execute(script));
  }

}

onCreate(Database db,int version)async{
  DBTable.TABLES.forEach((scrip) async=>await db.execute(scrip));
}

onConfigure(Database db)async{
  await db.execute("PRAGMA foreign_keys = ON");
}
