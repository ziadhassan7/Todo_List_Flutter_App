import 'package:flutter/material.dart';

class RefreshItemsProvider extends ChangeNotifier{

  void refreshListItems(){
    notifyListeners();
  }


}