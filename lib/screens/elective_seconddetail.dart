import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/util/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'comment_edit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:eck_app/widgets/trending_item.dart';

List<String> _tag = [
  '#강의는수면제성적은황천길',
  '#흥미로움',
  '#곰돌이푸맛집',
  '#암기가많음',
  '#들었는데안들었어요',
  '#억지로들음',
];

// ignore: must_be_immutable
class ElectiveSecondDetailScreen extends StatefulWidget {
  DocumentSnapshot snapshot;
  QueryDocumentSnapshot qsnapshot;

  ElectiveSecondDetailScreen(
  DocumentSnapshot snapshot, QueryDocumentSnapshot qsnapshot) {
    this.snapshot = snapshot;
    this.qsnapshot = qsnapshot;
  }

  @override
  _ElectiveSecondDetailScreenState createState() =>
      _ElectiveSecondDetailScreenState(snapshot, qsnapshot);
}

class _ElectiveSecondDetailScreenState
    extends State<ElectiveSecondDetailScreen> {
  var book;
  var active;
  var money;
  var total;
  var snapshot;

  _ElectiveSecondDetailScreenState(DocumentSnapshot snapshot, QueryDocumentSnapshot qsnapshot) {
    if (snapshot == null){
      this.snapshot = qsnapshot;
    } else {
      this.snapshot = snapshot;
    }

  }

  setCount() {
    book = snapshot['expenditure'][0] ? 1 : 0;
    active = snapshot['expenditure'][1] ? 1 : 0;
    money = snapshot['expenditure'][2] ? 1 : 0;

    total = book + active + money;

    if (total == 0) {
      book = 1;
      active = 1;
      money = 1;

      total = book + active + money;
      return total;
    } else {
      return total;
    }
  }

  teamproject(bool t) {
    String teamp;
    if (t) {
      teamp = 'O';
    } else {
      teamp = 'X';
    }
    return teamp;
  }

  @override
  Widget build(BuildContext context) {
    setCount();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(0xfff2f6fd),
          title: Text("강의후기세부",
              style: TextStyle(
                  color: Color(0xff3e4685), fontWeight: FontWeight.w700)),
          iconTheme: IconThemeData(color: Color(0xff3E4685)),
        ),
        body: //Container()
            buildElective());
  }

  buildElective() {
    List<String> _assignment = ['없음', '학기 1 ~ 2회', '월 1 ~ 2회', '주 1 ~ 2회'];

    List<String> _cost = [
      '',
      '0 ~ 10,000',
      '10,000 ~ 50,000',
      '50,000 ~ 100,000',
      '100,000'
    ];

    List<String> _costdetail = ['No Money', '원', '원', '원', '원 이상'];

    List<String> _communication = ['빠름', '보통', '느림'];

    jicul() {
      var book = snapshot['expenditure'][0] ? 1 : 0;
      var active = snapshot['expenditure'][1] ? 1 : 0;
      var money = snapshot['expenditure'][2] ? 1 : 0;

      var total = book + active + money;

      if (total == 0) {
        return  Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 20,
              width: 50,
              child:  Center(
                child: Text(
                  '지출 사유',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width-90,
              child: Text(
                '데이터가 없어요!',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xff324685),
                    fontSize: 20),
                textAlign: TextAlign.end,
              ),
            )
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 20,
              width: 50,
              child: Center(
                child: Text(
                  '지출 사유',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  height: 14,
                  width:
                  (MediaQuery.of(context).size.width-100)  * (book / total),
                  color: Colors.grey,
                ),
                Container(
                  height: 14,
                  width: (MediaQuery.of(context).size.width-100) *
                      (active / total),
                  color: Colors.yellowAccent[700],
                ),
                Container(
                  height: 14,
                  width: (MediaQuery.of(context).size.width-100)*
                      (money / total),
                  color: Color(0xff3E4685),
                ),
              ],
            ),
          ],
        );
      }
    }

    jiculdetail() {
      var book = snapshot['expenditure'][0] ? 1 : 0;
      var active = snapshot['expenditure'][1] ? 1 : 0;
      var money = snapshot['expenditure'][2] ? 1 : 0;

      var total = book + active + money;

      if (total == 0) {
        return null;
      } else {
        return Row(

          children: [
            Container(
              width: MediaQuery.of(context).size.width - 247,
            ),
            Container(
              height: 15,
              width: 15,
              color: Colors.grey,
            ),
            Container(
              width: 40,
              child: Text(
                ' 교재',
                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),
                textAlign: TextAlign.start,
              ),

            ),
            Container(
              height: 15,
              width: 15,
              color: Colors.yellowAccent[700],
            ),
            Container(
              width: 80,
              child: Text(
                ' 실습/견학비',
                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 15,
              width: 15,
              color: Color(0xff3E4685),
            ),
            Container(
              width: 42,
              child: Text(
                ' 재료비',
                style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),
                textAlign: TextAlign.end,
              ),

            )
          ],
        );
      }
    }

    return ListView(
      children: [
        Container(

            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 160,
                    ),
                    Container(

                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            height:
                            40,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:130,
                                  child: Text(
                                    '수업을 위해 지출하는 비용',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width -170,
                                  height:
                                  40,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        _cost[int.parse(snapshot['cost']
                                            .toStringAsFixed(0)) -
                                            1],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xff3E4685)),
                                      ),
                                      Text(
                                        _costdetail[int.parse(
                                            snapshot['cost']
                                                .toStringAsFixed(0)) -
                                            1],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff3E4685)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height:
                            10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: jicul(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                                child: jiculdetail(),
                              ),
                            ],
                          ),
                          Container(
                            height:
                            10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height:
                                  20,
                                  width: 60,
                                  child: Text(
                                    'Tag',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.grey),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width - 100,)
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20),
                            child: Container(
                                child: TrendingItem(
                              detail_tag1: snapshot['tag1'],
                              detail_tag2: snapshot['tag2'],
                              detail_tag3: snapshot['tag3'],
                              detail_tag4: snapshot['tag4'],
                              detail_tag5: snapshot['tag5'],
                              detail_tag6: snapshot['tag6'],
                              appTitle: '강의후기세세부',
                            )),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        snapshot['year'] +
                                            '년 ' +
                                            snapshot['semester'] +
                                            ' 수강' +
                                            ' l ' +
                                            setDate(snapshot['date'].toDate()),
                                        style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot['department'] + ' ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff3E4685),
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10),
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: 240,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffb5b5b6))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10,top: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 18,
                                          child: Center(
                                            child: Text(
                                              '내용',
                                              style: TextStyle(
                                                  fontSize:
                                                      12,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Text(
                                      snapshot['content'],
                                      maxLines: 99,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Colors.white,
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 10,
                  child: Container(
                    height: 192,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 4),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                          BorderRadius.circular(
                                              50)),
                                      width: 60,
                                      height: 20,
                                      child: Center(
                                          child: Text(
                                            snapshot['area'],
                                            style: TextStyle(
                                                color: Color(0xff3E4685),
                                                fontWeight:
                                                FontWeight.w800),
                                          ))),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  for (var i = 0;
                                  i <
                                      int.parse(
                                          snapshot['rating']
                                              .toStringAsFixed(0));
                                  i++)
                                    Icon(
                                      Icons.star,
                                      color: Color(0xffffce60),
                                      size: 34,
                                    ),
                                  for (var i = int.parse(
                                      snapshot['rating']
                                          .toStringAsFixed(0));
                                  i < 5;
                                  i++)
                                    Icon(
                                      Icons.star,
                                      color: Colors.black12,
                                      size: 34,
                                    ),
                                ],
                              ),
                              SizedBox(
                                  height: 8),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot['lecture'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: 6),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot['professor'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height:10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                  color: Color(0xfff2f6fd),
                                ),
                                height:
                                46,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: (MediaQuery.of(context).size.width - 317)/5, right: (MediaQuery.of(context).size.width - 317)/5
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:26,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: Text('팀플',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color:
                                                  Color(0xff3E4685))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15),
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50),
                                              color: Colors
                                                  .yellowAccent[700]),
                                          child: Center(
                                            child: Text(
                                              teamproject(snapshot[
                                              'team_project']),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  fontSize: 18,
                                                  color: Color(
                                                      0xff3E4685)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width -317)/5,
                                      ),
                                      Container(
                                        width: 26,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: Text('발표',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color:
                                                  Color(0xff3E4685))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15),
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50),
                                              color: Colors.white),
                                          child: Center(
                                            child: Text(
                                              teamproject(snapshot[
                                              'announcement']),
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  fontSize: 18,
                                                  color: Color(
                                                      0xff3E4685)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width -317)/5,
                                      ),
                                      Container(
                                        width: 26,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: Text('과제',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color:
                                                  Color(0xff3E4685))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15),
                                        child: Container(
                                          height: 26,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              color: Color(0xff3E4685)),
                                          child: Center(
                                            child: Text(
                                              _assignment[int.parse(
                                                  snapshot[
                                                  'assignment']
                                                      .toStringAsFixed(
                                                      0))],
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (MediaQuery.of(context).size.width - 317)/5,
                                      ),
                                      Container(
                                        width: 26,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: Text('소통',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  color:
                                                  Color(0xff3E4685))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15),
                                        child: Container(
                                          height: 26,
                                          width: 33,
                                          child: Center(
                                            child: Text(
                                              _communication[int.parse(
                                                  snapshot[
                                                  'communication']
                                                      .toStringAsFixed(
                                                      0))],
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w800,
                                                  fontSize: 14,
                                                  color: Color(
                                                      0xff3E4685)),
                                            ),
                                          ),
                                        ),
                                      )
//                                            Text(
//                                              '비용 : ' +
//                                                  _cost[int.parse(snapshot['avg_cost']
//                                                      .toStringAsFixed(0)) -
//                                                      1],
//                                              style: TextStyle(
//                                                  fontSize:
//                                                  MediaQuery.of(context).size.width *
//                                                      0.037,
//                                                  color: Colors.black),
//                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              //buildBestTagList(),
                            ],
                          ),
                        )),
                  ),
                )
              ],
            ))
      ],
    );
  }
}
