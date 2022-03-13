import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gbesoin/providers/auth_firebase.dart';
import 'package:gbesoin/screens/choicescreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: null,
      messages: LoginMessages(
        userHint: "Email",
        passwordHint: "Mot de passe",
        goBackButton: "Retour",
        loginButton: "Connexion".toUpperCase(),
        signupButton: "S'inscrire".toUpperCase(),
        forgotPasswordButton: "Mot de passe oublié ?",
        confirmPasswordHint: "Confirmer le mot de passe",
        recoverPasswordButton: "Envoyer",
        recoverPasswordDescription:
            "Vous allez recevoir un mail pour réinitialiser votre mot de passe",
        recoverPasswordIntro: "",
      ),
      onLogin: AuthenticationHelper().signIn,
      onSignup: AuthenticationHelper().signUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const ChoiceScreen(
                  isFirstTime: true,
                )));
      },
      onRecoverPassword: AuthenticationHelper().recoverPassword,
      theme: LoginTheme(
          logoWidth: 1,
          primaryColor: const Color(0xff262129),
          accentColor: Colors.green,
          inputTheme: const InputDecorationTheme(
              iconColor: Colors.green,
              focusColor: Colors.red,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.red,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.green,
                  ))),
          buttonTheme: const LoginButtonTheme(backgroundColor: Colors.green)),
    );
  }
}
