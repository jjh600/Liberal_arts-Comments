import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/widgets/trending_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'elective_seconddetail.dart';

// ignore: must_be_immutable
class MyCommentScreen extends StatefulWidget {
  DocumentSnapshot user;

  MyCommentScreen(DocumentSnapshot user) {
    this.user = user;
  }

  @override
  _MyCommentScreenState createState() => _MyCommentScreenState();
}

class _MyCommentScreenState extends State<MyCommentScreen> {
  List<DocumentSnapshot> myCommentList = [];
  bool comment = true;

  _MyCommentScreenState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) =>
    {
      if (value['comment'].length > 0)
        {
          value['comment'].forEach((key, value) {
            FirebaseFirestore.instance
                .collection('elective')
                .doc(value)
                .collection('information')
                .doc(key)
                .get()
                .then((value) => myCommentList.add(value))
                .whenComplete(() =>
                setState(() {
                  myCommentList.sort(
                          (a, b) => a['date'].compareTo(b['date']));
                }));
          })
        } else {
        comment = false,
      }
    }).whenComplete(() => setState((){}));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff2f6fd),
        title: Text("내가 쓴 후기",
            style: TextStyle(
                color: Color(0xff3E4685),
                fontWeight: FontWeight.w700,
                fontSize: 20)),
        elevation: 0.0,
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height * 0.1,
        iconTheme: IconThemeData(color: Color(0xff3E4685)),
      ),
      body:buildMyComment(),
    );
  }
  
  buildMyComment() {
    if (comment == false ){
      return Center(child: Text('후기를 작성해주세요!', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Color(0xff3E4685)),));
    } else {
      return Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            ListView.builder(
                primary: false,
                reverse: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: myCommentList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ElectiveSecondDetailScreen(
                                myCommentList[index],null);
                          },
                        ),
                      );
                    },
                    child: TrendingItem(
                      date: myCommentList[index]['date'],
                      content: myCommentList[index]['content'],
                      title: myCommentList[index]['lecture'] +
                          " :: " +
                          myCommentList[index]['professor'],
                      rating: myCommentList[index]['rating'],
                      department: myCommentList[index]['department'],
                      appTitle: '내가쓴후기',
                      user: widget.user,
                      snapshot: myCommentList[index],
                    ),
                  );
                }),
            SizedBox(height: 10.0),
          ],
        ),
      );
    }
  }
}
