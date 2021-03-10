import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:share/share.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Hadith").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      children: [
                        Text(
                          'قال رسول الله صلى الله عليه وسلم:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Cairo-Regular',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${document['text']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Gabriola',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${document['rawy']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Cairo-Regular',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                FlutterShareMe().shareToWhatsApp(
                    msg:
                        'إنما الأعمال بالنيّات، وإنما لكل امريء ما نوى، فمن كانت هجرته إلى الله ورسوله، فهجرته إلى الله ورسوله، ومن كانت هجرته لدنيا يصيبها، أو امرأة ينكحها، فهجرته إلى ما هاجر إليه' +
                            '\n' +
                            'حمل تطبيق أدعية وأذكار' +
                            '\n' +
                            'https://kla.me/2M1hz');
              }, // needed
              child: Image.asset(
                "images/whatsapp.png",
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              //Share zekr title and text and app link
              setState(() {
                Share.share(
                    'إنما الأعمال بالنيّات، وإنما لكل امريء ما نوى، فمن كانت هجرته إلى الله ورسوله، فهجرته إلى الله ورسوله، ومن كانت هجرته لدنيا يصيبها، أو امرأة ينكحها، فهجرته إلى ما هاجر إليه' +
                        '\n' +
                        'حمل تطبيق أدعية وأذكار' +
                        '\n' +
                        'https://kla.me/2M1hz');
              });
            },
            tooltip: 'share',
            child: Icon(Icons.share),
            backgroundColor: Palette.primaryColor,
            foregroundColor: Palette.accentColor,
          ),
        ],
      ),
    );
  }
}
