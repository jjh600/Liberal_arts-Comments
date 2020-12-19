import 'package:eck_app/screens/elective.dart';
import 'package:eck_app/screens/elective_detail.dart';
import 'package:eck_app/screens/gaein.dart';
import 'package:eck_app/screens/notice.dart';
import 'package:eck_app/screens/notice_detail.dart';
import 'package:eck_app/screens/secret.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eck_app/widgets/slide_item.dart';
import 'package:eck_app/widgets/trending_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_comment.dart';
import 'opensource.dart';
import 'package:eck_app/screens/comment_edit.dart';
import 'package:eck_app/util/search.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DocumentSnapshot user;
  String department = '', name = '';
  int _pageSize = 1;
  int _currentPage = 0;
  PageController _controller = PageController();
  int count = 0;

  _HomeState() {
    count = 0;
    FirebaseFirestore.instance
        .collection('elective')
        .get()
        .then((value) => value.docs.forEach((element) {
      count += element.data()['count'];
    }))
        .whenComplete(() => setState(() {
    }));

    FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      user = value.docs[0];
      department = value.docs[0]['department'];
      name = value.docs[0]['userName'];
    }).whenComplete(() => setState(() {}));

  }

  _setCount(){
    count = 0;
    FirebaseFirestore.instance
        .collection('elective')
        .get()
        .then((value) => value.docs.forEach((element) {
      count += element.data()['count'];
    }))
        .whenComplete(() => setState(() {
    }));
  }

  // ignore: must_call_super
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'assets/logo5.png',
          height: MediaQuery.of(context).size.height * 0.1,
          fit:BoxFit.fitHeight
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Color(0xff3E4685)),
        backgroundColor: Color(0xfff2f6fd),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 280,
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child:
                      GestureDetector(
                          child: Image.asset('assets/hi.png',
                            fit:BoxFit.fill
                              ),
                        onDoubleTap: () {
                            if (user['manager']){
                              Navigator.of(context)
                                  .push(new MaterialPageRoute(
                                  builder: (_) => new SecretScreen()));
                            }
                        },
                        ),

                    ),
                  ),
                  Container(
                    height: 20,
                  ),

                  Text(
                    department,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff3E4685),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Container(
                    height: 25,
                    width: 80,
                    child: RaisedButton(
                        child: Text("Logout",
                            style: TextStyle(
                                fontSize:
                                    14,
                                color: Color(0xff3E4685),
                                fontWeight: FontWeight.w800)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        }),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 40,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        'HOME',
                        style: TextStyle(
                            fontSize: 17,
                            color: Color(0xff3E4685),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        '공지사항',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff3E4685)),
                      ),
                    ),
                    onTap: () {
                      MaterialPageRoute route = new MaterialPageRoute(
                          builder: (_) => new NoticeScreen(user));
                      Navigator.of(context)
                          .push(route)
                          ;
                    },
                  ),
                ),
                Container(
                  height: 40,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        '강의후기 보기',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff3E4685)),
                      ),
                    ),
                    onTap: () {
                      MaterialPageRoute route = new MaterialPageRoute(
                          builder: (_) => new ElectiveScreen());
                      Navigator.of(context)
                          .push(route).then((value) => _setCount())
                          ;
                    },
                  ),
                ),
                Container(
                  height: 40,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        '강의후기 쓰기',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff3E4685)),
                      ),
                    ),
                    onTap: () {
                      MaterialPageRoute route = new MaterialPageRoute(
                          builder: (_) => new EditScreen(null));
                      Navigator.of(context)
                          .push(route)
                          ;
                    },
                  ),
                ),
                Container(
                  height: 40,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        '내가 쓴 후기',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff3E4685)),
                      ),
                    ),
                    onTap: () {
                      MaterialPageRoute route = new MaterialPageRoute(
                          builder: (_) => new MyCommentScreen(user));
                      Navigator.of(context)
                          .push(route).then((value) => _setCount())
                         ;
                    },
                  ),
                ),
                Container(
                  height: 40,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        '강의 검색',
                        style:
                            TextStyle(fontSize: 17, color: Color(0xff3E4685)),
                      ),
                    ),
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: Search(),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 590,
            ),

            Container(
              height: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '문의 메일',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  Text(
                    'wnsgh600@gmail.com',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    height: 20,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Color(0xffc3d0ef),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          gotoOpensource();
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: Center(
                          child: Text(
                            "Open Source Licence",
                            style: TextStyle(fontSize: 12),
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        gotoGaein();
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: Center(
                        child: Text(
                          "개인정보 취급방침",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 3.0,
              child: Column(
                children: [
                  buildNoticeList(user),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(_pageSize, (int index) {
                        return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: 10,
                            width: 10,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (index == _currentPage)
                                    ? Color(0xff3E4685)
                                    : Color(0xfff2f6fd)));
                      })),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 10),
            buildCategoryRow('강의후기', user),
            buildElectiveList(user),
          ],
        ),
      ),
    );
  }

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  buildCategoryRow(String category, DocumentSnapshot user) {
    return Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "$category",
                style: TextStyle(
                  color: Color(0xff3E4685),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              width: 80,
              height: 60,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Card(
                color: Colors.black12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90.0)),
                elevation: 0.0,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      '총 ' + count.toString() + '개',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff3E4685),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          if ("$category" == "공지사항") {
                            return NoticeScreen(user);
                          } else {
                            return ElectiveScreen();
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }

  buildNoticeList(DocumentSnapshot user) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notice')
            .orderBy('date', descending: true)
            .limit(5)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              _pageSize = snapshot.data.documents.length;
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return NoticeDetailScreen(
                            snapshot.data.documents[index], user);
                      },
                    ),
                  );
                },
                child: SlideItem(
                    title: (snapshot.data.documents[index]['title']),
                    content: (snapshot.data.documents[index]['highlight']),
                    date: (snapshot.data.documents[index]['date'].toDate()),
                    type: (snapshot.data.documents[index]['type'])),
              );
            },
          );
        },
      ),
    );
  }

  buildElectiveList(DocumentSnapshot user) {
    return Container(
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).size.height * 0.1 + 285),
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('elective')
                .orderBy('date', descending: true)
                .limit(10)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return ListView(
                children: <Widget>[
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
                                    snapshot.data.documents[index]);
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
                          appTitle: null,
                        ),
                      );
                    },
                  ),
                ],
              );
            }));
  }

  gotoGaein() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Gaein()));
  }

  gotoOpensource() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OpenSource()));
  }
}
