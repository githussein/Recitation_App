import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri_gregorian/config/palette.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  dynamic data;

  Map<String, dynamic> demoData = {"name": "event_name", "day": "event_day"};

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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Events").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  //handle date options
                  DateTime date = document['date'].toDate();
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
                    _difference = 'بعد' + ' $_daysBefore ' + 'يوما';
                    _isVisible = true;
                  }

                  return Visibility(
                    visible: _isVisible,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Column(
                        children: [
                          Text(
                            '${document['event_name']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: 'Cairo-Regular'),
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            '${document['day_name']} ' +
                                '${_fitrDate.day} ' +
                                '${document['month']} ' +
                                // ' $_hijriMonth' +
                                '${document['year']} ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Cairo-Regular',
                              color: Palette.accentColor,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            // '${date.day}',
                            '$_difference',
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
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
      // Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage('images/background.png'),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   child: ListView(
      //     primary: false,
      //     padding: const EdgeInsets.all(15.0),
      //     children: <Widget>[
      //       Container(
      //         margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
      //         padding: EdgeInsets.all(5.0),
      //         decoration: BoxDecoration(
      //             color: Colors.white.withOpacity(0.7),
      //             borderRadius: BorderRadius.all(Radius.circular(25))),
      //         child: Column(
      //           children: [
      //             Text(
      //               'شهر رمضان',
      //               textAlign: TextAlign.center,
      //               style:
      //                   TextStyle(fontSize: 18.0, fontFamily: 'Cairo-Regular'),
      //               textDirection: TextDirection.rtl,
      //             ),
      //             Text(
      //               'الثلاثاء ' +
      //                   //'$_dayName ' +
      //                   ' ${_ramadanDate.day}' +
      //                   ' أبريل' +
      //                   // ' ${_ramadanDate.month}' +
      //                   ' ${_ramadanDate.year}',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 16.0,
      //                 fontFamily: 'Cairo-Regular',
      //                 color: Palette.accentColor,
      //               ),
      //               textDirection: TextDirection.rtl,
      //             ),
      //             Text(
      //               'بعد' + ' $_beforeRamadan ' + 'يوما',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 18.0,
      //                 fontFamily: 'Cairo-Regular',
      //               ),
      //               textDirection: TextDirection.rtl,
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      //         padding: EdgeInsets.all(5.0),
      //         decoration: BoxDecoration(
      //             color: Colors.white.withOpacity(0.7),
      //             borderRadius: BorderRadius.all(Radius.circular(25))),
      //         child: Column(
      //           children: [
      //             Text(
      //               'عيد الفطر',
      //               textAlign: TextAlign.center,
      //               style:
      //                   TextStyle(fontSize: 18.0, fontFamily: 'Cairo-Regular'),
      //               textDirection: TextDirection.rtl,
      //             ),
      //             Text(
      //               'الخميس ' +
      //                   // '$_dayName ' +
      //                   ' ${_fitrDate.day}' +
      //                   ' مايو' +
      //                   // ' $_hijriMonth' +
      //                   ' ${_fitrDate.year}',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 16.0,
      //                 fontFamily: 'Cairo-Regular',
      //                 color: Palette.accentColor,
      //               ),
      //               textDirection: TextDirection.rtl,
      //             ),
      //             Text(
      //               'بعد' + ' $_beforeFitr ' + 'يوما',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 18.0,
      //                 fontFamily: 'Cairo-Regular',
      //               ),
      //               textDirection: TextDirection.rtl,
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      //         padding: EdgeInsets.all(5.0),
      //         decoration: BoxDecoration(
      //             color: Colors.white.withOpacity(0.7),
      //             borderRadius: BorderRadius.all(Radius.circular(25))),
      //         child: Column(
      //           children: [
      //             Text(
      //               'عيد الأضحى',
      //               textAlign: TextAlign.center,
      //               style:
      //                   TextStyle(fontSize: 18.0, fontFamily: 'Cairo-Regular'),
      //               textDirection: TextDirection.rtl,
      //             ),
      //             Text(
      //               'الإثنين ' +
      //                   // '$_dayName ' +
      //                   ' ${_adhaDate.day}' +
      //                   ' يوليه' +
      //                   // ' $_hijriMonth' +
      //                   ' ${_adhaDate.year}',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 16.0,
      //                 fontFamily: 'Cairo-Regular',
      //                 color: Palette.accentColor,
      //               ),
      //               textDirection: TextDirection.rtl,
      //             ),
      //             Text(
      //               'بعد' + ' $_beforeAdha ' + 'يوما',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 18.0,
      //                 fontFamily: 'Cairo-Regular',
      //               ),
      //               textDirection: TextDirection.rtl,
      //             ),
      //           ],
      //         ),
      //       ),
      //       RaisedButton(
      //         onPressed: () {
      //           _saveMap();
      //         },
      //         child: Text('SAVE'),
      //       ),
      //       RaisedButton(
      //         onPressed: () {
      //           _readFBDB();
      //         },
      //         child: Text('Read'),
      //       ),
      //       Text(data.toString()),
      //     ],
      //   ),
      // ),
    );
  }

  void _readFBDB() {}

  void _saveMap() {}
}
