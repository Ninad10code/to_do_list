import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List toDos = List();
  String input = '';
  createToDos(){
    DocumentReference documentReference = Firestore.instance.collection("MyToDos").document(input);
    Map<String,String>todos={
      "todoTitle":input
    };
    documentReference.setData(todos).whenComplete((){
      print("$input created");
    });
  }

  deleteToDos(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text('+'),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add ToDo List'),
                    content: TextField(
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            toDos.add(input);
                          });
                        },
                        child: Text('Add'),
                      )
                    ],
                  );
                });
          }),
      body: StreamBuilder(stream: Firestore.instance.collection("MyToDos").snapshots(),
        builder: (context,snapshots){
          return ListView.builder(
            shrinkWrap: true,
              itemCount: snapshots.data.documents.length,
              itemBuilder: (context, int index) {
                DocumentSnapshot documentSnapshot = snapshots.data.documents[index];
                return Dismissible(
                  key: Key(index.toString()),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    elevation: 4,
                    child: ListTile(
                      title: Text(documentSnapshot.data[index]),
                      trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              toDos.removeAt(index);
                            });
                          }),
                    ),
                  ),
                );
              });
        },
      )
    );
  }
}
