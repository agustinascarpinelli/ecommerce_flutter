import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _productDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: getImg(url)
          ),
        ),
      ),
    );
  }

  BoxDecoration _productDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);

Widget getImg(String?picture){

  if(picture==null){
    return const Image ( 
                    image: AssetImage('assets/no-image.png'),
                    fit: BoxFit.cover);
  }
  if(picture.startsWith('http')){
    return  Image(
                    image: NetworkImage(url!),
                    
                    //Para que se estire lo mas que pueda sin perder las dimensiones
                    fit: BoxFit.cover);
  }

  return Image.file(
    File(picture),
    fit:BoxFit.cover
  );
 
               
}
}
