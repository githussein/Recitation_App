import 'package:flutter/material.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:hijri_gregorian/main.dart';

import 'favorites.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDayNightReminder = true;
  bool isSleepReminder = true;

  //Default selected tab from the bottom navigation bar
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإعدادات"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Switch(
                    value: isDayNightReminder,
                    onChanged: (value) {
                      setState(() async {
                        isDayNightReminder = value;
                      });
                    },
                    activeTrackColor: Colors.grey,
                    activeColor: Palette.primaryColor,
                  ),
                  Text('أذكار اليوم والليلة'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'إظهار إشعار لينبهك بأذكار اليوم والليلة',
                    style: TextStyle(
                      color: Palette.accentColor.withOpacity(0.70),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('وقت تبيه أذكار الصباح'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('05:45 ص'),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('وقت تبيه أذكار المساء'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('04:00 م'),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Switch(
                    value: isSleepReminder,
                    onChanged: (value) async {
                      setState(() {
                        isSleepReminder = value;
                      });
                      if (value) {
                        await notificationPlugin.showDailyAtTime(
                            13, 58, 'أذكار الصباح والمساء');
                      }
                    },
                    activeTrackColor: Colors.grey,
                    activeColor: Palette.primaryColor,
                  ),
                  Text('أذكار النوم'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'إظهار إشعار لينبهك بأذكار النوم',
                    style: TextStyle(
                      color: Palette.accentColor.withOpacity(0.70),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('وقت تبيه أذكار النوم'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('11:00 م'),
                ],
              ),
            ],
          ),
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
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Favorites()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }
}
