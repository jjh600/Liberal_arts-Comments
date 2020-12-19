import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/notice_detail.dart';
import 'package:eck_app/screens/notice_edit.dart';
import 'package:eck_app/widgets/trending_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoticeScreen extends StatefulWidget {
  DocumentSnapshot user;

  NoticeScreen(DocumentSnapshot user) {
    this.user = user;
  }

  @override
  _NoticeScreenState createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Image.asset('assets/logo5.png',
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit:BoxFit.fitHeight),
                onTap: () {
                  Navigator.pop(context);
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                      child: GestureDetector(
                          child: Text(
                            "공지사항",
                            style: TextStyle(
                                color: Color(0xff324685),
                                fontSize: 25,
                                fontWeight: FontWeight.w300),
                          ),
                          onDoubleTap: () {
                            return FirebaseFirestore.instance
                                .collection('users')
                                .where('userId',
                                    isEqualTo:
                                        FirebaseAuth.instance.currentUser.uid)
                                .get()
                                .then((value) => value.docs.forEach((element) {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(element.id)
                                          .get()
                                          .then((value) {
                                        if (value['manager'] == true) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return NoticeEditScreen(null);
                                              },
                                            ),
                                          );
                                        } else {
                                          return showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: new Text("알림"),
                                                content: new Text(
                                                    "공지사항 작성 권한이 없습니다."),
                                                actions: <Widget>[
                                                  new FlatButton(
                                                    child: new Text("확인"),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      });
                                    }));
                          })),
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.15,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('notice')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();
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
                                        return NoticeDetailScreen(
                                            snapshot.data.documents[index],
                                            widget.user);
                                      },
                                    ),
                                  );
                                },
                                child: TrendingItem(
                                  appTitle: '공지사항',
                                  title: (snapshot.data.documents[index]
                                      ['title']),
                                  content: (snapshot.data.documents[index]
                                      ['contents']),
                                  date: (snapshot.data.documents[index]
                                      ['date']),
                                  user: widget.user,
                                  snapshot: snapshot.data.documents[index],
                                  department: null,
                                  rating: null,
                                ),
                              );
                            })
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
