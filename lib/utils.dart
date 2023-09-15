import 'package:flutter/material.dart';
class Utils{
  static final messengerkey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBarError(String? text)
  {
    if (text==null)
      return;
    final snackBar = SnackBar(content: Text(text),backgroundColor: Colors.red,) ;

    messengerkey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
  }
  static showSnackBarSuccess(String? text)
  {
    if (text==null)
      return;
    final snackBar = SnackBar(content: Text(text),backgroundColor: Colors.green,) ;

    messengerkey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
  }


}