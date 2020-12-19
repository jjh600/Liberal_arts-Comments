import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/comment_edit.dart';
import 'package:eck_app/screens/my_comment.dart';
import 'package:eck_app/screens/notice_edit.dart';
import 'package:eck_app/util/date.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> _tag = [
  '#강의는수면제성적은황천길',
  '#흥미로움',
  '#곰돌이푸맛집',
  '#암기가많음',
  '#들었는데안들었어요',
  '#억지로들음',
];

class TrendingItem extends StatefulWidget {
  final String appTitle;
  final String title;
  final String content;
  final int rating;
  final Timestamp date;
  final String department;
  final int count;
  final int tag1;
  final int tag2;
  final int tag3;
  final int tag4;
  final int tag5;
  final int tag6;
  final bool detail_tag1;
  final bool detail_tag2;
  final bool detail_tag3;
  final bool detail_tag4;
  final bool detail_tag5;
  final bool detail_tag6;
  final DocumentSnapshot user;
  final DocumentSnapshot snapshot;

  TrendingItem(
      {Key key,
      @required this.appTitle,
      @required this.title,
      @required this.content,
      @required this.rating,
      @required this.date,
      @required this.department,
      @required this.count,
      @required this.tag1,
      @required this.tag2,
      @required this.tag3,
      @required this.tag4,
      @required this.tag5,
      @required this.tag6,
      @required this.snapshot,
      @required this.detail_tag1,
      @required this.detail_tag2,
      @required this.detail_tag3,
      @required this.detail_tag4,
      @required this.detail_tag5,
      @required this.detail_tag6,
      @required this.user})
      : super(key: key);

  @override
  _TrendingItemState createState() => _TrendingItemState();
}

class Constants {
  static const String FirstItem = '수정';
  static const String SecondItem = '삭제';

  static const List<String> choices = <String>[
    FirstItem,
    SecondItem,
  ];
}

Icon buildIcon(String choice) {
  if (choice == Constants.FirstItem) {
    return Icon(Icons.edit);
  } else if (choice == Constants.SecondItem) {
    return Icon(Icons.delete);
  }
}

class _TrendingItemState extends State<TrendingItem> {
  void choiceAction(String choice) {
    if (choice == Constants.FirstItem) {
      if (widget.user['manager'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NoticeEditScreen(widget.snapshot),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("알림"),
              content: new Text("수정 권한이 없습니다."),
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
    } else if (choice == Constants.SecondItem) {
      FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .get()
          .then((value) => value.docs.forEach((element) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(element.id)
                    .get()
                    .then((value) {
                  if (value['manager'] == true) {
                    FirebaseFirestore.instance
                        .collection('notice')
                        .where('title', isEqualTo: widget.snapshot['title'])
                        .where('date', isEqualTo: widget.snapshot['date'])
                        .get()
                        .then((value) => value.docs.forEach((element) {
                              FirebaseFirestore.instance
                                  .collection('notice')
                                  .doc(element.id)
                                  .delete();
                            }));
                    setState(() {});
                  } else {
                    return showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("알림"),
                          content: new Text("삭제 권한이 없습니다."),
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
    }
  }

  void choiceAction2(String choice) {
    if (choice == Constants.FirstItem) {
      if ((widget.user['userId'] == widget.snapshot['uid'])) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EditScreen(widget.snapshot),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("알림"),
              content: new Text("수정권한이 없습니다." +
                  widget.user['userId'] +
                  widget.snapshot['uid']),
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
    } else if (choice == Constants.SecondItem) {
      int count = 0;
      double avgRating = 0.0;
      List<int> tagsCount = [0, 0, 0, 0, 0, 0];
      List<int> expenditureCount = [0, 0, 0];
      String dId = '';
      double avgCost = 0.0;
      double avgAssignment = 0.0;
      double avgCommunication = 0.0;
      var commentList = {};

      if (widget.user['userId'] == widget.snapshot['uid'] ||
          widget.user['manager'] == true) {
        FirebaseFirestore.instance
            .collection('elective')
            .doc(widget.snapshot['lecture'] + widget.snapshot['professor'])
            .get()
            .then((value) => {
                  if (value['count'] == 1)
                    {
                      FirebaseFirestore.instance
                          .collection('elective')
                          .doc(widget.snapshot['lecture'] +
                              widget.snapshot['professor'])
                          .collection('information')
                          .where('uid', isEqualTo: widget.snapshot['uid'])
                          .where('date', isEqualTo: widget.snapshot['date'])
                          .get()
                          .then((value) => value.docs.forEach((element) {
                                FirebaseFirestore.instance
                                    .collection('elective')
                                    .doc(widget.snapshot['lecture'] +
                                        widget.snapshot['professor'])
                                    .collection('information')
                                    .doc(element.id)
                                    .delete()
                                    .whenComplete(() => {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser.uid)
                                              .get()
                                              .then((value) => {
                                                    commentList =
                                                        value['comment'],
                                                    commentList.remove(widget
                                                        .snapshot['date']
                                                        .millisecondsSinceEpoch
                                                        .toString()),
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            .uid)
                                                        .update({
                                                      'comment': commentList
                                                    })
                                                  })
                                        })
                                    .whenComplete(() => {
                                          FirebaseFirestore.instance
                                              .collection('elective')
                                              .doc(widget.snapshot['lecture'] +
                                                  widget.snapshot['professor'])
                                              .delete()
                                              .whenComplete(() =>

                                              Navigator.pushReplacementNamed(context, "/home"))
                                        });
                              }))
                    }
                  else
                    {
                      for (int i = 0; i < tagsCount.length; i++)
                        {
                          tagsCount[i] =
                              value['tag' + (i + 1).toString() + '_count'],
                          if (widget.snapshot['tag' + (i + 1).toString()])
                            {tagsCount[i] -= 1}
                        },
                      for (int i = 0; i < expenditureCount.length; i++)
                        {
                          expenditureCount[i] = value['expenditureCount'][i],
                          if (widget.snapshot['expenditure'][i])
                            {expenditureCount[i] -= 1}
                        },
                      count = value['count'],
                      avgRating = value['avg_rating'],
                      avgCost = value['avg_cost'],
                      avgAssignment = value['avg_assignment'],
                      avgCommunication = value['avg_communication'],
                      FirebaseFirestore.instance
                          .collection('elective')
                          .doc(widget.snapshot['lecture'] +
                              widget.snapshot['professor'])
                          .collection('information')
                          .where('uid', isEqualTo: widget.snapshot['uid'])
                          .where('date', isEqualTo: widget.snapshot['date'])
                          .get()
                          .then((value) => value.docs.forEach((element) {
                                FirebaseFirestore.instance
                                    .collection('elective')
                                    .doc(widget.snapshot['lecture'] +
                                        widget.snapshot['professor'])
                                    .collection('information')
                                    .doc(element.id)
                                    .delete()
                                    .whenComplete(() => {
                                          FirebaseFirestore.instance
                                              .collection('elective')
                                              .doc(widget.snapshot['lecture'] +
                                                  widget.snapshot['professor'])
                                              .collection('information')
                                              .orderBy('date', descending: true)
                                              .limit(1)
                                              .get()
                                              .then((value) =>
                                                  {dId = value.docs.last.id})
                                              .whenComplete(() => {
                                                    FirebaseFirestore.instance
                                                        .collection('elective')
                                                        .doc(widget.snapshot[
                                                                'lecture'] +
                                                            widget.snapshot[
                                                                'professor'])
                                                        .update({
                                                      'date': Timestamp
                                                              .fromMillisecondsSinceEpoch(
                                                                  int.parse(
                                                                      dId))
                                                          .toDate(),
                                                      'count': count - 1,
                                                      'avg_rating': (count *
                                                                  avgRating -
                                                              widget.snapshot[
                                                                  'rating']) /
                                                          (count - 1),
                                                      'tag1_count':
                                                          tagsCount[0],
                                                      'tag2_count':
                                                          tagsCount[1],
                                                      'tag3_count':
                                                          tagsCount[2],
                                                      'tag4_count':
                                                          tagsCount[3],
                                                      'tag5_count':
                                                          tagsCount[4],
                                                      'tag6_count':
                                                          tagsCount[5],
                                                      'avg_cost': (count *
                                                                  avgCost -
                                                              widget.snapshot[
                                                                  'cost']) /
                                                          (count - 1),
                                                      'avg_assignment': (count *
                                                                  avgAssignment -
                                                              widget.snapshot[
                                                                  'assignment']) /
                                                          (count - 1),
                                                      'avg_communication': (count *
                                                                  avgCommunication -
                                                              widget.snapshot[
                                                                  'communication']) /
                                                          (count - 1),
                                                      'expenditureCount':
                                                          expenditureCount,
                                                    }).whenComplete(() => {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      .uid)
                                                                  .get()
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            commentList =
                                                                                value['comment'],
                                                                            commentList.remove(widget.snapshot['date'].millisecondsSinceEpoch.toString()),
                                                                            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update({
                                                                              'comment': commentList
                                                                            })
                                                                          })
                                                                  .whenComplete(
                                                                      () =>
                                                                          setState(
                                                                              () {
                                                                                Navigator.pushReplacementNamed(context, "/home");

                                                                                
                                                                          }))
                                                            })
                                                  })
                                        });
                              }))
                    }
                });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("알림"),
              content: new Text("삭제권한이 없습니다."),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appTitle == '공지사항') {
      return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                right: 20,
                child: Container(
                  width: 30,
                  height: 30,
                  child: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      onSelected: choiceAction,
                      itemBuilder: (BuildContext context) {
                        return Constants.choices.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: buildIcon(choice),
                                ),
                                Text(choice,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),
                          );
                        }).toList();
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0, left: 15.0, right: 40.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Column(
              //   children: <Widget>[
              //     SizedBox(height: 7.0),
              //     Padding(
              //       padding: EdgeInsets.only(top: 6.0, left: 15.0, right: 15.0),
              //       child: Container(
              //         width: MediaQuery.of(context).size.width,
              //         child: Text(
              //           "${widget.title}",
              //           style: TextStyle(
              //             fontSize: 20.0,
              //             fontWeight: FontWeight.w800,
              //           ),
              //           textAlign: TextAlign.left,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ),
              //     ),
              //     SizedBox(height: 7.0),
              //     Padding(
              //       padding: EdgeInsets.only(left: 15.0, right: 15.0),
              //       child: Container(
              //         width: MediaQuery.of(context).size.width,
              //         child: Text(
              //           "${widget.content}",
              //           style: TextStyle(
              //             fontSize: 12.0,
              //             fontWeight: FontWeight.w300,
              //           ),
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 3,
              //         ),
              //       ),
              //     ),
              //     SizedBox(height: 5.0),
              //   ],
              // ),
              Positioned(
                left: 0,
                bottom: 10,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      setDate(widget.date.toDate()),
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.black12,
                ),
                bottom: 1,
              )
            ],
          ),
        ),
      );
    } else if (widget.appTitle == '강의후기') {
      return Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Container(
            height: 155,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    right: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          builcount(),
                          style: TextStyle(
                            color: Color(0xff3E4685),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: 150,
                            child: Row(
                              children: <Widget>[
                                for (var i = 0; i < widget.rating; i++)
                                  Icon(
                                    Icons.star,
                                    color: Color(0xffffce60),
                                    size: 30.0,
                                  ),
                                for (var i = widget.rating; i < 5; i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.black12,
                                    size: 30.0,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "${widget.title}",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xff3E4685),
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "Best Tag",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildBestTagList(),
                      ],
                    ),
                  )
                ],
              ),
            )),
      );
    } else if (widget.appTitle == '강의후기세부') {
      return detailbuildBestTagList();
    } else if (widget.appTitle == '내가쓴후기') {
      return Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Container(
            height: 145,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 40,
                      height: 30,
                      child: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          onSelected: choiceAction2,
                          itemBuilder: (BuildContext context) {
                            return Constants.choices.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: buildIcon(choice),
                                    ),
                                    Text(choice,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              );
                            }).toList();
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 20, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 150,
                          child: Row(
                            children: <Widget>[
                              for (var i = 0; i < widget.rating; i++)
                                Icon(
                                  Icons.star,
                                  color: Color(0xffffce60),
                                  size: 20.0,
                                ),
                              for (var i = widget.rating; i < 5; i++)
                                Icon(
                                  Icons.star,
                                  color: Colors.black12,
                                  size: 20.0,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.title}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xff3E4685),
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.content,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          setDate(widget.date.toDate()),
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      );
    } else if (widget.appTitle == '강의후기세세부') {
      return buildDetailTagList();
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Container(
            height: 145,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              child: Stack(
                children: [
                  Positioned(
                    top: 15,
                    right: 10,
                    child: Text(
                      setDate(widget.date.toDate()),
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 20, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 150,
                          child: Row(
                            children: <Widget>[
                              for (var i = 0; i < widget.rating; i++)
                                Icon(
                                  Icons.star,
                                  color: Color(0xffffce60),
                                  size: 20.0,
                                ),
                              for (var i = widget.rating; i < 5; i++)
                                Icon(
                                  Icons.star,
                                  color: Colors.black12,
                                  size: 20.0,
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.title}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xff3E4685),
                            fontWeight: FontWeight.w800,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.content,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.department,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      );
    }
  }

  builcount() {
    if (widget.count > 999) {
      return "999\+";
    } else {
      return widget.count.toString();
    }
  }

  Widget detailbuildBestTagList() {
    List<int> tag = [
      widget.tag1,
      widget.tag2,
      widget.tag3,
      widget.tag4,
      widget.tag5,
      widget.tag6
    ];
    List<int> l = [];
    int max = 0;

    for (int i = 0; i < 6; i++) {
      if (i == 0) {
        max = tag[i];
        l.add(i);
      } else {
        if (max < tag[i]) {
          max = tag[i];
          l = [i];
        } else if (max == tag[i]) {
          l.add(i);
        }
      }
    }

    if (max == 0) {
      return Center(child: Text('태그가 없어요.'));
    }

    if (l.length == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          detailbuildTag(_tag[l[0]]),
        ],
      );
    } else if (l.length == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          detailbuildTag(_tag[l[0]]),
          SizedBox(
            width: 5,
          ),
          detailbuildTag(_tag[l[1]]),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          detailbuildTag(_tag[l[0]]),
          SizedBox(
            width: 5,
          ),
          detailbuildTag(_tag[l[1]]),
          SizedBox(
            width: 5,
          ),
          detailbuildTag(_tag[l[2]]),
        ],
      );
    }
  }

  Widget buildDetailTagList() {
    List<int> tag = [
      widget.detail_tag1 ? 1 : 0,
      widget.detail_tag2 ? 1 : 0,
      widget.detail_tag3 ? 1 : 0,
      widget.detail_tag4 ? 1 : 0,
      widget.detail_tag5 ? 1 : 0,
      widget.detail_tag6 ? 1 : 0
    ];
    List<int> l = [];

    for (int i = 0; i < 6; i++) {
      if (tag[i] == 1) {
        l.add(i);
      } else {}
    }

    if (l.length == 0) {
      return Center(child: Text('태그가 없어요.'));
    }

    if (l.length == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          buildSecondTag(_tag[l[0]]),
        ],
      );
    } else if (l.length == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          buildSecondTag(_tag[l[0]]),
          SizedBox(
            width: 5,
          ),
          buildSecondTag(_tag[l[1]]),
        ],
      );
    } else if (l.length == 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          buildSecondTag(_tag[l[0]]),
          SizedBox(
            width: 5,
          ),
          buildSecondTag(_tag[l[1]]),
          SizedBox(
            width: 5,
          ),
          buildSecondTag(_tag[l[2]]),
        ],
      );
    } else if (l.length == 4) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              buildSecondTag(_tag[l[0]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[1]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[2]]),
            ],
          ),
          Container(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              buildSecondTag(_tag[l[3]]),
            ],
          )
        ],
      );
    } else if (l.length == 5) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              buildSecondTag(_tag[l[0]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[1]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[2]]),
            ],
          ),
          Container(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              buildSecondTag(_tag[l[3]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[4]]),
            ],
          )
        ],
      );
    } else if (l.length == 6) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              buildSecondTag(_tag[l[0]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[1]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[2]]),
            ],
          ),
          Container(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              buildSecondTag(_tag[l[3]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[4]]),
              SizedBox(
                width: 5,
              ),
              buildSecondTag(_tag[l[5]]),
            ],
          )
        ],
      );
    }
  }

  Widget buildBestTagList() {
    List<int> tag = [
      widget.tag1,
      widget.tag2,
      widget.tag3,
      widget.tag4,
      widget.tag5,
      widget.tag6
    ];
    List<int> l = [];
    int max = 0;

    for (int i = 0; i < 6; i++) {
      if (i == 0) {
        max = tag[i];
        l.add(i);
      } else {
        if (max < tag[i]) {
          max = tag[i];
          l = [i];
        } else if (max == tag[i]) {
          l.add(i);
        }
      }
    }

    if (max == 0) {
      return Center(child: Text('태그가 없어요.'));
    }

    if (l.length == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          buildTag(_tag[l[0]]),
        ],
      );
    } else if (l.length == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          buildTag(_tag[l[0]]),
          SizedBox(
            width: 5,
          ),
          buildTag(_tag[l[1]]),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          buildTag(_tag[l[0]]),
          SizedBox(
            width: 5,
          ),
          buildTag(_tag[l[1]]),
          SizedBox(
            width: 5,
          ),
          buildTag(_tag[l[2]]),
        ],
      );
    }
  }

  Widget buildTag(String t) {
    return Container(
      height: 20,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xfff2f6fd), borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              t,
              style: TextStyle(
                  fontSize: 10,
                  color: Color(0xff3e4685),
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSecondTag(String t) {
    return Container(
      height: 20,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff3e4685), borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              t,
              style: TextStyle(
                  fontSize: 10,
                  color: Color(0xfff2f6fd),
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailbuildTag(String t) {
    return Container(
      height: 20,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff3e4685), borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              t,
              style: TextStyle(
                  fontSize: 10,
                  color: Color(0xfff2f6fd),
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
