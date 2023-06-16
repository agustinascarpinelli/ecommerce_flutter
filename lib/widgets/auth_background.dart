import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
final Widget child;


  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        margin: const EdgeInsets.only(top:30),
        child: const Icon(Icons.person_pin,color:Colors.white,size: 100,),
      ),
    );
  }
}


class _ColorBox extends StatelessWidget {
  const _ColorBox();

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        height:size.height *0.4 ,
        decoration: _gradient(),
        child:const Stack(children: [
           Positioned(top: 90,left: 30,child: _Bubble(),),
           Positioned(top: 50,right: -50,child: _Bubble(),),
           Positioned(top: -50,left: -30,child: _Bubble(),),
           Positioned(bottom: -50,left: 30,child: _Bubble(),),
           Positioned(bottom: 110,right: 30,child: _Bubble(),)
        ],)

    );
  }

  BoxDecoration _gradient() => const BoxDecoration(
   gradient: LinearGradient(colors: [
    Color.fromRGBO(63, 63, 156, 1),
     Color.fromRGBO(90, 70, 178, 1)
   ])


  );
}

class _Bubble extends StatelessWidget {
  const _Bubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:const Color.fromRGBO(255, 255, 255, 0.05)
      ),


    );
  }
}