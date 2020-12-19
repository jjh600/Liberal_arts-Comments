import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/elective_detail.dart';

import 'package:eck_app/widgets/trending_item.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate<String> {
  List sList = [];

  Search() {
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

    if (suggestionList.length == 0) {
      return Center(
          child: Text(
        '과목명 or 교수명을 입력해주세요.',
        style: TextStyle(fontSize: 20),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ElectiveDetailScreen(
                                  suggestionList[index]);
                            },
                          ),
                        );
                      },
                      child: TrendingItem(
                        date: suggestionList[index]['date'],
                        content: suggestionList[index]['content'],
                        title: suggestionList[index]['lecture'] +
                            " :: " +
                            suggestionList[index]['professor'],
                        rating: int.parse(suggestionList[index]['avg_rating']
                            .toStringAsFixed(0)),
                        department: suggestionList[index]['department'],
                        count: suggestionList[index]['count'],
                        tag1: suggestionList[index]['tag1_count'],
                        tag2: suggestionList[index]['tag2_count'],
                        tag3: suggestionList[index]['tag3_count'],
                        tag4: suggestionList[index]['tag4_count'],
                        tag5: suggestionList[index]['tag5_count'],
                        tag6: suggestionList[index]['tag6_count'],
                        appTitle: '강의후기',
                      ),
                    );
                  }),
              SizedBox(height: 10.0),
            ],
          ));
    }
  }
}
