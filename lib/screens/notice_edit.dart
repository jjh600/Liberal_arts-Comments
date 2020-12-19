import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/elective.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoticeEditScreen extends StatefulWidget {
  DocumentSnapshot snapshot;

  NoticeEditScreen(DocumentSnapshot snapshot) {
    this.snapshot = snapshot;
  }
  @override
  _NoticeEditScreenState createState() => _NoticeEditScreenState(snapshot);
}

class _NoticeEditScreenState extends State<NoticeEditScreen> {
  DocumentSnapshot snapshot;
  final _formKey = GlobalKey<FormState>();
  String title, contents, type, highlight;

  _NoticeEditScreenState(DocumentSnapshot snapshot) {
    this.snapshot = snapshot;
    if (snapshot != null) {
      highlight = snapshot['highlight'];
      title = snapshot['title'];
      contents = snapshot['contents'];
      type = snapshot['type'];
    }
  }

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
        body: ListView(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 40, top: 40, right: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffd6e6fd)),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButtonFormField(
                            icon: Image.asset(
                              'assets/dropdown.png',width: 40,
                            ),
                            iconSize: 50,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            },
                            validator: (value) {
                              if (value == null) {
                                return '공지타입을 선택주세요!';
                              }
                              return null;
                            },
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            items: ['이벤트', '업데이트', '일정']
                                .map((e) => DropdownMenuItem(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (selectedAccountArea) {
                              setState(() {
                                type = selectedAccountArea;
                              });
                            },
                            value: type,
                            isExpanded: false,
                            hint: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '공지 타입',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffd6e6fd)),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            initialValue: title,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return '제목을 써주세요!';
                              }
                              title = value;
                              return null;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w700),
                              hintText: '제목',
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffd6e6fd)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              initialValue: highlight,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '내용 하이라이트를 써주세요!';
                                }
                                highlight = value;
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700),
                                hintText: '내용 하이라이트',
                              ),
                              maxLines: 1,
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xffd6e6fd)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: TextFormField(
                                textInputAction: TextInputAction.newline,
                                initialValue: contents,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '내용을 써주세요!';
                                  }
                                  contents = value;
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w700),
                                  hintText: '내용',
                                ),
                                maxLines: 25,
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          child: Text("Write",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          color: Color(0xff324685),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          onPressed: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (_formKey.currentState.validate()) {
                              if (snapshot != null) {
                                FirebaseFirestore.instance
                                    .collection('notice')
                                    .doc(snapshot.id)
                                    .update({
                                  'title': title,
                                  'contents': contents,
                                  'type': type,
                                  'highlight': highlight,
                                });
                                setState(() {
                                  Navigator.pop(context);
                                });
                              } else {
                                FirebaseFirestore.instance
                                    .collection('notice')
                                    .add({
                                  'title': title,
                                  'contents': contents,
                                  'type': type,
                                  'highlight': highlight,
                                  'date': DateTime.now()
                                });
                                setState(() {
                                  Navigator.pop(context);
                                });
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
