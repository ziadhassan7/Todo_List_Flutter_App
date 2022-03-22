import 'package:flutter/material.dart';

class ColorPickerHandler {

  static List<Color> colorList = [Colors.deepPurpleAccent, Colors.deepOrange, Colors.lightGreen, Colors.blueAccent];

  static Color getColorByIndex(int index){
    //0=> blue, 1=> red, 2=> green

    return colorList[index];
  }
}