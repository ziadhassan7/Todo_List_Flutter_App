import 'package:flutter/material.dart';

class PickDateProvider extends ChangeNotifier{
  int pickedDay = 0;
  int pickedMonth = 0;
  int pickedYear = 0;

  //String pickDateTextButton = "Pick Date";

  void changeDateButton(int day, int month, int year){


    pickedDay = day;
    pickedMonth = month;
    pickedYear = year;

    /*pickedDay != 0
        ? pickDateTextButton = "$pickedDay/$pickedMonth/$pickedYear"
        : pickDateTextButton = "Pick Date";*/

    print ("-----provider should change values:     $pickedDay/$pickedMonth/$pickedYear");


    notifyListeners();

  }

}