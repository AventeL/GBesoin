import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gbesoin/main.dart';
import 'package:gbesoin/providers/auth_firebase.dart';
import 'package:gbesoin/screens/choicescreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    Color mainColor = const Color(0xff8D0008);
    return FlutterLogin(
      logo: const AssetImage('assets/logo.png'),
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
          logoWidth: 100,
          primaryColor: const Color(0xff18181B),
          accentColor: mainColor,
          errorColor: Colors.red,
          buttonStyle: const TextStyle(color: Colors.white),
          inputTheme: InputDecorationTheme(
              iconColor: mainColor,
              focusColor: Colors.red,
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: mainColor,
                  )),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Colors.red,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: mainColor,
                  ))),
          buttonTheme: LoginButtonTheme(backgroundColor: mainColor)),
    );
  }
}
