import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
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
                  gotoLogin(context);
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                      child: Text(
                        "비밀번호 초기화",
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xffd6e6fd)),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Image.asset('assets/Email.png'),
                        labelText: "이메일(학교 웹메일을 입력해주세요.)",
                        border: InputBorder.none),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "이메일을 입력해주세요.";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(height: 30),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                    child: Text("비밀번호 초기화",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    color: Color(0xff324685),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailController.text.trim());
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("메일이 발송되었습니다."),
                              content: new Text("이메일을 확인해주세요."),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("확인"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  gotoLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
  }
}
