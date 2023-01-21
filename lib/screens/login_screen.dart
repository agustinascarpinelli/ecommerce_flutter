import 'package:ecommerce_app/providers/login_form_provider.dart';
import 'package:ecommerce_app/ui/input_decorations.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(height: 15),
              Text('Login', style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 30),
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const _Form(),
              )
            ],
          )),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'register');
            },
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    Colors.deepPurple.withOpacity(0.1)),
                shape: MaterialStateProperty.all(const StadiumBorder())),
            child: const Text('Sign in',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ),
          const SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          key: loginForm.loginKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                //Para que aparezca el @ en el teclado
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.loginInputDecoration(
                    hintText: 'john@email.com',
                    labelText: 'Email',
                    prefixIcon: Icons.alternate_email_sharp),
                onChanged: (value) => loginForm.email=value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                  RegExp regExp = RegExp(pattern);
                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Please enter a valid email';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                  autocorrect: false,
                  //type password
                  obscureText: true,
                  //Para que aparezca el @ en el teclado
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.loginInputDecoration(
                      hintText: '*********',
                      labelText: 'Password',
                      prefixIcon: Icons.key_outlined),
                  onChanged: (value) => loginForm.password=value,
                  validator: (value) {
                    if (value != null && value.length >= 6) return null;
                    return 'Password must be six or more characters';
                  }),
              const SizedBox(height: 30),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                // ignore: sort_child_properties_last
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(loginForm.isLoading ? 'Loading' : 'Sign up',
                      style: const TextStyle(color: Colors.white)),
                ), //
                //Se deshabilita el boton mientras esta cargando.
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        //Quita el teclado al apretar el boton
                        FocusScope.of(context).unfocus();
                        //listen en false=>no se puede escuchar dentro de un metodo, solo dentro del build.
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;

                        final String? error = await authService.loginUser(
                            loginForm.email, loginForm.password);
                        if (error == null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          NotificationsService.showSnackBar(error);
                          loginForm.isLoading = false;
                        }
                      },
              )
            ],
          )),
    );
  }
}
