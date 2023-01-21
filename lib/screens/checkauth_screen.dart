import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading');
          }
          if (snapshot.data == '') {
//Microtask es la ejecucion que se va a ejecutar tan pontro el builder termine.El builder debe regresar unwidget (no puedo usar directamente el Navigator...)
            Future.microtask(() {
              //Este navigator.pushReplacement elimina la transicion entre las pantallas(no se llega a ver esta)
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0)));
            });
          } else {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionDuration: const Duration(seconds: 0)));
            });
          }
          //widget que retorna el builder. Si le pongo solo el navigator sin el microtask no llega a crear el widget y tira error
          return Container();
        },
      )),
    );
  }
}
