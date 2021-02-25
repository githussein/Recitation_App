import 'package:flutter/material.dart';
import 'package:hijri_gregorian/azkar.dart';

class ChooseAzkar extends StatefulWidget {
  @override
  _ChooseAzkarState createState() => _ChooseAzkarState();
}

class _ChooseAzkarState extends State<ChooseAzkar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("أذكار المسلم"),
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
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(0)),
                  );
                },
                child: Text(
                  'أذكار الصباح',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(1)),
                  );
                },
                child: Text(
                  'أذكار المساء',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(2)),
                  );
                },
                child: Text(
                  'أذكار الوضوء',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(3)),
                  );
                },
                child: Text(
                  'أذكار الأذان',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(4)),
                  );
                },
                child: Text(
                  'أذكار الصلاة',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(5)),
                  );
                },
                child: Text(
                  'أذكار بعد الصلاة',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(6)),
                  );
                },
                child: Text(
                  'أذكار النوم',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(7)),
                  );
                },
                child: Text(
                  'أذكار الاستيقاظ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(8)),
                  );
                },
                child: Text(
                  'أذكار الطعام',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(9)),
                  );
                },
                child: Text(
                  'أذكار المسجد',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(10)),
                  );
                },
                child: Text(
                  'أذكار السفر',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Azkar(11)),
                  );
                },
                child: Text(
                  'أذكار الخلاء',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
