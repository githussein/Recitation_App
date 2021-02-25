import 'package:flutter/material.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:hijri_gregorian/edit_favorites.dart';
import 'package:hijri_gregorian/settings.dart';
import 'package:hijri_gregorian/main.dart';
import 'DatabaseHelper.dart';
import 'Zekr.dart';
import 'package:hijri_gregorian/counter.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  //a ist to read all azkar in the database
  List<Zekr> azkarList = new List();
  static final favoritesTable = 'favorites';

  //Default selected tab from the bottom navigation bar
  int _selectedIndex = 1;

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
        title: Text("مفضلاتي"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Palette.accentColor,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditFavorites())),
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
          child: ListView.builder(itemBuilder: (ctx, index) {
            if (index == azkarList.length) return null;
            return Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
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
                child: ListTile(
                  title: Text(
                    azkarList[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTabTapped,
        // onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    //TEST
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Settings()));
    }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }
}
