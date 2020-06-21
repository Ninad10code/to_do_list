import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List toDos = List();
  String input = '';
  @override
  void initState() {
    super.initState();
    toDos.add('item1');
    toDos.add('item2');
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
      body: ListView.builder(
          itemCount: toDos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(toDos[index]),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                elevation: 4,
                child: ListTile(
                  title: Text(toDos[index]),
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
          }),
    );
  }
}
