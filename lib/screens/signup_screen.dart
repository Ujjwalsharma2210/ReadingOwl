import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/res/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reading_owl/res/multi_select.dart';

import '../res/constants.dart';

Color textColor = Colors.grey.shade500;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // const SignupPage({Key? key}) : super(key: key);
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  List<String> selectedItems = [];

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future createUser() async {
    final dbRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString());
    final json = {
      'username': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'isVerifiedWriter': false,
      'interests': selectedItems,
      'yourBlogs': [],
    };

    await dbRef.set(json);
  }

  // TextEditingController ConfirmPasswordController = TextEditingController();
  Future signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      createUser();
      Navigator.pushNamed(context, '/HomeScreen');
    } on FirebaseAuthException catch (e) {
      showToast(context, e.message.toString(), 'error');
    }
  }

  void showMultiSelect() async {
    final List<String>? results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(listItems: listItems);
        });

    if (results != null) {
      setState(() {
        selectedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: linearGradient(context),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              TitleText(context, 'Welcome to Reading Owl'),
              const SizedBox(
                height: 30,
              ),
              OwlImage(context),
              const SizedBox(
                height: 30,
              ),
              TextInputField(context, usernameController, 'Enter Username'),
              const SizedBox(
                height: 10,
              ),
              TextInputField(context, emailController, 'Enter Email'),
              const SizedBox(
                height: 10,
              ),
              TextInputField(context, passwordController, 'Enter password'),
              const SizedBox(
                height: 10,
              ),
              TextInputField(
                  context, confirmPasswordController, 'Confirm password'),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: showMultiSelect,
                  child: Text(
                    'Select your interests',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
              Wrap(
                children: selectedItems
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            backgroundColor: Colors.grey.shade900,
                            label: Text(
                              e,
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              // BasicButton(buttonHandler: signup, buttonTitle: 'Signup'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: verifyCredentials,
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyCredentials() {
    if (confirmPasswordController.text.trim() == '' ||
        emailController.text.trim() == '' ||
        passwordController.text.trim() == '' ||
        confirmPasswordController.text.trim() == '' ||
        selectedItems.isEmpty) {
      showToast(context, '''Field(s) can't be empty''', 'alert');
      return;
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.toString()) {
      showToast(context, '''passwords don't match''', 'alert');
      return;
    } else if (passwordController.text.trim().length < 6) {
      showToast(context, 'password too short', 'alert');
      return;
    } else {
      signup();
    }
  }
}
