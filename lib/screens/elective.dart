import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/elective_detail.dart';
import 'package:eck_app/util/search.dart';
import 'package:eck_app/widgets/trending_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElectiveScreen extends StatefulWidget {
  List elist = [];
  List elist2 = [];

  @override
  _ElectiveScreenState createState() => _ElectiveScreenState();
}

class _ElectiveScreenState extends State<ElectiveScreen> {
  final dlist = [
    '전체',
    '1영역',
    '2영역',
    '3영역',
    '4영역',
    '5영역',
    '6영역',
    '7영역',
    '8영역',
    '글컬',
    '소양',
    '융합',
    '공통과목'
  ];

  final List<String> list = List.generate(10, (index) => "Text $index");
  String choice;
  Color scolor = Colors.black12;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: dlist.length,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            elevation: 0.0,
            backgroundColor: Color(0xfff2f6fd),
            title: Image.asset('assets/logo5.png',
                height: MediaQuery.of(context).size.height * 0.1,
                fit: BoxFit.fitHeight),
            iconTheme: IconThemeData(color: Color(0xff3E4685)),
            actions: <Widget>[
              Column(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Color(0xff3E4685),
                      ),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: Search(),
                        );
                      }),
                  Expanded(
                    child: Container(
                        height: 14,
                        width: 85,
                        child: RaisedButton(
                          elevation: 0,
                          color: Color(0xfff2f6fd),
                            child: Row(
                              children: [
                                Text(
                                  '별점순',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: scolor,
                                ),
                              ],
                            ),
                          onPressed: (){
                              setState(() {
                                if (scolor == Colors.black12) {
                                  scolor = Color(0xffffce60);
                                } else {
                                  scolor = Colors.black12;
                                }
                              });
                          },
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
          body: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 45,
                      color: Color(0xff3E4685),
                      child: TabBar(
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 4.0, color: Color(0xfff2f6fd)),
                              insets: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0)),
                          labelColor: Color(0xfff2f6fd),
                          tabs: dlist.map((String choice) {
                            return Tab(text: choice);
                          }).toList(),
                          isScrollable: true),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height * 0.1 + 80),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    child: TabBarView(
                      children: dlist.map((String choice) {
                        this.choice = choice;
                        return _refrashButton(choice);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _refrashButton(String choice) {
    Stream<QuerySnapshot> snapshots;
    if (scolor == Colors.black12){
      if (choice == '전체') {
        snapshots = FirebaseFirestore.instance
            .collection('elective')
            .orderBy('date', descending: true)
            .snapshots();
      } else {
        snapshots = FirebaseFirestore.instance
            .collection('elective')
            .where('area', isEqualTo: choice)
            .orderBy('date', descending: true)
            .snapshots();
      }
    } else {
      if (choice == '전체') {
        snapshots = FirebaseFirestore.instance
            .collection('elective')
            .orderBy('avg_rating', descending: true)
            .orderBy('date', descending: true)
            .snapshots();
      } else {
        snapshots = FirebaseFirestore.instance
            .collection('elective')
            .where('area', isEqualTo: choice)
            .orderBy('avg_rating', descending: true)
            .orderBy('date', descending: true)
            .snapshots();
      }
    }

    return StreamBuilder(
        stream: snapshots,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Text(
                  "수집된 데이터가 없어요 ㅜㅜ",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              );
            } else {
              return ListView(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ElectiveDetailScreen(
                                  snapshot.data.documents[index],
                                );
                              },
                            ),
                          );
                        },
                        child: TrendingItem(
                          date: snapshot.data.documents[index]['date'],
                          content: snapshot.data.documents[index]['content'],
                          title: (snapshot.data.documents[index]['lecture'] +
                              " :: " +
                              snapshot.data.documents[index]['professor']),
                          rating: int.parse(snapshot
                              .data.documents[index]['avg_rating']
                              .toStringAsFixed(0)),
                          department: snapshot.data.documents[index]
                              ['department'],
                          count: snapshot.data.documents[index]['count'],
                          tag1: snapshot.data.documents[index]['tag1_count'],
                          tag2: snapshot.data.documents[index]['tag2_count'],
                          tag3: snapshot.data.documents[index]['tag3_count'],
                          tag4: snapshot.data.documents[index]['tag4_count'],
                          tag5: snapshot.data.documents[index]['tag5_count'],
                          tag6: snapshot.data.documents[index]['tag6_count'],
                          appTitle: '강의후기',
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.0),
                ],
              );
            }
          } else {
            return Text(' ');
          }
        });
  }
}
