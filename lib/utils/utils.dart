import 'package:intl/intl.dart';

class Utils{
  static currencyFormat(int data){
    return NumberFormat.currency(locale: 'vi').format(data);
  }
  static dateTimeFromMillisecond(int data){
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(data));
    return formattedDate;
  }
  static reformatMoneyInput(String data){
    return int.parse(data.replaceAll(",", ""));
  }
}