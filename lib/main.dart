import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notelist/constants/routes.dart';
import 'package:notelist/firebase_options.dart';
import 'package:notelist/views/login_view.dart';
import 'package:notelist/views/notes_view.dart';
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
        loginRoute: (context) => const LoginView(),
        registrationRoute:(context) => const RegisterView(),
        emailVerificationRoute:(context) => const VerifyEmailView(),  
        notesRoute: (context) => const NotesView(),
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
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          default:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Loading...'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      }
    );
  }
}