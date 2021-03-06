import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/util/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'comment_edit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:eck_app/widgets/trending_item.dart';

import 'elective_seconddetail.dart';

List<String> _tag = [
  '#강의는수면제성적은황천길',
  '#흥미로움',
  '#꿀교양',
  '#암기가많음',
  '#들었는데안들었어요',
  '#억지로들음',
];

// ignore: must_be_immutable
class ElectiveDetailScreen extends StatefulWidget {
  DocumentSnapshot snapshot;

  ElectiveDetailScreen(DocumentSnapshot snapshot) {
    this.snapshot = snapshot;
  }

  @override
  _ElectiveDetailScreenState createState() =>
      _ElectiveDetailScreenState(snapshot);
}

class _ElectiveDetailScreenState extends State<ElectiveDetailScreen> {
  var book;
  var active;
  var money;
  var total;
  DocumentSnapshot snapshot;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<QueryDocumentSnapshot> data = [];
  List<QueryDocumentSnapshot> viewData = [];
  int countdata = 10;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  final _valueList = ['최신순', '별점높은순','별점낮은순'];
  var _selectedValue = '최신순';

  _ElectiveDetailScreenState(DocumentSnapshot snapshot) {
    this.snapshot = snapshot;

    FirebaseFirestore.instance
        .collection('elective')
        .doc(snapshot['lecture'] + snapshot['professor'])
        .collection('information')
        .orderBy('date', descending: true)
        .get()
        .then((value) => data.addAll(value.docs))
        .whenComplete(() => setState(() {
              if (data.length < countdata) {
                viewData.addAll(data.sublist(0, data.length));
              } else {
                viewData.addAll(data.sublist(0, countdata));
              }
              countdata += 10;
            }))
        .whenComplete(() => setState(() {}));
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        if (closeTopContainer == false) {
          closeTopContainer = controller.offset > 10;
        } else {
          if (controller.offset < -10) {
            closeTopContainer = false;
          }
        }
      });
    });
  }

  setCount() {
    book = snapshot['expenditureCount'][0];
    active = snapshot['expenditureCount'][1];
    money = snapshot['expenditureCount'][2];
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

  @override
  Widget build(BuildContext context) {
    setCount();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(0xfff2f6fd),
          title: Text("강의후기",
              style: TextStyle(
                  color: Color(0xff3e4685), fontWeight: FontWeight.w700)),
          iconTheme: IconThemeData(color: Color(0xff3E4685)),

        ),
        body: Column(
          children: <Widget>[
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer
                    ? 0
                    : 360,
                child: buildElective(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0,top: 10),
              child: Container(
                height: 40,
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      width: 70,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          '총 ' + snapshot['count'].toString() + '개',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: Color(0xff3E4685)),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 90,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffd6e6fd)),
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Padding(
                          padding: EdgeInsets.all(0),
                        ),
                        icon: Image.asset(
                          'assets/dropdown.png',width: 18,
                        ),
                        value: _selectedValue,
                        items: _valueList.map((value){
                          return DropdownMenuItem(
                            value: value,
                            child: Center(child: Text(value,style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            if (_selectedValue != value){
                              data = [];
                              viewData = [];
                              countdata = 10;
                              _selectedValue = value;
                              if (value == '최신순'){
                                FirebaseFirestore.instance
                                    .collection('elective')
                                    .doc(snapshot['lecture'] + snapshot['professor'])
                                    .collection('information')
                                    .orderBy('date', descending: true)
                                    .get()
                                    .then((value) => data.addAll(value.docs))
                                    .whenComplete(() => setState(() {
                                  if (data.length < countdata) {
                                    viewData.addAll(data.sublist(0, data.length));
                                  } else {
                                    viewData.addAll(data.sublist(0, countdata));
                                  }
                                  countdata += 10;
                                }))
                                    .whenComplete(() => setState(() {}));
                              } else if (value == '별점높은순') {
                                FirebaseFirestore.instance
                                    .collection('elective')
                                    .doc(snapshot['lecture'] + snapshot['professor'])
                                    .collection('information')
                                    .orderBy('rating', descending: true)
                                    .orderBy('date', descending: true)
                                    .get()
                                    .then((value) => data.addAll(value.docs))
                                    .whenComplete(() => setState(() {
                                  if (data.length < countdata) {
                                    viewData.addAll(data.sublist(0, data.length));
                                  } else {
                                    viewData.addAll(data.sublist(0, countdata));
                                  }
                                  countdata += 10;
                                }))
                                    .whenComplete(() => setState(() {}));
                              } else if (value == '별점낮은순') {

                                FirebaseFirestore.instance
                                    .collection('elective')
                                    .doc(snapshot['lecture'] + snapshot['professor'])
                                    .collection('information')
                                    .orderBy('rating', descending: false)
                                    .orderBy('date', descending: true)
                                    .get()
                                    .then((value) => data.addAll(value.docs))
                                    .whenComplete(() => setState(() {
                                  if (data.length < countdata) {
                                    viewData.addAll(data.sublist(0, data.length));
                                  } else {
                                    viewData.addAll(data.sublist(0, countdata));
                                  }
                                  countdata += 10;
                                }))
                                    .whenComplete(() => setState(() {}));
                              }
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: false,
                  enablePullUp: true,
                  child: buildCtn(),
                  footer: ClassicFooter(
                    loadStyle: LoadStyle.ShowWhenLoading,
                    completeDuration: Duration(milliseconds: 500),
                  ),
                  onRefresh: null,
                  onLoading: () async {
                    //monitor fetch data from network
                    await Future.delayed(Duration(milliseconds: 180));
                    if (data.length < countdata) {
                      viewData = data.sublist(0, data.length);
                    } else {
                      viewData = data.sublist(0, countdata);
                    }
                    countdata += 10;
//        for (int i = 0; i < 10; i++) {
//          data.add("Item $i");
//        }
                    if (mounted) setState(() {});
                    _refreshController.loadNoData();
                  },
                )),
          ],
        ));
  }

  Widget buildCtn() {
    return ListView.separated(
      controller: controller,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => InkWell(
        child: Item(snapshot: viewData[i]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ElectiveSecondDetailScreen(null, viewData[i]);
              },
            ),
          );
        },
      ),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          //color: Colors.greenAccent,
        );
      },
      itemCount: viewData.length,
    );
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
      var book = snapshot['expenditureCount'][0];
      var active = snapshot['expenditureCount'][1];
      var money = snapshot['expenditureCount'][2];
      var total = book + active + money;

      if (total == 0) {
        return Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 35,
              width: 50,
              child:  Text(
                  '지출 사유',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                  textAlign: TextAlign.start,
                ),

            ),
            Container(
              width: MediaQuery.of(context).size.width-90,
              height: 35,
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
              height: 14,
              width: 50,
              child:Text(
                  '지출 사유',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                  textAlign: TextAlign.start,
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
      var book = snapshot['expenditureCount'][0];
      var active = snapshot['expenditureCount'][1];
      var money = snapshot['expenditureCount'][2];
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

    return Stack(
      children: [
        FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
                height: 360,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
          height: 200,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                height:
                                    40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Row(

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
                                            _cost[int.parse(snapshot['avg_cost']
                                                    .toStringAsFixed(0)) -
                                                1],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xff3E4685)),
                                          ),
                                          Text(
                                            _costdetail[int.parse(
                                                    snapshot['avg_cost']
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
                                    18,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: jicul(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top : 6,right: 20.0,left: 20.0),
                                    child: jiculdetail(),
                                  ),
                                ],
                              ),
                              Container(
                                height:
                                    2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height:
                                          20,
                                      width: 60,
                                      child: Center(
                                        child: Text(
                                          'Best Tag',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.grey),
                                        ),
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
                                  width: MediaQuery.of(context).size.width,
                                    child: TrendingItem(
                                  tag1: snapshot['tag1_count'],
                                  tag2: snapshot['tag2_count'],
                                  tag3: snapshot['tag3_count'],
                                  tag4: snapshot['tag4_count'],
                                  tag5: snapshot['tag5_count'],
                                  tag6: snapshot['tag6_count'],
                                  appTitle: '강의후기세부',
                                )),
                              )
                            ],
                          ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      Container(
                                        height: 20,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius:
                                            BorderRadius.circular(
                                                50)),
                                        child: Center(
                                          child: Text(
                                            snapshot['credit'] + '학점',
                                            style: TextStyle(
                                              color: Color(0xff3E4685),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (var i = 0;
                                          i <
                                              int.parse(
                                                  snapshot['avg_rating']
                                                      .toStringAsFixed(0));
                                          i++)
                                        Icon(
                                          Icons.star,
                                          color: Color(0xffffce60),
                                          size: 34,
                                        ),
                                      for (var i = int.parse(
                                              snapshot['avg_rating']
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
                                                              'avg_assignment']
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
                                                              'avg_communication']
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
                ))),
      ],
    );
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
}

// ignore: must_be_immutable
class Item extends StatefulWidget {
  final QueryDocumentSnapshot snapshot;


  Item({this.snapshot});

  @override
  _ItemState createState() => _ItemState(snapshot);
}

class _ItemState extends State<Item> {
  var index;
  QueryDocumentSnapshot snapshot;


  _ItemState(QueryDocumentSnapshot snapshot) {
    this.snapshot = snapshot;
  }

  buildTagList() {
    List<int> l = [];

    for (int i = 0; i < 6; i++) {
      if (snapshot['tag' + (i + 1).toString()]) {
        l.add(i);
      }
    }

    if (l.length == 0) {
      return null;
    } else if (l.length == 1) {
      return Row(
        children: [
          buildTag(_tag[l[0]]),
        ],
      );
    } else if (l.length == 2) {
      return Row(
        children: [
          buildTag(_tag[l[0]]),
          SizedBox(
            width: 5,
          ),
          buildTag(_tag[l[1]]),
        ],
      );
    } else if (l.length == 3) {
      return Row(
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
    } else if (l.length == 4) {
      return Column(
        children: [
          Row(
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
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              buildTag(_tag[l[3]]),
            ],
          )
        ],
      );
    } else if (l.length == 5) {
      return Column(
        children: [
          Row(
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
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              buildTag(_tag[l[3]]),
              SizedBox(
                width: 5,
              ),
              buildTag(_tag[l[4]]),
            ],
          )
        ],
      );
    } else if (l.length == 6) {
      return Column(
        children: [
          Row(
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
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            children: [
              buildTag(_tag[l[3]]),
              SizedBox(
                width: 5,
              ),
              buildTag(_tag[l[4]]),
              SizedBox(
                width: 5,
              ),
              buildTag(_tag[l[5]]),
            ],
          )
        ],
      );
    }
  }

  Widget buildTag(String t) {
    return Container(

      height: 20,
      decoration: BoxDecoration(
          color: Color(0xfff2f6fd), borderRadius: BorderRadius.circular(50)),
      child: Padding(
        padding: EdgeInsets.only(left: 5,right: 5),
        child: Center(
          child: Text(
            t,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 10,
                color: Color(0xff3E4685)),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
              padding: EdgeInsets.all(5),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 6),
                          for (var i = 0; i < snapshot['rating']; i++)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.star,
                                color: Color(0xffffce60),
                                size: 28.0,
                              ),
                            ),
                          for (var i = snapshot['rating']; i < 5; i++)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.black12,
                                size: 28.0,
                              ),
                            ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: buildTagList(),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Text(
                          snapshot['content'],
                          maxLines: 3,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            height: 1.3
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      )
                    ],
                  ),
                ],
              )),
        ));
  }

  @override
  void dispose() => super.dispose();
}
