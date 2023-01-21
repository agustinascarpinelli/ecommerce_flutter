import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
final Widget child;


  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child:Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const _ColorBox(),
          const _Logo(),
          child

        ],
      )



    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top:30),
        child: Icon(Icons.person_pin,color:Colors.white,size: 100,),
      ),
    );
  }
}


class _ColorBox extends StatelessWidget {
  const _ColorBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height:size.height *0.4 ,
        decoration: _gradient(),
        child:Stack(children: [
           Positioned(child: _Bubble(),top: 90,left: 30,),
           Positioned(child: _Bubble(),top: 50,right: -50,),
           Positioned(child: _Bubble(),top: -50,left: -30,),
           Positioned(child: _Bubble(),bottom: -50,left: 30,),
           Positioned(child: _Bubble(),bottom: 110,right: 30,)
        ],)

    );
  }

  BoxDecoration _gradient() => BoxDecoration(
   gradient: LinearGradient(colors: [
    Color.fromRGBO(63, 63, 156, 1),
     Color.fromRGBO(90, 70, 178, 1)
   ])


  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:Color.fromRGBO(255, 255, 255, 0.05)
      ),


    );
  }
}