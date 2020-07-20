import 'package:diary_app/DataBase/DBTable.dart';

class DBMigrator{
  static const MIGRATION_SCRIPTS=[
    "ALTER TABLE ${DBTable.DIARY} ADD COLUMN color TEXT;"
  ];
}