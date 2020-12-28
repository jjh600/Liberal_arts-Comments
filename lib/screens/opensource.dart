import 'package:flutter/material.dart';

class OpenSource extends StatelessWidget {
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
                    height: MediaQuery.of(context).size.width * 0.195),
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
                      child: GestureDetector(
                    child: Text(
                      "Open Source Licence",
                      style: TextStyle(
                          color: Color(0xff324685),
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
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
      // Scaffold의 appBar는 사용하지 않음. Scaffold의 appBar는 고정 크기와 영역을 가짐
      // CustomScrollView 등록
      body: CustomScrollView(
        // CustomScrollView는 children이 아닌 slivers를 사용하며, slivers에는 스크롤이 가능한 위젯이나 리스트가 등록가능함
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\n"),
                Text(
                  " 깃허브 ",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035),
                ),
                Text(
                  "https://github.com/Solido/awesome-flutter\n",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.029),
                ),
                Text(
                  " Pub.dev ",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035),
                ),
                Text(
                  "https://pub.dev\n",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.029),
                ),
                Text(
                  " Flutter ",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035),
                ),
                Text(
                  "https://flutter.dev\n",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.029),
                ),
                Text(
                  " Firebase ",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035),
                ),
                Text(
                  "https://firebase.flutter.dev/docs/auth/usage\n",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.029),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
