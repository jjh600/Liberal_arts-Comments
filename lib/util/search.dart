import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/elective_detail.dart';

import 'package:eck_app/widgets/trending_item.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class Search extends SearchDelegate<String> {
  List sList = [];
  List lList = [];

  Search() {
    lList = lectures;
    FirebaseFirestore.instance.collection('elective').get().then((value) {
      value.docs.forEach((element) {
        sList.add(element);
      });
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return buildpage();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildpage();
  }

  buildpage() {
    List suggestionList = [];
    sList.forEach((element) {
      if (query.isNotEmpty) {
        if (element['lecture'].toString().contains(query.toUpperCase()) ||
            element['professor'].toString().contains(query.toUpperCase())) {
          suggestionList.add(element);
        }
      }
    });

    lList.forEach((element) {
      if (query.isNotEmpty) {
        if (element['lecture'].toString().contains(query.toUpperCase()) ||
            element['professor'].toString().contains(query.toUpperCase())) {
          suggestionList.add(element);
        }
      }
    });

    if (suggestionList.length == 0) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '과목명 or 교수명',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            '띄어쓰기 없이 검색해주세요.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ));
    } else {
      return Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: suggestionList == null ? 0 : suggestionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          try {
                            if (suggestionList[index]['date'] != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ElectiveDetailScreen(
                                        suggestionList[index]);
                                  },
                                ),
                              );
                            }
                          } catch (e) {}
                        },
                        child: buildItem(suggestionList[index]));
                  }),
              SizedBox(height: 10.0),
            ],
          ));
    }
  }

  buildItem(var a) {
    try {
      return TrendingItem(
        date: a['date'],
        content: a['content'],
        title: a['lecture'] + " :: " + a['professor'],
        rating: int.parse(a['avg_rating'].toStringAsFixed(0)),
        department: a['department'],
        count: a['count'],
        tag1: a['tag1_count'],
        tag2: a['tag2_count'],
        tag3: a['tag3_count'],
        tag4: a['tag4_count'],
        tag5: a['tag5_count'],
        tag6: a['tag6_count'],
        appTitle: '강의후기',
      );
    } catch (e) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Container(
            height: 30,
            child: Card(
                elevation: 3.0,
                color: Colors.white,
                child: Center(
                  child: Text(
                    a['area'] +
                        " " +
                        a['lecture'] +
                        " :: " +
                        a['professor'] +
                        " " +
                        a['credit'].toString() +
                        "학점",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ))),
      );
    }
  }
}
