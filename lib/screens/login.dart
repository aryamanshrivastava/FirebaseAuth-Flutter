// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/main.dart';
import 'package:flutter_firebase/screens/utils.dart';

import 'forgotpass.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              cursorColor: Colors.black,
              cursorHeight: 18,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  hintText: 'Email Id',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(fontSize: 18, color: Colors.black38)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextFormField(
              cursorColor: Colors.black,
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(fontSize: 18, color: Color(0xffC9C9C9))),
              obscureText: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  )),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            ElevatedButton(
                onPressed: signIn,
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
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24),
                )),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    text: 'No account? ',
                    children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  )
                ])),
          ]),
        ),
      );
  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => Center(child: CircularProgressIndicator())));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
