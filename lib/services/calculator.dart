import 'package:intl/intl.dart';

class Calculator{

  static String? dateTimeToString(DateTime? datetime){
    String? formattedDate = datetime == null ? null : DateFormat('dd-MM-yyyy').format(datetime);
    return formattedDate;
  }


}