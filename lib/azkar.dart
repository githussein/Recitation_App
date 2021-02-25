import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:hijri_gregorian/config/palette.dart';
import 'package:share/share.dart';

class Azkar extends StatefulWidget {
  final int selectedZekr;
  Azkar(this.selectedZekr, {Key key}) : super(key: key);

  @override
  _AzkarState createState() => _AzkarState();
}

class _AzkarState extends State<Azkar> {
  String jsonFile;

  @override
  void initState() {
    super.initState();

    switch (widget.selectedZekr) {
      case 0:
        jsonFile = "azkar_sabah";
        break;
      case 1:
        jsonFile = "azkar_masaa";
        break;
      case 2:
        jsonFile = "azkar_wudu";
        break;
      case 3:
        jsonFile = "azkar_azan";
        break;
      case 4:
        jsonFile = "azkar_salah";
        break;
      case 5:
        jsonFile = "azkar_salam";
        break;
      case 6:
        jsonFile = "azkar_nawm";
        break;
      case 7:
        jsonFile = "azkar_estikaz";
        break;
      case 8:
        jsonFile = "azkar_taam";
        break;
      case 9:
        jsonFile = "azkar_masjid";
        break;
      case 10:
        jsonFile = "azkar_safar";
        break;
      case 11:
        jsonFile = "azkar_khalaa";
        break;
      default:
        jsonFile = "azkar_salah";
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

  int _current = 0;
  String titleToShare = "";
  String textToShare = "";

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
              builder: (context, snapshot) {
                // Decode the JSON file
                var jsonResult = json.decode(snapshot.data.toString());

                List myList = jsonResult;

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
                        titleToShare = index['category'];
                        textToShare = index['zekr'];
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      index['category'],
                                      style: TextStyle(
                                          fontSize: 16.0,
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
                                          fontSize: 14.0,
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
                                ));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Share zekr title and text and app link
          setState(() {
            Share.share(
                '$titleToShare - \n$textToShare\nhttp://onelink.to/4m9xg8');
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
