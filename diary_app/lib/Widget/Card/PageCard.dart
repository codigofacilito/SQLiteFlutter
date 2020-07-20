import 'package:diary_app/Modelo/Page.dart';
import 'package:diary_app/Page/FormPage.dart';
import 'package:flutter/material.dart';

class PageCard extends StatelessWidget{
  Page page;
  VoidCallbackParam voidCallbackParam;
  PageCard(this.voidCallbackParam,this.page);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(onTap:()=>onPressPage(context),child:Card(elevation: 5,
    child: Row(children: <Widget>[
      Container(
        child: Icon(Icons.calendar_today),
        height: 100,
        width: 100,
      ),
      Flexible(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(page.title,maxLines:2,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize:15 ),),
            Row(children: <Widget>[
              Icon(Icons.access_time,color: Colors.pinkAccent,),
              Text(page.date,style: TextStyle(fontSize:11 ),)
            ],)
          ],
        ),
      )
    ],),));
  }

  onPressPage(context){
    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>FormPage(voidCallbackParam,page: page,),
    ));
  }
}

