import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateFormatHelper {
  static String convertDateFromDate(DateTime dateTime, String newFormat) {
    try {
      initializeDateFormatting();
      DateFormat newDateFormat = DateFormat(
        newFormat,
      );
      String selectedDate = newDateFormat.format(dateTime);
      return selectedDate;
    } catch (e) {
      return "NA";
    }
  }

  static DateTime getDateFromString(String date, String format) {
    try {
      initializeDateFormatting();

      DateTime dateTime = DateFormat(format).parse(date);
      return dateTime;
    } catch (e) {
      return DateTime.now();
    }
  }

  static String convertDateFromString(
      String dateTimeString, String oldFormat, String newFormat) {
    try {
      initializeDateFormatting();

      DateFormat newDateFormat = DateFormat(
        newFormat,
      );
      DateTime dateTime = DateFormat(oldFormat).parse(dateTimeString);
      String selectedDate = newDateFormat.format(dateTime);
      return selectedDate;
    } catch (e) {
      return "NA";
    }
  }

  /*static String getAgeBetween(FormDetailModel formDetailModel) {
    try {
      initializeDateFormatting();
      DateFormat newDateFormat = DateFormat(
        "dd MMM, yyyy",
      );
      DateTime dateTime =
          DateFormat("dd-MM-yyyy").parse(formDetailModel.applicationBegin!);
      DateTime minimumDate = DateTime(
          dateTime.year - formDetailModel.minimumAge!.floor(),
          dateTime.month,
          dateTime.day);
      DateTime maximumDate = DateTime(
          dateTime.year - formDetailModel.maximumAge!.floor(),
          dateTime.month,
          dateTime.day);
      */ /*String minimumDecimalValue = ((formDetailModel.minimumAge! * 10).floor())
          .toString()
          .substring(
          ((formDetailModel.minimumAge! * 10).floor()).toString().length -
              1);
      String maximumDecimalValue = ((formDetailModel.maximumAge! * 10).floor())
          .toString()
          .substring(
          ((formDetailModel.maximumAge! * 10).floor()).toString().length -
              1);*/ /*

      String minimumDateStr = newDateFormat.format(minimumDate);
      String maximumDateStr = newDateFormat.format(maximumDate);
      return "$maximumDateStr to \n$minimumDateStr";
    } catch (e) {
      return "NA";
    }
  }*/
}
