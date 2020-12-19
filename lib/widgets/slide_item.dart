import 'package:flutter/material.dart';

class SlideItem extends StatefulWidget {
  final String title;
  final String content;
  final DateTime date;
  final String type;

  SlideItem({
    Key key,
    @required this.title,
    @required this.content,
    @required this.date,
    @required this.type,
  }) : super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  String image ='';

  @override
  Widget build(BuildContext context) {
    if (widget.type == '이벤트'){
      image = 'event';
    } else if (widget.type == '업데이트'){
      image = 'update';
    } else {
      image = 'calendar';
    }

    return Padding(
      padding: EdgeInsets.only(top: 7.0, bottom: 3.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/${image}.png', width: 60),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Text(
                    "${widget.content}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),

      ),
    );
  }
}
