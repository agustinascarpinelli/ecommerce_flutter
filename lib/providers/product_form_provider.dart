import 'package:ecommerce_app/models/models.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formkey= GlobalKey<FormState>();

  Product product;
  
  
  //Cuando se crea la instancia de la clase, me tienen que mandar un producto

  ProductFormProvider(this.product);


  updateAvailability (bool value){
    product.available=value;
    notifyListeners();
  }

  bool isValidForm(){
    return formkey.currentState?.validate()?? false;
  }



}