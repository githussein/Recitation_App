import 'package:flutter/material.dart';
import 'package:hijri_gregorian/azkar.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_gregorian/config/palette.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    final _ramadan = DateTime.parse('2021-04-13 00:00:00.000');
    final _ramadanDate = DateTime.parse('2021-04-13 00:00:00.000');
    final _fitrDate = DateTime.parse('2021-05-13 00:00:00.000');
    final _adhaDate = DateTime.parse('2021-07-19 00:00:00.000');
    final _gregorianDate = DateTime.now();
    final _beforeRamadan = _ramadan.difference(_gregorianDate).inDays;
    final _beforeFitr = _fitrDate.difference(_gregorianDate).inDays;
    final _beforeAdha = _adhaDate.difference(_gregorianDate).inDays;

    var _hijriDate = new HijriCalendar.now();

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

    return Scaffold(
      appBar: AppBar(
        title: Text("المنااسبات القادمة"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          primary: false,
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Column(
                children: [
                  Text(
                    'شهر رمضان',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontFamily: 'Cairo-Regular'),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'الثلاثاء ' +
                        //'$_dayName ' +
                        ' ${_ramadanDate.day}' +
                        ' أبريل' +
                        // ' ${_ramadanDate.month}' +
                        ' ${_ramadanDate.year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Cairo-Regular',
                      color: Palette.accentColor,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'بعد' + ' $_beforeRamadan ' + 'يوما',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Cairo-Regular',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Column(
                children: [
                  Text(
                    'عيد الفطر',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontFamily: 'Cairo-Regular'),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'الخميس ' +
                        // '$_dayName ' +
                        ' ${_fitrDate.day}' +
                        ' مايو' +
                        // ' $_hijriMonth' +
                        ' ${_fitrDate.year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Cairo-Regular',
                      color: Palette.accentColor,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'بعد' + ' $_beforeFitr ' + 'يوما',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Cairo-Regular',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Column(
                children: [
                  Text(
                    'عيد الأضحى',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontFamily: 'Cairo-Regular'),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'الإثنين ' +
                        // '$_dayName ' +
                        ' ${_adhaDate.day}' +
                        ' يوليه' +
                        // ' $_hijriMonth' +
                        ' ${_adhaDate.year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Cairo-Regular',
                      color: Palette.accentColor,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'بعد' + ' $_beforeAdha ' + 'يوما',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Cairo-Regular',
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
