import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:hijri_gregorian/main.dart';
import 'package:share/share.dart';
import 'favorites.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  //Local notifications
  FlutterLocalNotificationsPlugin flutterLocalNotifications;
  // NotificationPlugin notificationPlugin = NotificationPlugin._();

  //Flags for reminder switches
  bool sabahMasaaSwitch = true;
  bool sleepSwitch = true;

  //Default selected tab from the bottom navigation bar
  int _selectedIndex = 0;

  //content to share to other apps
  String _textToShare =
      'فاذكروني أذكركم - حمل تطبيق أذكار وأدعية \n\nhttps://kla.me/2M1hz';

  TimeOfDay _pickedTime;
  TimeOfDay _sabahReminder;
  TimeOfDay _masaaReminder;
  TimeOfDay _sleepReminder;
  int _sabahHour = 7;
  int _sabahMinute = 0;
  int _masaaHour = 17;
  int _masaaMinute = 0;
  int _sleepHour = 23;
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

    //*************** init local notifications ***************//
    var androidInit = AndroidInitializationSettings('app_icon');
    var iOSInit = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(androidInit, iOSInit);
    flutterLocalNotifications = FlutterLocalNotificationsPlugin();
    flutterLocalNotifications.initialize(initializationSettings,
        onSelectNotification: notificationSelected);

    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);

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
        _sabahMasaaNotification(true);
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
        _sleepNotification(true);
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
                Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  // _showNotification,
                  child: Text(
                    'إعدادات التنبيهات',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Cairo-Regular',
                      fontWeight: FontWeight.bold,
                      color: Palette.primaryColor,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Switch(
                      value: sabahMasaaSwitch,
                      onChanged: (value) {
                        setState(() async {
                          sabahMasaaSwitch = value;
                          // _sabahMasaaNotification(true);
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
                      value: sleepSwitch,
                      onChanged: (value) async {
                        setState(() {
                          sleepSwitch = value;
                        });
                        if (value) {
                          _sleepNotification(true);
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

    _sabahHour = prefs.getInt('sabah_hour') ?? 7;
    _sabahMinute = prefs.getInt('sabah_minute') ?? 0;
    _sabahReminder = TimeOfDay(hour: _sabahHour, minute: _sabahMinute);

    _masaaHour = prefs.getInt('masaa_hour') ?? 17;
    _masaaMinute = prefs.getInt('masaa_minute') ?? 0;
    _masaaReminder = TimeOfDay(hour: _masaaHour, minute: _masaaMinute);

    _sleepHour = prefs.getInt('sleep_hour') ?? 23;
    _sleepMinute = prefs.getInt('sleep_minute') ?? 0;
    _sleepReminder = TimeOfDay(hour: _sleepHour, minute: _sleepMinute);

    //Update view
    setState(() {});
  }

  String _method() {
    _read();
    return "";
  }

  //Methods required to initiate local notifications
  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "ID_9", "Channel_INSTANT", "channel_09",
        importance: Importance.Max);
    var iSODetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(androidDetails, iSODetails);

    await flutterLocalNotifications.show(
      9,
      "show notification",
      "instant notification - body",
      generalNotificationDetails,
      payload: "Task",
    );

    // var scheduledTime = DateTime.now().add(Duration(hours: 1));
    // flutterNotification.schedule(1, "تنبيه بالذكر", "سبحان الله وبحمده",
    //     scheduledTime, generalNotificationDetails);
  }

  void _sabahMasaaNotification(bool switched) async {
    var androidDetails = AndroidNotificationDetails(
        "ID_0", "Channel_SABAHMASAA", "channel_0",
        importance: Importance.Max);
    var iSODetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(androidDetails, iSODetails);

    // if (switched) {
    await flutterLocalNotifications.showDailyAtTime(
        0,
        "أذكار وأدعية",
        "تنبيه بأذكار الصباح والمساء",
        Time(_sabahHour, _sabahMinute, 0),
        generalNotificationDetails);
    // }
  }

  void _sleepNotification(bool switched) async {
    var androidDetails = AndroidNotificationDetails(
        "ID_2", "Channel_SLEEP", "channel_2",
        importance: Importance.Max);
    var iSODetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(androidDetails, iSODetails);

    // if (switched) {
    await flutterLocalNotifications.showDailyAtTime(
        2,
        "أذكار وأدعية",
        "تنبيه بأذكار النوم",
        Time(_sleepHour, _sleepMinute, 0),
        generalNotificationDetails);
    // }
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
  }

  Future notificationSelected(String payload) async {}
}
