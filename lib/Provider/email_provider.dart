import 'package:flutter/material.dart';

class EmailProvider extends ChangeNotifier {
  String email = "";

  void getUserEmail(String currentUserEmail) {
    email = currentUserEmail;
    notifyListeners();
  }

  String get userEmail => email;

  ////////
 
  String firstName = "";

  void getUserFirstName (String currentFirstName){
    firstName = currentFirstName;
    notifyListeners();
  }

  String get userFirstName => firstName;

  ////////
 
  String lastName = "";

  void getUserLastName (String currentLastName){
    lastName = currentLastName;
    notifyListeners();
  }

  String get userLastName => lastName;

  ////////
 
  String address = "";

  void getUserAddress (String currentUserAddress){
    address = currentUserAddress;
    notifyListeners();
  }

  String get userAddress => address;

  ////////
 
  String cardNumber = "";

  void getUserCardNumber (String currentUserCardNumber){
    cardNumber = currentUserCardNumber;
    notifyListeners();
  }

  String get userCardNumber => cardNumber;

  ////////
 
  String expirationDate = "";

  void getUserExpirationDate (String currentUserExpirationDate){
    expirationDate = currentUserExpirationDate;
    notifyListeners();
  }

  String get userExpirationDate => expirationDate;

  ////////
 
  String cvv = "";

  void getUserCvv (String currentUserCvv){
    cvv = currentUserCvv;
    notifyListeners();
  }

  String get userCvv => cvv;
}
