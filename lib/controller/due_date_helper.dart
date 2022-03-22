class DueDateHelper {

  // Singleton to avoid re-initializing
  //static final DueDateHelper instance = DueDateHelper();
  //no need because I made them static



  ///                                                                           /Get Due Date
  static String getDueDate(int year, int month, int day){
    //get current dates
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;


    //if there is no picked date
    if (day == 0){
      return "   ";
    } // else check for the rest of the conditions


    //if year and month are the same check for how much days left
    if (year == currentYear && month == currentMonth){

      int remainingDays = (day - currentDay); //count remaining days

      //if we are on the same day
      if(day == currentDay){
        return "   due today";
      }

      //if not on the same day but it is less than 3 days left
      if (remainingDays < 3 && !remainingDays.isNegative) {
        return "   due in $remainingDays";
      }

    } // else print full date


    return "   due in $day/$month/$year";
  }
}