import 'package:circular_check_box/circular_check_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/util/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  DocumentSnapshot snapshot;

  EditScreen(DocumentSnapshot snapshot) {
    this.snapshot = snapshot;
  }

  @override
  _EditScreenState createState() => _EditScreenState(snapshot);
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _contentController = TextEditingController();
  var snapshot;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  var selectedArea,
      selectedLecture,
      selectedProfessor,
      selectedYear,
      selectedSemester,
      selectedCredit = "",
      selectedDifficulty,
      content = '',
      assignment = 0,
      communication = 0,
      exam = '',
      cost = 3,
      department = '',
      costContainerWidth = 160.0,
      writing = false;
  bool _buttonChecked = false;
  List<List<Color>> _tagColors = [
    [Colors.white, Color(0xff3E4685)],
    [Colors.white, Color(0xff3E4685)],
    [Colors.white, Color(0xff3E4685)],
    [Colors.white, Color(0xff3E4685)],
    [Colors.white, Color(0xff3E4685)],
    [Colors.white, Color(0xff3E4685)],
  ];
  List<bool> _tags = [false, false, false, false, false, false];
  List<bool> _assignment = [true, false, false, false];
  List<String> _cost = [
    'No Money',
    '0 ~ 10,000원',
    '10,000 ~ 50,000원',
    '50,000 ~ 100,000원',
    '100,000원 이상'
  ];
  List<bool> _selections = [true, false];
  List<bool> _announcementSelections = [true, false];
  List<bool> _expenditureSelections = [false, false, false];
  List<bool> _communicationSelections = [true, false, false];
  List<bool> _starSelections = [true, false, false, false, false];

  _EditScreenState(DocumentSnapshot snapshot) {
    this.snapshot = snapshot;

    FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => {department = value.docs[0]['department']});

    if (snapshot != null) {
      _contentController.text = snapshot['content'];
      selectedArea = snapshot['area'];
      selectedLecture = snapshot['lecture'];
      selectedProfessor = snapshot['professor'];
      selectedCredit = snapshot['credit'];
      selectedYear = snapshot['year'];
      selectedSemester = snapshot['semester'];
      _assignment[0] = false;
      _assignment[snapshot['assignment']] = true;
      _communicationSelections[0] = false;
      _communicationSelections[snapshot['communication']] = true;
      cost = snapshot['cost'];
      if (!snapshot['team_project']) {
        _selections[0] = false;
        _selections[1] = true;
      }
      if (!snapshot['announcement']) {
        _announcementSelections[0] = false;
        _announcementSelections[1] = true;
      }
      for (var i = 1; i < snapshot['rating']; i++) {
        _starSelections[i] = true;
      }
      for (var i = 0; i < _tags.length; i++) {
        _tags[i] = snapshot['tag' + (i + 1).toString()];
        if (_tags[i]) {
          _tagColors[i][0] = Color(0xff3E4685);
          _tagColors[i][1] = Colors.white;
        }
      }
      for (var i = 0; i < _expenditureSelections.length; i++) {
        _expenditureSelections[i] = snapshot['expenditure'][i];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff2f6fd),
        title: Text("강의 후기 작성",
            style: TextStyle(
                color: Color(0xff3E4685),
                fontWeight: FontWeight.w400,
                fontSize: 25)),
        elevation: 0.0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        iconTheme: IconThemeData(color: Color(0xff3E4685)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .requestFocus(new FocusNode());
        },
        child: Form(
            key: _formKeyValue,
            autovalidate: false,
            child: new ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 30,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 160,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  icon: Image.asset(
                                    'assets/dropdown.png',width: 40,
                                  ),
                                  items: areas
                                      .map((e) => DropdownMenuItem(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 10),
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                  color: Color(0xff3E4685),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (selectedAccountArea) {
                                    setState(() {
                                      selectedArea = selectedAccountArea;
                                      selectedLecture = null;
                                      selectedProfessor = null;
                                      selectedCredit = '   ';
                                      _check();
                                    });
                                    selectLecture();
                                  },
                                  value: selectedArea,
                                  isExpanded: false,
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '영역',
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )),
                            ),
                            Container(
                              height: 45,
                              width: 80,
                              child: Card(
                                  color: Colors.black12,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(90.0)),
                                  elevation: 0.0,
                                  child: Center(
                                    child: Text(
                                      selectedCredit + '학점',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff3E4685),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffd6e6fd)),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(border: InputBorder.none),
                            icon: Image.asset(
                              'assets/dropdown.png',width: 40,
                            ),
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            validator: (value) {
                              if (value == null) {
                                return '과목을 선택주세요!';
                              }
                              return null;
                            },
                            items: selectLecture()
                                .map((e) => DropdownMenuItem(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: Color(0xff3E4685),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (selectedAccountLecture) {
                              setState(() {
                                selectedLecture = selectedAccountLecture;
                                selectedProfessor = null;
                                _check();
                              });
                            },
                            value: selectedLecture,
                            isExpanded: false,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '과목',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffd6e6fd)),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(border: InputBorder.none),
                            icon: Image.asset(
                              'assets/dropdown.png',width: 40,
                            ),
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            validator: (value) {
                              if (value == null) {
                                return '교수님을 선택주세요!';
                              }
                              return null;
                            },
                            items: selectProfessor()
                                .map((e) => DropdownMenuItem(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: Color(0xff3E4685),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (selectedAccountProfessor) {
                              setState(() {
                                selectedProfessor = selectedAccountProfessor;
                                _check();
                              });
                            },
                            value: selectedProfessor,
                            isExpanded: false,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '교수',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 80) / 2 -
                                      10,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                icon: Image.asset(
                                  'assets/dropdown.png',width: 40,

                                ),

                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return '수강년도를 선택주세요!';
                                  }
                                  return null;
                                },
                                items: ['2018', '2019', '2020']
                                    .map((e) => DropdownMenuItem(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                color: Color(0xff3E4685),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (selectedAccountYear) {
                                  setState(() {
                                    selectedYear = selectedAccountYear;
                                    _check();
                                  });
                                },
                                value: selectedYear,
                                isExpanded: false,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '수강년도',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 80) / 2 -
                                      10,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                icon: Image.asset(
                                  'assets/dropdown.png',width: 40,
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return '수강학기를 선택주세요!';
                                  }
                                  return null;
                                },
                                items: ['1학기', '2학기']
                                    .map((e) => DropdownMenuItem(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                color: Color(0xff3E4685),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          value: e,
                                        ))
                                    .toList(),
                                onChanged: (selectedAccountSemester) {
                                  setState(() {
                                    selectedSemester = selectedAccountSemester;
                                    _check();
                                  });
                                },
                                value: selectedSemester,
                                isExpanded: false,
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '수강학기',
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 130,
                  padding: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 90,
                        child: Card(
                            color: Colors.black12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0)),
                            elevation: 0.0,
                            child: Center(
                              child: Text(
                                '강의 별점',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ToggleButtons(
                            children: [
                              Icon(
                                Icons.star,
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                size: 50,
                              ),
                              Icon(
                                Icons.star,
                                size: 50,
                              )
                            ],
                            renderBorder: false,
                            selectedColor: Color(0xffffce60),
                            color: Colors.black12,
                            fillColor: Colors.white,
                            isSelected: _starSelections,
                            onPressed: (int index) {
                              setState(() {
                                for (int i = 0; i < index + 1; i++) {
                                  _starSelections[i] = true;
                                }

                                for (int i = index + 1; i < 5; i++) {
                                  _starSelections[i] = false;
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 50,
                              child: Text(
                                '팀플',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff3E4685),
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _selections[0],
                              onChanged: (value) {
                                setState(() {
                                  if (_selections[0] == false) {
                                    _selections[0] = true;
                                    _selections[1] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 280,
                            child: Text(
                              '있음',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _selections[1],
                              onChanged: (value) {
                                setState(() {
                                  if (_selections[1] == false) {
                                    _selections[1] = true;
                                    _selections[0] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Text(
                              '없음',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 50,
                              child: Text(
                                '과제',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff3E4685),
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _assignment[0],
                              onChanged: (value) {
                                setState(() {
                                  if (_assignment[0] == false) {
                                    assignment = 0;
                                    _assignment[0] = true;
                                    _assignment[1] = false;
                                    _assignment[2] = false;
                                    _assignment[3] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 280,
                            child: Text(
                              '없음',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _assignment[1],
                              onChanged: (value) {
                                setState(() {
                                  if (_assignment[1] == false) {
                                    assignment = 1;
                                    _assignment[1] = true;
                                    _assignment[0] = false;
                                    _assignment[2] = false;
                                    _assignment[3] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width:
                            80,
                            child: Text(
                              '학기 1~2회',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _assignment[2],
                              onChanged: (value) {
                                setState(() {
                                  if (_assignment[2] == false) {
                                    assignment = 2;
                                    _assignment[2] = true;
                                    _assignment[1] = false;
                                    _assignment[0] = false;
                                    _assignment[3] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 280,
                            child: Text(
                              '월 1~2회',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _assignment[3],
                              onChanged: (value) {
                                setState(() {
                                  if (_assignment[3] == false) {
                                    assignment = 3;
                                    _assignment[3] = true;
                                    _assignment[1] = false;
                                    _assignment[0] = false;
                                    _assignment[2] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Text(
                              '주 1~2회',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 50,
                              child: Text(
                                '발표',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff3E4685),
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _announcementSelections[0],
                              onChanged: (value) {
                                setState(() {
                                  if (_announcementSelections[0] == false) {
                                    _announcementSelections[0] = true;
                                    _announcementSelections[1] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 280,
                            child: Text(
                              '있음',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _announcementSelections[1],
                              onChanged: (value) {
                                setState(() {
                                  if (_announcementSelections[1] == false) {
                                    _announcementSelections[1] = true;
                                    _announcementSelections[0] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Text(
                              '없음',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Container(
                            width: 50,
                            child: Text(
                              '비용',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff3E4685),
                                fontWeight: FontWeight.w800,
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width - 120,
                          child:
                          Slider(
                                value: cost.toDouble(),
                                min: 1.0,
                                max: 5.0,
                                activeColor: Color(0xff3E4685),
                                divisions: 4,

                                onChanged: (double newValue) {
                                  setState(() {
                                    if (newValue.round() == 1) {
                                      costContainerWidth = 100;
                                    } else if (newValue.round() == 2) {
                                      costContainerWidth = 120;
                                    } else if (newValue.round() == 3) {
                                      costContainerWidth = 160;
                                    } else if (newValue.round() == 4) {
                                      costContainerWidth = 180;
                                    } else if (newValue.round() == 5) {
                                      costContainerWidth = 140;
                                    }
                                    cost = newValue.round();
                                  });
                                }),

                        ),
                      ]),
                      Container(
                        height: 40,
                        width: costContainerWidth,
                        child: Card(
                            color: Colors.black12,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(90.0)),
                            elevation: 0.0,
                            child: Center(
                              child: Text(
                                _cost[cost - 1],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff3E4685),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 60,
                              child: Text(
                                '지출이유',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff3E4685),
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _expenditureSelections[0],
                              onChanged: (value) {
                                setState(() {
                                  if (_expenditureSelections[0] == false) {
                                    _expenditureSelections[0] = true;
                                  } else {
                                    _expenditureSelections[0] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              '교재',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: (MediaQuery.of(context).size.width - 358)/2,),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _expenditureSelections[1],
                              onChanged: (value) {
                                setState(() {
                                  if (_expenditureSelections[1] == false) {
                                    _expenditureSelections[1] = true;
                                  } else {
                                    _expenditureSelections[1] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 44,
                            child: Text(
                              '실습/견학비',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: (MediaQuery.of(context).size.width - 358)/2,),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _expenditureSelections[2],
                              onChanged: (value) {
                                setState(() {
                                  if (_expenditureSelections[2] == false) {
                                    _expenditureSelections[2] = true;
                                  } else {
                                    _expenditureSelections[2] = false;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 44,
                            child: Text(
                              '재료비',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 60,
                              child: Text(
                                '소통',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff3E4685),
                                  fontWeight: FontWeight.w800,
                                ),
                              )),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _communicationSelections[0],
                              onChanged: (value) {
                                setState(() {
                                  if (_communicationSelections[0] == false) {
                                    _communicationSelections[0] = true;
                                    _communicationSelections[1] = false;
                                    _communicationSelections[2] = false;
                                    communication = 0;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 30,
                            child: Text(
                              '빠름',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: (MediaQuery.of(context).size.width - 358)/2,),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _communicationSelections[1],
                              onChanged: (value) {
                                setState(() {
                                  if (_communicationSelections[1] == false) {
                                    _communicationSelections[1] = true;
                                    _communicationSelections[0] = false;
                                    _communicationSelections[2] = false;
                                    communication = 1;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 44,
                            child: Text(
                              '보통',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: (MediaQuery.of(context).size.width - 358)/2,),
                          Container(
                            width: 40,
                            child: CircularCheckBox(
                              checkColor: Colors.yellow,
                              activeColor: Color(0xff324685),
                              value: _communicationSelections[2],
                              onChanged: (value) {
                                setState(() {
                                  if (_communicationSelections[2] == false) {
                                    _communicationSelections[2] = true;
                                    _communicationSelections[1] = false;
                                    _communicationSelections[0] = false;
                                    communication = 2;
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 44,
                            child: Text(
                              '느림',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'Tag',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff3E4685),
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0.0,
                              color: _tagColors[0][0],
                              onPressed: () {
                                setState(() {
                                  if (_tags[0] == false) {
                                    _tagColors[0][0] = Color(0xff3E4685);
                                    _tagColors[0][1] = Colors.white;
                                    _tags[0] = true;
                                  } else {
                                    _tagColors[0][1] = Color(0xff3E4685);
                                    _tagColors[0][0] = Colors.white;
                                    _tags[0] = false;
                                  }
                                });
                              },
                              child: Text(
                                '강의는수면제성적은황천길',
                                style: TextStyle(
                                    color: _tagColors[0][1],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 30,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0.0,
                              color: _tagColors[1][0],
                              onPressed: () {
                                setState(() {
                                  if (_tags[1] == false) {
                                    _tagColors[1][0] = Color(0xff3E4685);
                                    _tagColors[1][1] = Colors.white;
                                    _tags[1] = true;
                                  } else {
                                    _tagColors[1][1] = Color(0xff3E4685);
                                    _tagColors[1][0] = Colors.white;
                                    _tags[1] = false;
                                  }
                                });
                              },
                              child: Text('흥미로움',
                                  style: TextStyle(
                                      color: _tagColors[1][1],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0.0,
                              color: _tagColors[2][0],
                              onPressed: () {
                                setState(() {
                                  if (_tags[2] == false) {
                                    _tagColors[2][0] = Color(0xff3E4685);
                                    _tagColors[2][1] = Colors.white;
                                    _tags[2] = true;
                                  } else {
                                    _tagColors[2][1] = Color(0xff3E4685);
                                    _tagColors[2][0] = Colors.white;
                                    _tags[2] = false;
                                  }
                                });
                              },
                              child: Text(
                                '꿀교양',
                                style: TextStyle(
                                    color: _tagColors[2][1],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 30,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0.0,
                              color: _tagColors[3][0],
                              onPressed: () {
                                setState(() {
                                  if (_tags[3] == false) {
                                    _tagColors[3][0] = Color(0xff3E4685);
                                    _tagColors[3][1] = Colors.white;
                                    _tags[3] = true;
                                  } else {
                                    _tagColors[3][1] = Color(0xff3E4685);
                                    _tagColors[3][0] = Colors.white;
                                    _tags[3] = false;
                                  }
                                });
                              },
                              child: Text('암기가많아요',
                                  style: TextStyle(
                                      color: _tagColors[3][1],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0.0,
                              color: _tagColors[4][0],
                              onPressed: () {
                                setState(() {
                                  if (_tags[4] == false) {
                                    _tagColors[4][0] = Color(0xff3E4685);
                                    _tagColors[4][1] = Colors.white;
                                    _tags[4] = true;
                                  } else {
                                    _tagColors[4][1] = Color(0xff3E4685);
                                    _tagColors[4][0] = Colors.white;
                                    _tags[4] = false;
                                  }
                                });
                              },
                              child: Text(
                                '들었는데안들었어요',
                                style: TextStyle(
                                    color: _tagColors[4][1],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 30,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0.0,
                              color: _tagColors[5][0],
                              onPressed: () {
                                setState(() {
                                  if (_tags[5] == false) {
                                    _tagColors[5][0] = Color(0xff3E4685);
                                    _tagColors[5][1] = Colors.white;
                                    _tags[5] = true;
                                  } else {
                                    _tagColors[5][1] = Color(0xff3E4685);
                                    _tagColors[5][0] = Colors.white;
                                    _tags[5] = false;
                                  }
                                });
                              },
                              child: Text('억지로들음',
                                  style: TextStyle(
                                      color: _tagColors[5][1],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 240,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffd6e6fd)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: TextFormField(
                            controller: _contentController,
                            textInputAction: TextInputAction.newline,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return '총평을 써주세요!';
                              } else {
                                if (value.length < 10) {
                                  return '10글자 이상 써주세요!';
                                }
                              }
                              content = value;
                              return null;
                            },
                            onChanged: (a) {
                              setState(() {
                                _check();
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w700),
                              hintText: '강의총평 (10글자 이상)'

                            ),
                            maxLines: 12,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              child: Text("Writing",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              color: _buttonChecked ? Color(0xff324685) : Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              onPressed: _buttonChecked
                                  ? () {

                                if (!writing) {
                                  writing = true;
                                  if (_formKeyValue.currentState.validate()) {
                                  int rating = 0;
                                  int count = 0;
                                  List<int> tagsCount = [0, 0, 0, 0, 0, 0];
                                  List<int> expenditureCount = [0, 0, 0];
                                  double avgRating = 0.0;
                                  double avgCost = 0.0;
                                  double avgAssignment = 0.0;
                                  double avgCommunication = 0.0;
                                  DateTime date = DateTime.now();
                                  var commentList = {};

                                  for (bool a in _starSelections) {
                                    if (a == true) rating++;
                                  }

                                  if (snapshot != null) {
                                    FirebaseFirestore.instance
                                        .collection('elective')
                                        .doc(selectedLecture + selectedProfessor)
                                        .get()
                                        .then((value) => {
                                              count = value['count'],
                                              avgRating = value['avg_rating'],
                                              avgCost = value['avg_cost'],
                                              avgAssignment =
                                                  value['avg_assignment'],
                                              avgCommunication =
                                                  value['avg_communication'],
                                              for (int i = 0;
                                                  i < _tags.length;
                                                  i++)
                                                {
                                                  if (_tags[i])
                                                    {
                                                      tagsCount[i] = value['tag' +
                                                              (i + 1).toString() +
                                                              '_count'] +
                                                          1,
                                                    }
                                                  else
                                                    {
                                                      tagsCount[i] = value['tag' +
                                                          (i + 1).toString() +
                                                          '_count'],
                                                    },
                                                  if (snapshot[
                                                      'tag' + (i + 1).toString()])
                                                    {tagsCount[i] -= 1}
                                                },
                                              for (int i = 0;
                                                  i <
                                                      _expenditureSelections
                                                          .length;
                                                  i++)
                                                {
                                                  if (_expenditureSelections[i])
                                                    {
                                                      expenditureCount[i] =
                                                          value['expenditureCount']
                                                                  [i] +
                                                              1
                                                    }
                                                  else
                                                    {
                                                      expenditureCount[i] = value[
                                                          'expenditureCount'][i]
                                                    },
                                                  if (snapshot['expenditure'][i])
                                                    {expenditureCount[i] -= 1}
                                                }
                                            })
                                        .whenComplete(() => {
                                              FirebaseFirestore.instance
                                                  .collection('elective')
                                                  .doc(selectedLecture +
                                                      selectedProfessor)
                                                  .update({
                                                'lecture': selectedLecture,
                                                'professor': selectedProfessor,
                                                'avg_rating': (count * avgRating +
                                                        rating -
                                                        snapshot['rating']) /
                                                    count,
                                                'content': content,
                                                'area': selectedArea,
                                                'credit': selectedCredit,
                                                'tag1_count': tagsCount[0],
                                                'tag2_count': tagsCount[1],
                                                'tag3_count': tagsCount[2],
                                                'tag4_count': tagsCount[3],
                                                'tag5_count': tagsCount[4],
                                                'tag6_count': tagsCount[5],
                                                'expenditureCount':
                                                    expenditureCount,
                                                'avg_cost': (count * avgCost +
                                                        cost -
                                                        snapshot['cost']) /
                                                    (count),
                                                'avg_assignment': (count *
                                                            avgAssignment +
                                                        assignment -
                                                        snapshot['assignment']) /
                                                    (count),
                                                'avg_communication': (count *
                                                            avgCommunication +
                                                        communication -
                                                        snapshot[
                                                            'communication']) /
                                                    count,
                                              }).whenComplete(() => {
                                                        FirebaseFirestore.instance
                                                            .collection(
                                                                'elective')
                                                            .doc(selectedLecture +
                                                                selectedProfessor)
                                                            .collection(
                                                                'information')
                                                            .doc(snapshot.id)
                                                            .update({
                                                          'area': selectedArea,
                                                          'lecture':
                                                              selectedLecture,
                                                          'professor':
                                                              selectedProfessor,
                                                          'credit':
                                                              selectedCredit,
                                                          'year': selectedYear,
                                                          'semester':
                                                              selectedSemester,
                                                          'team_project':
                                                              _selections[0],
                                                          'announcement':
                                                              _announcementSelections[
                                                                  0],
                                                          'content': content,
                                                          'expenditure':
                                                              _expenditureSelections,
                                                          'rating': rating,
                                                          'assignment':
                                                              assignment,
                                                          'communication':
                                                              communication,
                                                          'cost': cost,
                                                          'tag1': _tags[0],
                                                          'tag2': _tags[1],
                                                          'tag3': _tags[2],
                                                          'tag4': _tags[3],
                                                          'tag5': _tags[4],
                                                          'tag6': _tags[5],
                                                        }).whenComplete(() => setState(() {
                                                          Navigator.pushReplacementNamed(context, "/home");
                                                        }))
                                                      })
                                            });
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection('elective')
                                        .doc(selectedLecture + selectedProfessor)
                                        .get()
                                        .then((value) => {
                                              if (value.exists)
                                                {
                                                  count = value['count'],
                                                  avgRating = value['avg_rating'],
                                                  avgAssignment =
                                                      value['avg_assignment'],
                                                  avgCost = value['avg_cost'],
                                                  avgCommunication =
                                                      value['avg_communication'],
                                                  for (int i = 0;
                                                      i < _tags.length;
                                                      i++)
                                                    {
                                                      if (_tags[i])
                                                        {
                                                          tagsCount[
                                                              i] = value['tag' +
                                                                  (i + 1)
                                                                      .toString() +
                                                                  '_count'] +
                                                              1,
                                                        }
                                                      else
                                                        {
                                                          tagsCount[i] = value[
                                                              'tag' +
                                                                  (i + 1)
                                                                      .toString() +
                                                                  '_count'],
                                                        },
                                                    },
                                                  for (int i = 0;
                                                      i <
                                                          _expenditureSelections
                                                              .length;
                                                      i++)
                                                    {
                                                      if (_expenditureSelections[
                                                          i])
                                                        {
                                                          expenditureCount[i] =
                                                              value['expenditureCount']
                                                                      [i] +
                                                                  1
                                                        }
                                                      else
                                                        {
                                                          expenditureCount[
                                                              i] = value[
                                                                  'expenditureCount']
                                                              [i]
                                                        },
                                                    }
                                                }
                                              else
                                                {
                                                  for (int i = 0;
                                                      i < _tags.length;
                                                      i++)
                                                    {
                                                      if (_tags[i])
                                                        {
                                                          tagsCount[i] += 1,
                                                        }
                                                    },
                                                  for (int i = 0;
                                                      i <
                                                          _expenditureSelections
                                                              .length;
                                                      i++)
                                                    {
                                                      if (_expenditureSelections[
                                                          i])
                                                        {expenditureCount[i] += 1}
                                                    }
                                                }
                                            })
                                        .whenComplete(() => {
                                              FirebaseFirestore.instance
                                                  .collection('elective')
                                                  .doc(selectedLecture +
                                                      selectedProfessor)
                                                  .set({
                                                    'lecture': selectedLecture,
                                                    'professor':
                                                        selectedProfessor,
                                                    'date': date,
                                                    'count': count + 1,
                                                    'avg_rating':
                                                        (count * avgRating +
                                                                rating) /
                                                            (count + 1),
                                                    'content': content,
                                                    'area': selectedArea,
                                                    'credit': selectedCredit,
                                                    'tag1_count': tagsCount[0],
                                                    'tag2_count': tagsCount[1],
                                                    'tag3_count': tagsCount[2],
                                                    'tag4_count': tagsCount[3],
                                                    'tag5_count': tagsCount[4],
                                                    'tag6_count': tagsCount[5],
                                                    'expenditureCount':
                                                        expenditureCount,
                                                    'team_project':
                                                        _selections[0],
                                                    'announcement':
                                                        _announcementSelections[
                                                            0],
                                                    'avg_cost':
                                                        (count * avgCost + cost) /
                                                            (count + 1),
                                                    'avg_assignment':
                                                        (count * avgAssignment +
                                                                assignment) /
                                                            (count + 1),
                                                    'avg_communication': (count *
                                                                avgCommunication +
                                                            communication) /
                                                        (count + 1),
                                                    'department': department,
                                                  })
                                                  .whenComplete(() => {
                                                        FirebaseFirestore.instance
                                                            .collection(
                                                                'elective')
                                                            .doc(selectedLecture +
                                                                selectedProfessor)
                                                            .collection(
                                                                'information')
                                                            .doc(date
                                                                .millisecondsSinceEpoch
                                                                .toString())
                                                            .set({
                                                          'area': selectedArea,
                                                          'lecture':
                                                              selectedLecture,
                                                          'professor':
                                                              selectedProfessor,
                                                          'credit':
                                                              selectedCredit,
                                                          'year': selectedYear,
                                                          'semester':
                                                              selectedSemester,
                                                          'team_project':
                                                              _selections[0],
                                                          'announcement':
                                                              _announcementSelections[
                                                                  0],
                                                          'expenditure':
                                                              _expenditureSelections,
                                                          'content': content,
                                                          'rating': rating,
                                                          'date': date,
                                                          'uid': FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              .uid,
                                                          'assignment':
                                                              assignment,
                                                          'communication':
                                                              communication,
                                                          'cost': cost,
                                                          'tag1': _tags[0],
                                                          'tag2': _tags[1],
                                                          'tag3': _tags[2],
                                                          'tag4': _tags[3],
                                                          'tag5': _tags[4],
                                                          'tag6': _tags[5],
                                                          'department': department
                                                        })
                                                      })
                                                  .whenComplete(() => {
                                                        FirebaseFirestore.instance
                                                            .collection('users')
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                .uid)
                                                            .get()
                                                            .then((value) => {
                                                                  commentList =
                                                                      value[
                                                                          'comment'],
                                                                  commentList[date
                                                                          .millisecondsSinceEpoch
                                                                          .toString()] =
                                                                      selectedLecture +
                                                                          selectedProfessor
                                                                })
                                                            .whenComplete(() => {
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser
                                                                          .uid)
                                                                      .update({
                                                                    'comment':
                                                                        commentList
                                                                  })
                                                                }).whenComplete(() => setState(() {
                                                          Navigator.pushReplacementNamed(context, "/home");
                                                        }))
                                                      })
                                            });
                                  }

                                }}
                              }:null)),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  List<String> selectLecture() {
    List<String> list = [];
    for (var a in lectures) {
      if (a['area'] == selectedArea && !list.contains(a['lecture'])) {
        list.add(a['lecture']);
      }
    }
    return list;
  }

  List<String> selectProfessor() {
    List<String> list = [];
    for (var a in lectures) {
      if (a['lecture'] == selectedLecture && !list.contains(a['professor'])) {
        list.add(a['professor']);
        selectedCredit = a['credit'].toString();
      }
    }
    return list;
  }

  Widget _check() {
    if (_contentController.text.length > 9 && selectedArea != null && selectedLecture != null && selectedProfessor != null && selectedYear != null && selectedSemester != null
        ) {
      _buttonChecked = true;
    } else {
      _buttonChecked = false;
    }
  }
}
