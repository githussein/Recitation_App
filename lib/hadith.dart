import 'package:flutter/material.dart';
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
        backgroundColor: const Color(0xff8a9a5b),
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
                'قال رسول الله صلى الله عليه وسلم:\nإنما الأعمال بالنيّات، وإنما لكل امريء ما نوى، فمن كانت هجرته إلى الله ورسوله، فهجرته إلى الله ورسوله، ومن كانت هجرته لدنيا يصيبها، أو امرأة ينكحها، فهجرته إلى ما هاجر إليه\nhttp://onelink.to/4m9xg8');
          });
        },
        tooltip: 'share',
        child: Icon(Icons.share),
        backgroundColor: const Color(0xff8a9a5b),
        foregroundColor: const Color(0xffe1ad01),
      ),
    );
  }
}
