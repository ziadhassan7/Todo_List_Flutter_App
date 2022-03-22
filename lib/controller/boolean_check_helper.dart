class BooleanCheckHelper {

  // Singleton to avoid re-initializing
  //static final BooleanCheckHelper instance = BooleanCheckHelper();
  //no need because I made them static


  ///                                                                           /Convert boolean to int (0:false , 1:true)
  static int convertBoolToInt(bool isChecked){
    return isChecked ? 1 : 0; //1 for true  ,, 0 for false
  }

  ///                                                                           /Convert int to boolean (0:false , 1:true)
  static bool convertIntToBool(int isChecked){
    return isChecked == 0? false : true; //if 0 ==> return false  ,,  1,.. ==> true
  }
}