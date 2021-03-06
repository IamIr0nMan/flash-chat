import 'package:flashchat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = '/register';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            clicked
                ? getProgressCircle()
                : RoundedButton(
                    onClick: () async {
                      setState(() {
                        clicked = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushReplacementNamed(
                              context, ChatScreen.id);
                        }
                      } catch (e) {
                        print(e);
                        await Future.delayed(const Duration(seconds: 2));
                        setState(() {
                          clicked = false;
                        });
                      }
                    },
                    buttonColor: Colors.blueAccent,
                    buttonTitle: 'Register',
                  ),
          ],
        ),
      ),
    );
  }
}
