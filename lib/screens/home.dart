// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'verify_email.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Something went Wrong!'));
              } else if (snapshot.hasData) {
                return VerifyEmailPage();
              } else {
                return AuthPage();
              }
            }),
      );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Signed In as',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
              Text(
                user.email!,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500, color: Colors.yellow),
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
              ElevatedButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                    primary: Color(0xff9B4BFF),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.08,
                        vertical: MediaQuery.of(context).size.height * 0.013),
                  ),
                  child: Text('Sign Out', style: TextStyle(fontSize: 24)))
            ],
          ),
        ],
      ),
    );
  }
}
