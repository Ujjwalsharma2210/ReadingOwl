import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reading_owl/res/custom_widgets.dart';

import '../res/constants.dart';

Color darkGrey = Colors.grey.shade900;
Color textColor = Colors.grey.shade500;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const SignupPage({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // TextEditingController ConfirmPasswordController = TextEditingController();
  Future login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      // backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(context, 'Reading Owl'),
                    OwlImage(context),
                  ],
                ),
              ),

              const SizedBox(
                height: 150,
              ),
              TextInputField(context, emailController, 'Enter email'),
              SizedBox(
                height: separation,
              ),
              TextInputField(context, passwordController, 'Enter password'),
              SizedBox(
                height: separation,
              ),
              // BasicButton(buttonHandler: signup, buttonTitle: 'Signup'),
              Row(
                children: [
                  CustomButton(onPress: login, label: "Login"),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: ElevatedButton(
              //     onPressed: login,
              //     child: const Text(
              //       'Login',
              //       style: TextStyle(
              //         fontSize: 16,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SignupScreen');
                    },
                    child: const Text('Signup Now'),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 70,
              // ),
              // Text(
              //   '* We are still developing and testing this app. \nPlease consider helping us improve the application by reporting errors.',
              //   style: TextStyle(
              //     color: textColor,
              //     fontSize: 16,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
