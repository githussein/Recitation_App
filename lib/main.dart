import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:hijri_gregorian/Ayah.dart';
import 'package:hijri_gregorian/Events.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';
import 'package:hijri_gregorian/Roqya.dart';
import 'package:hijri_gregorian/choose_azkar.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:hijri_gregorian/favorites.dart';
import 'package:hijri_gregorian/hadith.dart';
import 'package:hijri_gregorian/misbaha.dart';
import 'package:hijri_gregorian/settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:share/share.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  //Initialize the Firebase library before doing anything else
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أذكار وأدعية',
      theme: ThemeData(
        primaryColor: Palette.primaryColor,
        accentColor: Palette.accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'أذكار وأدعية'),
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
  // final databaseReference = FirebaseDatabase.instance.reference();

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
    final _gregorianDate = DateTime.now();
    final _difference = _nextGregorian.difference(_gregorianDate).inDays;

    var _hijriDate = new HijriCalendar.now();

    String _gregorianMonth = "";
    switch (_gregorianDate.month) {
      case 1:
        _gregorianMonth = 'يناير';
        break;
      case 2:
        _gregorianMonth = 'فبراير';
        break;
      case 3:
        _gregorianMonth = 'مارس';
        break;
      case 4:
        _gregorianMonth = 'أبريل';
        break;
      case 5:
        _gregorianMonth = 'مايو';
        break;
      case 6:
        _gregorianMonth = 'يونيو';
        break;
      case 7:
        _gregorianMonth = 'يوليو';
        break;
      case 8:
        _gregorianMonth = 'أغسطس';
        break;
      case 9:
        _gregorianMonth = 'سبتمبر';
        break;
      case 10:
        _gregorianMonth = 'اكتوبر';
        break;
      case 11:
        _gregorianMonth = 'نوفمبر';
        break;
      case 12:
        _gregorianMonth = 'ديسمبر';
        break;
      default:
        _gregorianMonth = 'الشهر الميلادي';
    }

    String _hijriMonth = "";
    switch (_hijriDate.hMonth) {
      case 1:
        _hijriMonth = 'محرم';
        break;
      case 2:
        _hijriMonth = 'صفر';
        break;
      case 3:
        _hijriMonth = 'ربيع الأول';
        break;
      case 4:
        _hijriMonth = 'ربيع الآخر';
        break;
      case 5:
        _hijriMonth = 'جمادى الأولى';
        break;
      case 6:
        _hijriMonth = 'جمادى الآخرة';
        break;
      case 7:
        _hijriMonth = 'رجب';
        break;
      case 8:
        _hijriMonth = 'شعبـان';
        break;
      case 9:
        _hijriMonth = 'رمضان';
        break;
      case 10:
        _hijriMonth = 'شوال';
        break;
      case 11:
        _hijriMonth = 'ذو القعدة';
        break;
      case 12:
        _hijriMonth = 'ذو الحجة';
        break;
      default:
        _hijriMonth = 'الشهر الهجري';
    }

    //Day name in Arabic
    String _dayName = "";
    switch (_gregorianDate.weekday) {
      case 1:
        _dayName = 'الإثنين';
        break;
      case 2:
        _dayName = 'الثلاثاء';
        break;
      case 3:
        _dayName = 'االأربعأء';
        break;
      case 4:
        _dayName = 'الخميس';
        break;
      case 5:
        _dayName = 'الجمعة';
        break;
      case 6:
        _dayName = 'السبت';
        break;
      case 7:
        _dayName = 'الأحـد';
        break;
      default:
        _dayName = 'اليوم';
    }

    //content to share to other apps
    String _textToShare =
        'فاذكروني أذكركم - حمل تطبيق أذكار وأدعية \n\nhttps://kla.me/2M1hz';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('أذكار وأدعية'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.80),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'تـاريـخ اليـوم',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Cairo-Regular',
                        ),
                      ),
                      Text(
                        '$_dayName ' +
                            '${_hijriDate.hDay} ' +
                            '$_hijriMonth ' +
                            '${_hijriDate.hYear} ' +
                            '- ' +
                            '${_gregorianDate.day} ' +
                            '$_gregorianMonth ' +
                            '${_gregorianDate.year}',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: Palette.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Homepage_Event')
                    .doc('TdlLYQTVOQCU0ZBuOKvR')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  //handle date and display options
                  var myDocument = snapshot.data;

                  DateTime date = myDocument['date'].toDate();
                  int _daysBefore = date.difference(_gregorianDate).inDays;
                  bool _isVisible = true;

                  String _difference = "";
                  if (_daysBefore == 0) {
                    _difference = "االيوم";
                    _isVisible = true;
                  } else if (_daysBefore == 1) {
                    _difference = "غدا";
                    _isVisible = true;
                  } else if (_daysBefore < 0) {
                    _difference = "";
                    _isVisible = false;
                  } else {
                    _difference = ' بعد' + ' $_daysBefore ' + 'يوما';
                    _isVisible = true;
                  }
                  return Visibility(
                    visible: _isVisible,
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Events()));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 5.0, 20.0, 5.0),
                          decoration: BoxDecoration(
                              color: Palette.accentColor.withOpacity(0.40)),
                          child: Text(
                            '${myDocument['event_name']} ' + '$_difference',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo-Regular',
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.60),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ayah()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage('images/icon-quran.png'),
                              color: Palette.primaryColor,
                              size: 50.0,
                            ),
                            Text(
                              '     آية قرآنية     ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.60),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              color: Palette.primaryColor,
                              size: 50.0,
                            ),
                            Text(
                              '     حديث شريف    ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.60),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                              color: Palette.primaryColor,
                              size: 50.0,
                            ),
                            Text(
                              '       تسبيح       ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.60),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChooseAzkar()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage('images/icon-dua.png'),
                              color: Palette.primaryColor,
                              size: 50.0,
                            ),
                            Text(
                              '        أذكار        ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.60),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Roqya()),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage('images/icon-roqya.png'),
                              color: Palette.primaryColor,
                              size: 50.0,
                            ),
                            Text(
                              '       الرقية       ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                            FlutterShareMe().shareToTwitter(msg: _textToShare);
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
                            FlutterShareMe().shareToWhatsApp(msg: _textToShare);
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
          context, MaterialPageRoute(builder: (context) => UserSettings()));
    }
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
