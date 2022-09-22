import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notelist/firebase_options.dart';
import 'package:notelist/views/login_view.dart';
import 'package:notelist/views/register_view.dart';
import 'package:notelist/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), 
      routes: {
        '/login': (context) => const LoginView(),
        '/register':(context) => const RegisterView(),
        '/verification':(context) => const VerifyEmailView(),  
      }
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if(user.emailVerified) {
                return const Text('Congrats');
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      }
    );
  }
}

// Notes

// - Posiblemente se necesite remover el Scaffold de RegisterView