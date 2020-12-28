import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/util/date.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class NoticeDetailScreen extends StatefulWidget {
  DocumentSnapshot snapshot;
  DocumentSnapshot user;

  NoticeDetailScreen(DocumentSnapshot snapshot, DocumentSnapshot user) {
    this.snapshot = snapshot;
    this.user = user;
  }
  @override
  _NoticeDetailScreenState createState() => _NoticeDetailScreenState(snapshot);
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  DocumentSnapshot snapshot;

  _NoticeDetailScreenState(DocumentSnapshot snapshot) {
    this.snapshot = snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(
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
                        child: Text(
                          "공지사항",
                          style: TextStyle(
                              color: Color(0xff324685),
                              fontSize: 25,
                              fontWeight: FontWeight.w300),
                        )),
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
            padding: EdgeInsets.fromLTRB(15, 30, 5, 0),
            child: ListView(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 70.0),
                            child: Text(
                              snapshot['title'],
                              style: TextStyle(fontSize: 28, color: Colors.black,
                              fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 70.0),
                          child: Text(
                            snapshot['contents'],
                            style: TextStyle(fontSize: 16, color: Colors.black,
                            fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Text(
                              setDate(snapshot['date'].toDate()),
                              textAlign: TextAlign.end,
                            )),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ))
              ],
            ),));
  }
}