import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:share/share.dart';
import 'dart:io';

class Azkar extends StatefulWidget {
  final int selectedZekr;
  Azkar(this.selectedZekr, {Key key}) : super(key: key);

  @override
  _AzkarState createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
  String jsonFile;
  int _current = 0;
  String _titleToShare = "";
  String textToShare = "";

  @override
  void initState() {
    super.initState();

    switch (widget.selectedZekr) {
      case 0:
        jsonFile = "azkar_sabah";
        _titleToShare = 'أذكار الصباح';
        break;
      case 1:
        jsonFile = "azkar_masaa";
        _titleToShare = 'أذكار المساء';
        break;
      case 2:
        jsonFile = "azkar_wudu";
        _titleToShare = 'أذكار الوضوء';
        break;
      case 3:
        jsonFile = "azkar_azan";
        _titleToShare = 'أذكار الأذان';
        break;
      case 4:
        jsonFile = "azkar_salah";
        _titleToShare = 'أذكار الصلاة';
        break;
      case 5:
        jsonFile = "azkar_salam";
        _titleToShare = 'أذكار بعد السلام من الصلاة';
        break;
      case 6:
        _titleToShare = 'أذكار الصباح';
        jsonFile = "azkar_nawm";
        _titleToShare = 'أذكار النوم';
        break;
      case 7:
        jsonFile = "azkar_estikaz";
        _titleToShare = 'أذكار الاستيقاظ من النوم';
        break;
      case 8:
        jsonFile = "azkar_taam";
        _titleToShare = 'أذكار الطعام';
        break;
      case 9:
        jsonFile = "azkar_masjid";
        _titleToShare = 'أذكار المسجد';
        break;
      case 10:
        jsonFile = "azkar_safar";
        _titleToShare = 'أذكار السفر';
        break;
      case 11:
        jsonFile = "azkar_khalaa";
        _titleToShare = 'أذكار الخلاء';
        break;
      default:
        jsonFile = "azkar_salah";
        _titleToShare = 'ولذكر الله أكبر والله يعلم ما تصنعون';
        break;
    }
  }

  ///// DOTS INDICATOR /////
  //A mapping function to display dots indicator with the carousel
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("أذكار المسلم"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/json/$jsonFile.json'),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                // Decode the JSON file
                var jsonResult = json.decode(snapshot.data.toString());

                List myList = jsonResult;

                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 600.0,
                        // reverse: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: myList.map((index) {
                        // titleToShare = index['category'];
                        textToShare = index['zekr'];
                        return Builder(
                          builder: (BuildContext context) {
                            return ListView(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    // margin: EdgeInsets.all(10.0),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.60),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          index['category'],
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Cairo-Regular',
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1C3858)),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          index['zekr'],
                                          style: TextStyle(
                                              //@TODO is this the final font?
                                              fontSize: 16.0,
                                              fontFamily: 'Gabriola',
                                              fontWeight: FontWeight.bold),
                                          textDirection: TextDirection.rtl,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          index['description'],
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Palette.accentColor),
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ],
                                    )),
                              ],
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: map<Widget>(myList, (index, url) {
                        return Container(
                          height: 8.0,
                          width: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 1.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Palette.accentColor
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
        ),
      ),
      //Share screen content
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                FlutterShareMe().shareToWhatsApp(
                    msg:
                        'فاذكروني أذكركم - \n$_titleToShare\nhttps://kla.me/2M1hz');
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
              // Share zekr title and app link
              setState(() {
                Share.share(
                    'فاذكروني أذكركم - \n$_titleToShare\nhttps://kla.me/2M1hz');
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
