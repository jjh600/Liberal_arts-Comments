import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/gaein.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:eck_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordrightKey =
  GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _studentIDKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phonenumKey = GlobalKey<FormFieldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordrigthController =
  TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _phonenumController = TextEditingController();

  var _isChecked = false;
  var _buttonChecked = false;
  final focusNode = FocusNode();

  var selectedType;
  List<String> _accountType = <String>[
    '인문융합공공인재학부',
    '법경영학부',
    '웰니스산업융합학부',
    '응용자원환경학부',
    '동물생명융합학부',
    '생명공학부',
    '건설환경공학부',
    '사회안전시스템공학부',
    '식품생명화학공학부',
    '컴퓨터응용수학부',
    'ICT로봇기계공학부',
    '전자전기공학부',
    '디자인건축융합학부'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
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
                        "Welcome",
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
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(color: Color(0xfff2f6fd), child: _inputForm(context))),
    );
  }

  gotoGaein(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Gaein()));
  }

  gotoLogin(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
  }

  Widget _inputForm(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //Container(height: 60, color: Colors.white),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 12, bottom: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      icon: Image.asset('assets/Email.png'),
                                      labelText: "이메일(학교 웹메일을 입력해주세요.)",
                                      hintText: "@hknu.ac.kr",
                                      border: InputBorder.none),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "이메일을 입력해주세요";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    setState(() {
                                      _check(context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: TextFormField(
                                  key: _passwordKey,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      icon: Image.asset('assets/pass.png'),
                                      labelText: "비밀번호(6자리 이상 입력해주세요.)",
                                      border: InputBorder.none),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "비밀번호를 입력해주세요";
                                    }
                                    if (value.length < 6) {
                                      return "6자리 이상 입력해주세요.";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    setState(() {
                                      _check(context);
                                      _passwordKey.currentState.validate();
                                      _passwordrightKey.currentState.validate();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: TextFormField(
                                  //obscureText: true,
                                  key: _passwordrightKey,
                                  controller: _passwordrigthController,
                                  decoration: InputDecoration(
                                      icon: Image.asset('assets/pass.png'),
                                      labelText: "비밀번호 확인",
                                      border: InputBorder.none),
                                  validator: (String value) {
                                    if (value.isEmpty &&
                                        _passwordController.text.trim().length >
                                            5) {
                                      return "비밀번호를 입력해주세요.";
                                    }
                                    if (value !=
                                        _passwordController.text.trim() &&
                                        value.length > 0) {
                                      return "비밀번호가 일치하지 않습니다.";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    setState(() {
                                      _check(context);
                                      _passwordrightKey.currentState.validate();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.insert_emoticon),
                                      labelText: "이름",
                                      border: InputBorder.none),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "이름을 입력해주세요";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    setState(() {
                                      _check(context);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  key: _studentIDKey,
                                  controller: _studentIDController,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.assignment_ind),
                                      labelText: "학번",
                                      border: InputBorder.none),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "학번을 입력해주세요.";
                                    }
                                    if (value.length < 10) {
                                      return "학번을 입력해주세요.";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    setState(() {
                                      _check(context);
                                      _studentIDKey.currentState.validate();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  key: _phonenumKey,
                                  controller: _phonenumController,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.call),
                                      labelText: "핸드폰 번호(-를 제외하고 입력해주세요.)",
                                      border: InputBorder.none),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "핸드폰 번호를 입력해주세요.";
                                    }
                                    if (value.length < 11) {
                                      return "핸드폰 번호를 입력해주세요.";
                                    }
                                    return null;
                                  },
                                  onChanged: (text) {
                                    setState(() {
                                      _check(context);
                                      _phonenumKey.currentState.validate();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffd6e6fd)),
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropdownButtonFormField(
                                icon: Image.asset('assets/dropdown.png',width: 40,),
                                decoration: InputDecoration(
                                    prefixIcon:
                                    Image.asset('assets/Department.png'),
                                    border: InputBorder.none),
                                items: _accountType
                                    .map((value) => DropdownMenuItem(
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20),
                                  ),
                                  value: value,
                                ))
                                    .toList(),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                },
                                onChanged: (selectedAccountType) {
                                  setState(() {
                                    selectedType = selectedAccountType;
                                  });
                                  _check(context);
                                },
                                value: selectedType,
                                hint: Text(
                                  '학과를 선택해주세요.',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Container(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 10.0),
                                child: GestureDetector(
                                    onTap: () {
                                      gotoGaein(context);
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                    child: Text("개인정보 취급방침",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff324685),
                                            fontWeight: FontWeight.w800))),
                              ),
                              Row(
                                children: <Widget>[
                                  CircularCheckBox(
                                    checkColor: Colors.yellow,
                                    activeColor: Color(0xff324685),
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChecked = value;
                                      });
                                      _check(context);
                                    },
                                  ),
                                  Text(
                                    "동의",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff324685),
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Container(
                                    width: 20,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 20),
                  _authButton(context),
                  Container(height: MediaQuery.of(context).size.width * 0.25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _authButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          child: Text("Signup",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          color: _buttonChecked ? Color(0xff324685) : Colors.grey,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: _buttonChecked
              ? () {
            if (_formKey.currentState.validate()) {
              if (_passwordController.text.trim() !=
                  _passwordrigthController.text.trim()) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("알림"),
                      content: new Text("비밀번호가 일치하지 않습니다.\n다시 확인해주세요."),
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
              } else if (_passwordController.text.trim().length < 5 &&
                  _passwordrigthController.text.trim().length < 5) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("알림"),
                      content: new Text("비밀번호를 6자리 이상 입력해주세요."),
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
              } else if (_phonenumController.text.trim().length < 10) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("알림"),
                      content: new Text("핸드폰 번호를 입력해주세요."),
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
              } else {
                _register(context);
                //Navigator.pop(context);
              }
            }
          }
              : null,
        ),
      ),
    );
  }

  Widget _check(BuildContext context) {
    if (_emailController.text.length != 0 &&
        _passwordController.text.length > 5 &&
        _passwordrigthController.text.length > 5 &&
        _passwordrigthController.text == _passwordController.text &&
        _nameController.text.length != 0 &&
        selectedType != null &&
        _studentIDController.text.length > 9 &&
        _phonenumController.text.length > 10 &&
        _isChecked) {
      _buttonChecked = true;
    } else {
      _buttonChecked = false;
    }
  }

  _register(BuildContext context) async {
    try {
      String emailcorrect = _emailController.text.trim();
      String str =
      emailcorrect.substring(emailcorrect.length - 11, emailcorrect.length);

      if (str == '@hknu.ac.kr') {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        if (result.user != null) {
          result.user.sendEmailVerification();
          Firestore.instance.collection('users').doc(result.user.uid).set({
            'userId': result.user.uid,
            'userName': _nameController.text.trim(),
            'department': selectedType.toString(),
            'manager': false,
            'studentId': _studentIDController.text.trim(),
            'phonenumber': _phonenumController.text.trim(),
            'comment': {}
          });
          FocusScope.of(context).requestFocus(new FocusNode());
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("가입을 환영합니다!"),
                content: new Text("이메일을 인증하셔야 로그인이 가능합니다."),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("확인"),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("알림"),
              content: new Text("학교 웹메일을 입력해주세요."),
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
      if (error.runtimeType.toString() == 'FirebaseAuthException') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("알림"),
              content: new Text("이미 가입된 이메일입니다."),
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
      } else if (error.runtimeType.toString() == 'RangeError') {
        final snacBar = SnackBar(
          content: Text('학교 웹메일을 입력해 주세요.'),
        );
        Scaffold.of(_formKey.currentContext).showSnackBar(snacBar);
      }
    }
  }
}