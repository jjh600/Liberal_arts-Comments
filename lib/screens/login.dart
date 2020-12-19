import 'package:eck_app/screens/forget_pw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eck_app/screens/sign_up.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ListView(children: <Widget>[

            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(
                'assets/logo4.png',

                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            _inputForm(size, context),
            _authButton(size, context),
            Container(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            gotoSignUp(context);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          child: Text(
                            "sign up",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            gotoForgetPw(context);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          },
                          child: Text(
                            "forgot password?",
                            style: TextStyle(fontSize: 20, color: Colors.grey),
                          )),
                    ),
                  ],
                ),
              ),
            ),

          ])
        ],
      ),
    ));
  }

  void _login(BuildContext context) async {

    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      if (result.user.emailVerified != true) {
        FirebaseAuth.instance.signOut();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("알림"),
              content: new Text("이메일 인증을 확인해주세요."),
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
    } catch (error) {
      print(error);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("알림"),
            content: new Text("잘못입력하셨습니다.."),
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
//    Navigator.push(context,
//        MaterialPageRoute(builder: (context) => MainPage(email: user.email)));
  }


  Widget _authButton(Size size, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          child: Text("Login",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          color: Color(0xff324685),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            if (_formKey.currentState.validate()) {
              _login(context);
            }
          },
        ),
      ),
    );
  }

  Widget _inputForm(Size size, BuildContext context) {
    return Container(
      color: Color(0xfff2f6fd),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Container(
                  child: Card(
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(

                              icon: Icon(Icons.account_circle),
                              labelText: "이메일",
                              hintText: "@hknu.ac.kr",
                              border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty) {
                              //return "이메일을 입력해주세요.";
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("이메일을 입력해 주세요."),
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
                            return null;
                          }),
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Container(


                  child: Card(
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                          obscureText: true,
                          obscuringCharacter: '*',
                          controller: _passwordController,
                          decoration: InputDecoration(
                              icon: Icon(Icons.vpn_key),
                              labelText: "비밀번호",
                              border: InputBorder.none),
                          validator: (String value) {
                            if (value.isEmpty) {
                              //return "비밀번호를 입력해주세요.";
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("비밀번호를 입력해 주세요."),
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
                            return null;
                          }),
                    ),
                  ),
                ),
              ),
              Container(height: 30),
            ],
          )),
    );
  }

  gotoForgetPw(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPw()));
  }

  gotoSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}
