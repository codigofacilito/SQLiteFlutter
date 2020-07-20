import 'package:diary_app/Modelo/Diary.dart';
import 'package:diary_app/Modelo/Page.dart';
import 'package:diary_app/Page/FormPage.dart';
import 'package:diary_app/Widget/Card/PageCard.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  Diary diary;

  MyHomePage(this.diary);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Page> pages;

  void goForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormPage(addPage,diary: widget.diary,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienveni@ a tu diario ${widget.diary.type}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.playlist_add),
            onPressed: addPages,
          )
        ],
      ),
      body: Center(
          child: FutureBuilder<List<Page>>(
        future: Page().getPages(widget.diary.id),
        initialData: List(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          this.pages = snapshot.data;
          return (snapshot.connectionState == ConnectionState.done)
              ? getListView()
              : CircularProgressIndicator();
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: goForm,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  getListView() {
    return ListView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          Page page=pages[index];
          return Dismissible(
              key:ObjectKey(page),
              onDismissed: (direction){
                page.delete(page.id);
                setState(() {
                  pages.removeAt(index);
                });
              },
              child: PageCard(addPage,pages[index]));
        });
  }


  addPage(Page page){
    pages.add(page);
  }

  addPages(){
    List<Page>pages=[
      Page(
        id:10,
        date: "14-05-2020",
        title: "Pagina 10",
        content: "Pagina 10",
        diaryId: 1
      ),
      Page(
          id:11,
          date: "14-05-2020",
          title: "Pagina 11",
          content: "Pagina 11",
          diaryId: 1
      ),
      Page(
          id:12,
          date: "14-05-2020",
          title: "Pagina 12",
          content: "Pagina 12",
          diaryId: 1
      ),
      Page(
          id:12,
          date: "14-05-2020",
          title: "Pagina 12",
          content: "Pagina 12",
          diaryId: 1
      ),
      Page(
          id:13,
          date: "14-05-2020",
          title: "Pagina 13",
          content: "Pagina 13",
          diaryId: 1
      )
    ];
    Page().insertPages(pages);
  }
}
