import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Calculator{
 //dateRime to String
  static String? dateTimeToString(DateTime? datetime){
    String? formattedDate = datetime == null ? null : DateFormat('dd-MM-yyyy').format(datetime);
    return formattedDate;
  }

  // dateTime to TimeStamp
  static Timestamp dateTimeToTimestamp (DateTime? datetime){
    Timestamp? timestamp = Timestamp?.fromDate(datetime!);
    Timestamp? timestampMiliSeconds = Timestamp.fromMillisecondsSinceEpoch(datetime.millisecondsSinceEpoch);
    return timestampMiliSeconds;
  }
//dasdasd
//timeStamp to DateTime
  static DateTime dateTimeFromTimeStamp (Timestamp timestamp){
      
    return DateTime.fromMillisecondsSinceEpoch(timestamp.seconds*1000);
  }

}