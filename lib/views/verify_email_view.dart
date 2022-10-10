import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Column(
          children: [
            TextButton(
              onPressed: () async {  
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              }, 
              child: const Text('Send e-mail verification'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (_) => false
                );
              },
              child: const Text('Done? Return to login'),
            ),
          ],
      ),
    );
  }
}