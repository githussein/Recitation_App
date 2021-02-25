import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri_gregorian/favorites.dart';
import 'DatabaseHelper.dart';
import 'Zekr.dart';

class EditFavorites extends StatefulWidget {
  @override
  _EditFavoritesState createState() => _EditFavoritesState();
}

class _EditFavoritesState extends State<EditFavorites> {
  ///// DATABASE /////
  List<Zekr> azkarList = new List();
  static final favoritesTable = 'favorites';

  TextEditingController textController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    ///// DATABASE /////
    //Query all the Azkar in the Favorites table
    DatabaseHelper.instance.queryAllRows(favoritesTable).then((value) {
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
        title: Text("تعديل مفضلاتي"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favorites()));
              }),
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
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addToAzkar,
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
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteZekr(azkarList[index].id),
                              ),
                              title: Text(
                                azkarList[index].title,
                                textAlign: TextAlign.right,
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

  void _addToAzkar() async {
    String newZekr = textController.text;
    //Check if it is not an empty string
    if (newZekr != '') {
      var id = await DatabaseHelper.instance
          .insert(Zekr(title: newZekr), favoritesTable);
      //Update the displayed list of Azkar by adding the recently inserted row
      setState(() {
        azkarList.insert(0, Zekr(id: id, title: newZekr));
      });
      //Clear the Text Controller field
      clearName();
    }
  }

  clearName() {
    textController.text = '';
  }

  void _deleteZekr(int id) async {
    await DatabaseHelper.instance.delete(id, favoritesTable);
    setState(() {
      azkarList.removeWhere((element) => element.id == id);
    });
  }
}
