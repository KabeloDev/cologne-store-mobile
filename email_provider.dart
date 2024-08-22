import 'package:flutter/material.dart';

class EmailProvider extends ChangeNotifier {
  String email = "";

  void getUserEmail (String currentUserEmail){
    email = currentUserEmail;
    notifyListeners();
  }

  String get userEmail => email;
}