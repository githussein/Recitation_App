import 'package:flutter/material.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:hijri_gregorian/counter.dart';
import 'package:hijri_gregorian/edit_Misbaha.dart';
import 'DatabaseHelper.dart';
import 'Zekr.dart';

class Misbaha extends StatefulWidget {
  @override
  _MisbahaState createState() => _MisbahaState();
}

class _MisbahaState extends State<Misbaha> {
  ///// DATABASE /////
  List<Zekr> azkarList = new List();
  static final misbahaTable = 'misbaha';

  TextEditingController textController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    ///// DATABASE /////
    //Query all the Azkar in the Favorites table
    DatabaseHelper.instance.queryAllRows(misbahaTable).then((value) {
      setState(() {
        value.forEach((element) {
          azkarList.add(Zekr(id: element['id'], title: element["title"]));
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("السبحة"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Palette.accentColor,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditMisbaha())),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addToMisbahaTable,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: "إضافة ذكر"),
                      controller: textController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: Container(
                  child: azkarList.isEmpty
                      ? Container()
                      : ListView.builder(itemBuilder: (ctx, index) {
                          if (index == azkarList.length) return null;
                          return Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Counter(
                                            azkarList[index].title,
                                          )),
                                );
                              },
                              child: Text(
                                azkarList[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          );
                        }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addToMisbahaTable() async {
    String newZekr = textController.text;
    //Check if it is not an empty string
    if (newZekr != '') {
      var id = await DatabaseHelper.instance
          .insert(Zekr(title: newZekr), misbahaTable);
      //Update the displayed list of Azkar by adding the recently inserted row
      setState(() {
        azkarList.insert(0, Zekr(id: id, title: newZekr));
      });
      clearName();
    }
  }

  //Clear the Text Controller field
  clearName() {
    textController.text = '';
  }

  void _deleteZekr(int id) async {
    await DatabaseHelper.instance.delete(id, misbahaTable);
    setState(() {
      azkarList.removeWhere((element) => element.id == id);
    });
  }
}
