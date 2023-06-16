import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> loginKey=GlobalKey<FormState>();
  

  String email ='';
  String password='';
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  set isLoading(bool value){
    _isLoading=value;
    notifyListeners();
  }

  bool isValidForm(){
   
   
    return loginKey.currentState?.validate()?? false;
  }



}