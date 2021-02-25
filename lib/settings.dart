import 'package:flutter/material.dart';
import 'package:hijri_gregorian/NotificationPlugin.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDayNightReminder = true;
  bool isSleepReminder = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مفضلاتي"),
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
                    activeTrackColor: const Color(0xffe1ad01),
                    activeColor: const Color(0xff8a9a5b),
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
                      color: const Color(0xffe1ad01).withOpacity(0.70),
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
                    activeTrackColor: const Color(0xffe1ad01),
                    activeColor: const Color(0xff8a9a5b),
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
                      color: const Color(0xffe1ad01).withOpacity(0.70),
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
    );
  }
}
