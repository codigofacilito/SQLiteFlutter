import 'package:diary_app/Modelo/Diary.dart';
import 'package:diary_app/Modelo/Page.dart';
import 'package:flutter/material.dart';
typedef VoidCallbackParam(Page page);
class FormPage extends StatefulWidget{
  Diary diary;
  Page page;
  VoidCallbackParam voidCallbackParam;
  FormPage(this.voidCallbackParam,{this.diary,this.page});
  @override
  State<StatefulWidget> createState() => FormPageState(this.page);

}

class FormPageState extends State<FormPage>{
  Page page;
  TextEditingController ctrlDate=TextEditingController();
  TextEditingController ctrlTitle=TextEditingController();
  TextEditingController ctrlContent=TextEditingController();
  FormPageState(this.page);


  @override
  void initState() {
    if(page!=null){
      ctrlDate.text=page.date;
      ctrlTitle.text=page.title;
      ctrlContent.text=page.content;
    }else{
      ctrlDate.text=DateTime.now().toString().substring(0,11);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(child:Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              controller: ctrlDate,
              enabled: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Titulo"
              ),
              keyboardType: TextInputType.text,
              controller: ctrlTitle,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Contenido"
              ),
              keyboardType: TextInputType.text,
              controller: ctrlContent,
            ),
            FlatButton(color: Colors.pinkAccent,
              child: Text("Guardar",
                style: TextStyle(color: Colors.white,fontSize: 13),),
              onPressed: save,
            )
          ],
        ),
      ),
    ));
  }
  getTextBox(){
    page=(page!=null)?page:Page(diaryId: widget.diary.id);
    page.title=ctrlTitle.text;
    page.content=ctrlContent.text;
    page.date=ctrlDate.text;
  }
  save()async{
    getTextBox();
    Page page=await this.page.saveOrUpdate();

    if(page!=null){
      widget.voidCallbackParam(page);
      Navigator.pop(context);
    }
  }

}