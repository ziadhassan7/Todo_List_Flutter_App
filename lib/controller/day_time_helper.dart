class DayTimeHelper {

  // Singleton to avoid re-initializing
  //static final DayTimeHelper instance = DayTimeHelper();
  //no need because I made them static

  ///                                                                           /Get Day number
  static String getDay(){
    return DateTime.now().day.toString();
  }


  ///                                                                           /Get Year number
  static String getYear(){
    return DateTime.now().year.toString();
  }


  ///                                                                           /Get Month name out of its number
  static String getMonth(int monthNumber){

    switch (monthNumber){
      case 1:
        return "JAN";

      case 2:
        return "FEB";

      case 3:
        return "MAR";

      case 4:
        return "APR";

      case 5:
        return "MAY";

      case 6:
        return "JUN";

      case 7:
        return "JUL";

      case 8:
        return "AUG";

      case 9:
        return "SEP";

      case 10:
        return "OCT";

      case 11:
        return "NOV";

      case 12:
        return "DEC";
    }

    return "!!!";
  }


  ///                                                                           /Get Weekday name out of its number
  static String getDayOfWeek(int dayOfWeekNumber){

    switch (dayOfWeekNumber){
      case 1:
        return "Monday";

      case 2:
        return "Tuesday";

      case 3:
        return "Wednesday";

      case 4:
        return "Thursday";

      case 5:
        return "FRIDAY";

      case 6:
        return "SATURDAY";

      case 7:
        return "SUNDAY";
    }

    return "!!!";
  }
}