import 'package:flutter/material.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:share/share.dart';

class Hadith extends StatefulWidget {
  @override
  _HadithState createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("حديث اليوم"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.60),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: <Widget>[
              Text(
                ':قال رسول الله صلى الله عليه وسلم',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF1C3858),
                ),
              ),
              Text(
                'إنما الأعمال بالنيّات، وإنما لكل امريء ما نوى، فمن كانت هجرته إلى الله ورسوله، فهجرته إلى الله ورسوله، ومن كانت هجرته لدنيا يصيبها، أو امرأة ينكحها، فهجرته إلى ما هاجر إليه',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: 'Gabriola',
                ),
              ),
              Text(
                'مـتـفـق عـلـيـه',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF1C3858),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Share zekr title and text and app link
          setState(() {
            Share.share(
                'قال رسول الله صلى الله عليه وسلم:\nإنما الأعمال بالنيّات، وإنما لكل امريء ما نوى، فمن كانت هجرته إلى الله ورسوله، فهجرته إلى الله ورسوله، ومن كانت هجرته لدنيا يصيبها، أو امرأة ينكحها، فهجرته إلى ما هاجر إليه\nhttps://kla.me/2M1hz');
          });
        },
        tooltip: 'share',
        child: Icon(Icons.share),
        backgroundColor: Palette.primaryColor,
        foregroundColor: Palette.accentColor,
      ),
    );
  }
}
