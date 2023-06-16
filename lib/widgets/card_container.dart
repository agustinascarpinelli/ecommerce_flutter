import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _decoration(),
        child: child,
      ),
    );
  }

  BoxDecoration _decoration() => BoxDecoration(
    color:Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 15,
        //La posicion (0,0) es exactamente donde se encuentra el elemento(en el medio), si vamos jugando con estos valores vamos moviendo la sombra.
        offset:Offset(0,5)
      )

    ]
  );
}