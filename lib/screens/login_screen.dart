import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reading_owl/res/custom_widgets.dart';

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
  Future signup() async {
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
                height: height * 0.08,
              ),
              TitleText(context, 'Welcome to Reading Owl'),
              Center(
                child: Text(
                  'Things for you to read at night.',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              OwlImage(context),
              const SizedBox(
                height: 30,
              ),
              TextInputField(context, emailController, 'Enter email'),
              const SizedBox(
                height: 10,
              ),
              TextInputField(context, passwordController, 'Enter password'),
              const SizedBox(
                height: 10,
              ),
              // BasicButton(buttonHandler: signup, buttonTitle: 'Signup'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: signup,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
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
              SizedBox(
                height: 70,
              ),
              Text(
                '* We are still developing and testing this app. \nPlease consider helping us improve the application by reporting errors.',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
