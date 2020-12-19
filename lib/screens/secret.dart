import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SecretScreen extends StatefulWidget {
  @override
  _SecretScreenState createState() => _SecretScreenState();
}

class _SecretScreenState extends State<SecretScreen> {
  @override
  Widget build(BuildContext context) {
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
                      fit: BoxFit.fitHeight),
                  onTap: () {
                    Navigator.pop(context);
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "초기화",
                      style: TextStyle(
                          color: Color(0xff324685),
                          fontSize: 25,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ],
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.red,
            ),
            iconSize: 100,
            onPressed: () {
              var avg_assignment;
              var avg_communication;
              var avg_cost;
              var avg_rating;
              var count;
              List<int> expenditureCount;
              var tag1_count;
              var tag2_count;
              var tag3_count;
              var tag4_count;
              var tag5_count;
              var tag6_count;

              FirebaseFirestore.instance
                  .collection('elective')
                  .get()
                  .then((value) => {
                        value.docs.forEach((element) {
                          FirebaseFirestore.instance
                              .collection('elective')
                              .doc(element['lecture'] + element['professor'])
                              .collection('information')
                              .get()
                              .then((value) {
                            // 각 과목마다 반복
                            avg_assignment = 0;
                            avg_communication = 0;
                            avg_cost = 0;
                            avg_rating = 0;
                            count = 0;
                            expenditureCount = [0, 0, 0];
                            tag1_count = 0;
                            tag2_count = 0;
                            tag3_count = 0;
                            tag4_count = 0;
                            tag5_count = 0;
                            tag6_count = 0;

                            value.docs.forEach((element2) {
                              // 각 과목의 후기마다 반복
                              count += 1;
                              if (element2['tag1']) tag1_count += 1;
                              if (element2['tag2']) tag2_count += 1;
                              if (element2['tag3']) tag3_count += 1;
                              if (element2['tag4']) tag4_count += 1;
                              if (element2['tag5']) tag5_count += 1;
                              if (element2['tag6']) tag6_count += 1;
                              if (element2['expenditure'][0])
                                expenditureCount[0] += 1;
                              if (element2['expenditure'][1])
                                expenditureCount[1] += 1;
                              if (element2['expenditure'][2])
                                expenditureCount[2] += 1;

                              avg_assignment = (avg_assignment * (count - 1) +
                                      element2['assignment']) /
                                  count;

                              avg_communication =
                                  (avg_communication * (count - 1) +
                                          element2['communication']) /
                                      count;
                              avg_cost =
                                  (avg_cost * (count - 1) + element2['cost']) /
                                      count;
                              avg_rating = (avg_rating * (count - 1) +
                                      element2['rating']) /
                                  count;
                            });
                          }).whenComplete(() => {
                                    FirebaseFirestore.instance
                                        .collection('elective')
                                        .doc(element['lecture'] +
                                            element['professor'])
                                        .update({
                                      'avg_rating': avg_rating,
                                      'tag1_count': tag1_count,
                                      'tag2_count': tag2_count,
                                      'tag3_count': tag3_count,
                                      'tag4_count': tag4_count,
                                      'tag5_count': tag5_count,
                                      'tag6_count': tag6_count,
                                      'expenditureCount': expenditureCount,
                                      'avg_cost': avg_cost,
                                      'avg_assignment': avg_assignment,
                                      'avg_communication': avg_communication,
                                      'count': count
                                    }),
                                    print(element['lecture'] +
                                        element['professor'] +
                                        ' 업데이트 완료')
                                  });
                        })
                      });
            },
          ),
        ));
  }
}
