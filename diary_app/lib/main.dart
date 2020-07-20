import 'package:diary_app/Modelo/Diary.dart';
import 'package:diary_app/Page/FormPage.dart';
import 'package:diary_app/Widget/LockScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SafeArea(child:Scaffold(body:
      Center(child:FutureBuilder<List<Diary>>(
       future: Diary().getDiaries(),
        initialData: List(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
         return (snapshot.connectionState==ConnectionState.done)?
             LockScreen(snapshot.data):CircularProgressIndicator();
        },
      ))))

    );
  }
}
