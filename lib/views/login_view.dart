import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notelist/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: emailController,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  ),
                  TextButton(
                    onPressed: () async { 
                      final email = emailController.text;
                      final password = passwordController.text;
                      try {
                        final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                        print(credentials);
                      } on FirebaseAuthException catch (e) {
                        print('Authentication Error');
                        if(e.code == 'user-not-found') {
                          print('User not found');
                        } else {
                          print(e.message);
                        }
                        }
                      },
                    child: const Text('Login'),
                  ),
                ],
              );
            default:
              return const Text('Loading...');
          }
        }
      ),
    );
  }
}