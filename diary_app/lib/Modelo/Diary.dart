import 'package:diary_app/DataBase/CRUD.dart';
import 'package:diary_app/DataBase/DBTable.dart';

class Diary extends CRUD{
  int id;
  String type;
  String enterCode;
  Diary({this.id,this.type="",this.enterCode=""}):super(DBTable.DIARY);

  factory Diary.toObject(Map<dynamic,dynamic> data){
    return (data!=null)?Diary(
      id:data['id'],
      type: data['type'],
      enterCode: data['enterCode']
    ):Diary();
  }

  Map<String,dynamic>toMap(){
    return {
      'id':this.id,
      'type':this.type,
      'enterCode':this.enterCode
    };
  }

  getList(parsed){
    return (parsed as List).map((map)=>Diary.toObject(map)).toList();
  }

  save()async{
   this.id= await insert(this.toMap());
   return(this.id>0)?this:null;
  }

  Future<List<Diary>>getDiaries()async{
   var result= await query("SELECT * FROM ${DBTable.DIARY}");
   return getList(result);
  }

  checkEnterCode(String enterCode)async{
    var result=await query("SELECT * FROM ${DBTable.DIARY} WHERE id=? AND enterCode=? ",arguments: [this.id,enterCode]);
    return Diary.toObject(result[0]);
  }
}