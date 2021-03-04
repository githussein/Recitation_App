import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:hijri_gregorian/main.dart';
import 'package:share/share.dart';
import 'favorites.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //Local notifications
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  //Flags for reminder switches
  bool isDayNightReminder = true;
  bool isSleepReminder = true;

  //Default selected tab from the bottom navigation bar
  int _selectedIndex = 0;

  //content to share to other apps
  String _textToShare =
      'فاذكروني أذكركم - حمل تطبيق أذكار وأدعية \n\nhttps://kla.me/2M1hz';

  TimeOfDay _pickedTime;
  TimeOfDay _sabahReminder;
  TimeOfDay _masaaReminder;
  TimeOfDay _sleepReminder;
  int _sabahHour = 6;
  int _sabahMinute = 0;
  int _masaaHour = 17;
  int _masaaMinute = 0;
  int _sleepHour = 10;
  int _sleepMinute = 0;
  TimeOfDay tod;
  String s;

  @override
  void initState() {
    super.initState();

    //Read app settings and azkar counts from SharedPreferences
    _read();

    _pickedTime = TimeOfDay.now();
    _sabahReminder = TimeOfDay(hour: _sabahHour, minute: _sabahMinute);
    _masaaReminder = TimeOfDay(hour: _masaaHour, minute: _masaaMinute);
    _sleepReminder = TimeOfDay(hour: _sleepHour, minute: _sleepMinute);

    // tod = TimeOfDay(hour: _sabahHour, minute: _sabahMinute);
    // s = _sabahReminder.hour.toString() + ':' + _sabahReminder.minute.toString();
    // tod = TimeOfDay(hour: _sabahHour, minute: _sabahMinute);
    // s = _sabahReminder.hour.toString() + ':' + _sabahReminder.minute.toString();
  }

  Future<Null> _selectTime(BuildContext context, int index) async {
    _pickedTime =
        await showTimePicker(context: context, initialTime: _pickedTime);

    if (_pickedTime != null && index == 0) {
      setState(() {
        _sabahReminder = _pickedTime;
        _sabahHour = _sabahReminder.hour;
        _sabahMinute = _sabahReminder.minute;
        //
        // s = _sabahReminder.hour.toString() +
        //     ':' +
        //     _sabahReminder.minute.toString();
        // tod = TimeOfDay(
        //     hour: int.parse(s.split(":")[0]),
        //     minute: int.parse(s.split(":")[1]));
      });
    } else if (_pickedTime != null && index == 1) {
      setState(() {
        _masaaReminder = _pickedTime;
        _masaaHour = _masaaReminder.hour;
        _masaaMinute = _masaaReminder.minute;
      });
    } else if (_pickedTime != null && index == 2) {
      setState(() {
        _sleepReminder = _pickedTime;
        _sleepHour = _sleepReminder.hour;
        _sleepMinute = _sleepReminder.minute;
      });
    }
    //save changes to SharedPreferences
    _save();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _save();

        //trigger leaving and use own data
        Navigator.pop(context, false);

        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
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
              padding: EdgeInsets.all(10),
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
                    Text(
                      'تنبيه بأذكار الصباح والمساء',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'إظهار إشعار لينبهك بأذكار الصباح والمساء',
                      style: TextStyle(
                        color: Palette.accentColor,
                        fontSize: 14.0,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _selectTime(context, 0);
                          },
                          child: Text(
                            'وقت تبيه أذكار الصباح' +
                                '\n' +
                                '${_sabahReminder.format(context)}',
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _selectTime(context, 1);
                          },
                          child: Text(
                            'وقت تبيه أذكار المساء' +
                                '\n' +
                                '${_masaaReminder.format(context)}',
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
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
                              2, 40, 'أذكار الصباح والمساء');
                        }
                      },
                      activeTrackColor: Colors.grey,
                      activeColor: Palette.primaryColor,
                    ),
                    Text(
                      'تنبيه بأذكار النوم',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'إظهار إشعار لينبهك بأذكار النوم',
                      style: TextStyle(
                        color: Palette.accentColor,
                        fontSize: 14.0,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _selectTime(context, 2);
                          },
                          child: Text(
                            'وقت تبيه أذكار النوم' +
                                '\n' +
                                '${_sleepReminder.format(context)}',
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ساهم بنشر التطبيق',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Material(
                            // needed
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Share.share(_textToShare);
                              }, // needed
                              child: Image.asset(
                                "images/share.png",
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          // Material(
                          //   // needed
                          //   color: Colors.transparent,
                          //   child: InkWell(
                          //     onTap: () {
                          //       FlutterShareMe().shareToFacebook(
                          //           msg: msg, url: 'https://kla.me/2M1hz');
                          //     }, // needed
                          //     child: Image.asset(
                          //       "images/facebook.png",
                          //       width: 35,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 20.0),
                          Material(
                            // needed
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                FlutterShareMe()
                                    .shareToTwitter(msg: _textToShare);
                              }, // needed
                              child: Image.asset(
                                "images/twitter.png",
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Material(
                            // needed
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                FlutterShareMe()
                                    .shareToWhatsApp(msg: _textToShare);
                              }, // needed
                              child: Image.asset(
                                "images/whatsapp.png",
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
                Column(
                  children: [
                    Text(
                      'للتـواصـل',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'hijricalendars.com@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

  //Save user selected reminding times
  _save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('sabah_hour', _sabahHour);
    prefs.setInt('sabah_minute', _sabahMinute);

    prefs.setInt('masaa_hour', _masaaHour);
    prefs.setInt('masaa_minute', _masaaMinute);

    prefs.setInt('sleep_hour', _sleepHour);
    prefs.setInt('sleep_minute', _sleepMinute);
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();

    _sabahHour = prefs.getInt('sabah_hour') ?? 0;
    _sabahMinute = prefs.getInt('sabah_minute') ?? 0;
    _sabahReminder = TimeOfDay(hour: _sabahHour, minute: _sabahMinute);

    _masaaHour = prefs.getInt('masaa_hour') ?? 0;
    _masaaMinute = prefs.getInt('masaa_minute') ?? 0;
    _masaaReminder = TimeOfDay(hour: _masaaHour, minute: _masaaMinute);

    _sleepHour = prefs.getInt('sleep_hour') ?? 0;
    _sleepMinute = prefs.getInt('sleep_minute') ?? 0;
    _sleepReminder = TimeOfDay(hour: _sleepHour, minute: _sleepMinute);

    //Update view
    setState(() {});
  }

  String _method() {
    _read();
    return "";
  }
}
