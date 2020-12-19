import 'package:flutter/material.dart';

class Gaein extends StatelessWidget {
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
                      "개인정보 취급방침",
                      style: TextStyle(
                          color: Color(0xff324685),
                          fontSize: 25,
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
              child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. 개인정보 처리방침",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    '개인정보 처리방침은 이시국앱이 서비스를 제공함에 있어, 개인정보를 어떻게 수집, 이용, 보관, 파기하는지에 대한 정보를 담은 방침을 의미합니다. 개인정보 처리방침은 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 국내 개인정보 보호 법령을 모두 준수하고 있습니다.'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "2. 수집하는 개인정보의 항목",
                  style: TextStyle(fontSize: 20),
                ),
                Text("이시국앱은 서비스 제공을 위해 아래 항목 중 최소한의 개인정보를 수집합니다."),
                Text("1. 회원가입을 할 경우"),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(' - 이메일, 이름, 학번, 전화번호, 학과')),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "3. 수집한 개인정보의 이용",
                  style: TextStyle(fontSize: 20),
                ),
                Text("이시국앱은 쾌적한 서비스를 제공하기 위해, 아래의 목적에 한해 개인정보를 이용합니다."),
                Text("1. 가입 확인, 회원 식별 등 회원 관리"),
                Text('2. 서비스 제공 및 기존, 신규 시스템 개발, 유지, 개선'),
                Text('3. 불법, 약관 위반 게시물 게시 등 부정행위 방지를 위한 운영 시스템 개발, 유지, 개선'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "4. 개인정보의 제3자 제공 및 처리위탁",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    "회사는 관련법 및 회원의 동의가 없는 한, 회원의 개인정보를 제3자에게 절대 제공하지 않습니다. 단, 회사는 보안성 높은 서비스 제공을 위하여, 신뢰도가 검증된 아래 회사에 개인정보 관련 업무 처리를 위탁 할 수 있습니다. 이 경우 회사는 회원에게 위탁을 받는 자와 업무의 내용을 사전에 알리고 동의를 받습니다. 위탁을 받는 자 또는 업무의 내용이 변경될 경우에도 같습니다."),
                Text(
                    '이시국앱은 정보통신서비스의 제공에 관한 계약을 이행하고 회원의 편의 증진 등을 위하여 추가적인 처리 위탁이 필요한 경우에는 고지 및 동의 절차를 거치지 않을 수 있습니다.'),
                Text('1. Firebase : 회원 관리, 운영 시스템 지원'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "5. 수집한 개인정보의 보관 및 파기",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    '이시국앱은 서비스를 제공하는 동안 개인정보 취급방침 및 관련법에 의거하여 회원의 개인정보를 지속적으로 관리 및 보관합니다. 수집된 개인정보는 서비스 종료 시 파기됩니다.'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "6. 정보주체의 권리, 의무 및 행사",
                  style: TextStyle(fontSize: 20),
                ),
                Text('회원은 언제든지 개인정보를 조회할 수 있으며, 문의 메일로 탈퇴를 할 수 있습니다.'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "7. 쿠키",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                    '쿠키란 웹사이트를 운영하는 데 이용되는 서버가 귀하의 브라우저에 보내는 아주 작은 텍스트 파일로서 귀하의 컴퓨터 하드디스크에 저장됩니다. 서비스는 사이트 로그인을 위해 아이디 식별에 쿠키를 사용할 수 있습니다.'),
                Text('쿠키 설정 거부 방법 예시'),
                Text(
                    '1. Internet Explorer : 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보 > 설정'),
                Text(
                    '2. Chrome : 웹 브라우저 상단의 도구 > 고급 설정 표시 > 개인정보의 콘텐츠 설정 버튼 > 쿠키'),
                SizedBox(
                  height: 3,
                ),
                Text(
                  "8. 기타",
                  style: TextStyle(fontSize: 20),
                ),
                Text('이 약관은 2020년 12월 18일에 최신화 되었습니다.'),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
