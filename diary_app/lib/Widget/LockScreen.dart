import 'package:diary_app/Modelo/Diary.dart';
import 'package:diary_app/Page/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LockScreen extends StatefulWidget{
  List<Diary>diaries;
  LockScreen(this.diaries);
  @override
  State<StatefulWidget> createState() =>LockScreenState(this.diaries);

}

class LockScreenState extends State<LockScreen>{
  List<Diary>diaries;
  LockScreenState(this.diaries);
  bool isNewDiary=false;
  TextEditingController ctrlType=TextEditingController();
  TextEditingController ctrlCode=TextEditingController();
  Diary dropDownValue=Diary();
  @override
  void initState() {
    isNewDiary=diaries==null;
    dropDownValue=(diaries!=null)?diaries[0]:Diary();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[
      Visibility(visible: !isNewDiary,child: dropDownButton(),),
      Visibility(visible:isNewDiary,child: TextFormField(
        decoration: InputDecoration(
            hintText: "Tipo de diario"
        ),
        keyboardType: TextInputType.text,
        controller: ctrlType,
      ),),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            hintText: "Codigo"
        ),
        keyboardType: TextInputType.text,
        controller: ctrlCode,
      ),
      FlatButton(color: Colors.pinkAccent,
        child: Text(isNewDiary?"Guardar":"Desbloquear",
        style: TextStyle(color: Colors.white,fontSize: 13),),
        onPressed: isNewDiary?save:unlock,
      )
    ],);
  }

  dropDownButton(){
    return (diaries!=null)?DropdownButton<Diary>(
      onChanged: onChangedDiary,
      value: dropDownValue,
      icon: Icon(Icons.arrow_drop_down),
      items: diaries.map<DropdownMenuItem<Diary>>((Diary value){
        return DropdownMenuItem<Diary>(
        value: value,
    child: Text(value.type),
        );
    }
    ).toList()):SizedBox.shrink();
  }
  onChangedDiary(Diary diary){
    setState(() {
      this.dropDownValue=diary;
    });
  }

  save()async{
    Diary diary=await Diary(type: ctrlType.text,enterCode: ctrlCode.text).save();
    if(diary!=null){
      goHome(diary);
    }
  }
  unlock()async{
    Diary diary=await dropDownValue.checkEnterCode(ctrlCode.text);
    if(diary!=null)goHome(diary);
  }
  goHome(Diary diary){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(diary)));
  }
}