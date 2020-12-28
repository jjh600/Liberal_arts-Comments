setDate(DateTime dtt) {
  String date, month, day, hour, minute;
  DateTime dt = dtt;
  DateTime dtn = DateTime.now();

  if (dt.month.toString().length == 1)
    month = '0' + dt.month.toString();
  else
    month = dt.month.toString();

  if (dt.day.toString().length == 1)
    day = '0' + dt.day.toString();
  else
    day = dt.day.toString();

  if (dt.hour.toString().length == 1)
    hour = '0' + dt.hour.toString();
  else
    hour = dt.hour.toString();

  if (dt.minute.toString().length == 1)
    minute = '0' + dt.minute.toString();
  else
    minute = dt.minute.toString();

  if (dtn.year > dt.year) {
    date = dt.year.toString() + '/' + month + '/' + day;
  } else if (dtn.difference(dt).inHours < 24) {
    date = hour + ':' + minute;
    if ((dtn.day > dt.day && dtn.month == dt.month) ||
        (dtn.day < dt.day && dtn.month != dt.month)) date = month + '/' + day;
    if (dtn.difference(dt).inHours == 0) {
      date = dtn.difference(dt).inMinutes.toString() + '분 전';
    }
  } else {
    date = month + '/' + day;
  }

  return date;
}
