import 'package:flutter/material.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';
import 'package:hijri_gregorian/choose_azkar.dart';
import 'package:hijri_gregorian/favorites.dart';
import 'package:hijri_gregorian/hadith.dart';
import 'package:hijri_gregorian/misbaha.dart';
import 'package:hijri_gregorian/settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:hijri/hijri_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'دعــاء',
      theme: ThemeData(
        primaryColor: Color(0xff8a9a5b),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'دعــاء'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Default selected tab from the bottom navigation bar
  int _selectedIndex = 2;
  // final List<Widget> _widgetOptions = [];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    //Initialize OneSignal notifications
    initOneSignal();

    notificationPlugin
        .setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);

    // var androidInitialize = new AndroidInitializationSettings('app_icon');
    // var iOSInitialize = new IOSInitializationSettings();
    // var initializationSettings =
    //     new InitializationSettings(androidInitialize, iOSInitialize);
    // flutterNotification = new FlutterLocalNotificationsPlugin();
    // flutterNotification.initialize(initializationSettings,
    //     onSelectNotification: notificationSelected);
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification) {
    print('Notification Received ${receivedNotification.id}');
  }

  onNotificationClick(String payload) {
    print('Payload $payload');
  }

  // Future notificationSelected(String payload) async {
  //   //CURRENTLY THE NOTIFICATION JUST TAKE THE USER TO THE APP
  //   // showDialog(
  //   //   context: context,
  //   //   builder: (context) => AlertDialog(
  //   //     content: Text("Notification : $payload"),
  //   //   ),
  //   // );
  // }

  // Future _showNotification() async {
  //   var androidDetails = new AndroidNotificationDetails(
  //       "Channel ID", "Desi programmer", "This is my channel",
  //       importance: Importance.Max);
  //   var iSODetails = new IOSNotificationDetails();
  //   var generalNotificationDetails =
  //       new NotificationDetails(androidDetails, iSODetails);
  //
  //   // await flutterNotification.show(
  //   //     0, "Task", "You created a Task", generalNotificationDetails,
  //   //     payload: "Task");
  //   var scheduledTime = DateTime.now().add(Duration(hours: 1));
  //   flutterNotification.schedule(1, "تنبيه بالذكر", "سبحان الله وبحمده",
  //       scheduledTime, generalNotificationDetails);
  // }

  @override
  Widget build(BuildContext context) {
    //show local notification after certain time
    //notificationPlugin.scheduleNotification();

    //*************** Counter ***********//

    final birthday = DateTime(1990, 10, 12);

    final _nextGregorian = DateTime.parse('2021-04-13 00:00:00.000');
    final _currentGregorian = DateTime.now();
    final _difference = _nextGregorian.difference(_currentGregorian).inDays;

    var _hijriDate = new HijriCalendar.now();

    String _gregorianMonth = "";
    switch (_currentGregorian.month) {
      case 1:
        _gregorianMonth = 'يناير';
        break;
      case 2:
        _gregorianMonth = 'فبراير';
        break;
      default:
        _gregorianMonth = 'فبراير';
    }

    String _hijriMonth = "";
    switch (_hijriDate.hMonth) {
      case 7:
        _hijriMonth = 'رجـب';
        break;
      case 8:
        _hijriMonth = 'شعبـان';
        break;
      default:
        _hijriMonth = 'رجـب';
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('دعــاء'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // RaisedButton(
            //   child: Text('NOTIFICATION'),
            //   onPressed: () async {
            //     // await notificationPlugin.scheduleNotification();
            //     await notificationPlugin.showNotification();
            //   },
            // ),
            Text(
              '${_hijriDate.hDay}' + ' $_hijriMonth ' + '${_hijriDate.hYear}',
              textDirection: TextDirection.rtl,
            ),
            Text(
              ' ${_currentGregorian.day} ' +
                  ' $_gregorianMonth ' +
                  '${_currentGregorian.year}',
              textDirection: TextDirection.rtl,
            ),
            //Text('${gDate.hijriToGregorian(1442, 9, 1)}'),
            Text(
              ' باقي على رمضان $_difference يوما',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Gabriola',
              ),
            ),
            Container(
              height: 150.0,
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.60),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Misbaha()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ImageIcon(
                      AssetImage('images/icon-tasbih.png'),
                      size: 80.0,
                    ),
                    Text('سبحة')
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.60),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseAzkar()),
                  );
                },
                child: Column(
                  children: <Widget>[
                    ImageIcon(
                      AssetImage('images/icon-dua.png'),
                      size: 80.0,
                    ),
                    Text('أذكار')
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.60),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Hadith()),
                  );
                },
                child: Column(
                  children: <Widget>[
                    ImageIcon(
                      AssetImage('images/icon-mhmd.png'),
                      size: 80.0,
                    ),
                    Text('أحاديث')
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ],
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
    } else if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Settings()));
    }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  Future<void> initOneSignal() async {
    await OneSignal.shared.init('478d81c7-8825-4e70-b663-52fc35f7c033');
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   this.setState(() {
    //     _debugLabelString =
    //         "Received notification: \n${notification.jsonRepresentation().replaceAll("\\n", "\n")}";
    //   });
    // });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // this.setState(() {
      //   _debugLabelString =
      //       "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });
  }
}
