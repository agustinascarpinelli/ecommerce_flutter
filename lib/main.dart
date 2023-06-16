import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      //lazy:true por defecto. No se dispara hasta no ser llamado.De otra manera se dispara cuando se crea
      ChangeNotifierProvider(create: (_) => ProductsService()),
      ChangeNotifierProvider(create: (_) => AuthService())
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'checkAuth': (_) => const CheckAuthScreen(),
          'login': (_) => const LoginScreen(),
          'register': (_) => const RegisterScreen(),
          'home': (_) => const HomeScreen(),
          'product': (_) => const ProductScreen(),
        },
        //no se necesita instanciar por que es una propiedad estatica (NotificationsService.messengerKey)
        scaffoldMessengerKey: NotificationsService.messengerKey,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          textTheme: GoogleFonts.nunitoSansTextTheme( const TextTheme() ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.deepPurple,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple, elevation: 0),
        ));
  }
}
