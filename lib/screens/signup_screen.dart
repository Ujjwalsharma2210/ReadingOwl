import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/data_structures/user.dart' as User;
import 'package:reading_owl/res/custom_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reading_owl/res/multi_select.dart';
import 'package:email_validator/email_validator.dart';

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
    // final json = {
    //   'username': usernameController.text.trim(),
    //   'email': emailController.text.trim(),
    //   'isVerifiedWriter': false,
    //   'interests': selectedItems,
    //   'yourBlogs': [],
    // };
    final user = User.User(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        interests: selectedItems);
    final json = user.toJson();

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
              TextInputField(context, usernameController, 'Enter Username'),
              SizedBox(
                height: separation,
              ),
              TextInputField(context, emailController, 'Enter Email'),
              SizedBox(
                height: separation,
              ),
              TextInputField(context, passwordController, 'Enter password'),
              SizedBox(
                height: separation,
              ),
              // TextInputField(
              //     context, confirmPasswordController, 'Confirm password'),
              // const SizedBox(
              //   height: 10,
              // ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    onPress: showMultiSelect,
                    label: "Select interests",
                  ),
                  SizedBox(width: separation),
                  CustomButton(
                    onPress: verifyCredentials,
                    label: "Signup",
                  ),
                ],
              ),
              SizedBox(
                height: separation,
              ),
              Wrap(
                children: selectedItems
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
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

              // BasicButton(buttonHandler: signup, buttonTitle: 'Signup'),
            ],
          ),
        ),
      ),
    );
  }

  void verifyCredentials() {
    if (usernameController.text.trim() == '' ||
        emailController.text.trim() == '' ||
        passwordController.text.trim() == '' ||
        // confirmPasswordController.text.trim() == '' ||
        selectedItems.isEmpty) {
      showToast(context, '''Field(s) can't be empty''', 'alert');
      // return;
      // } else if (passwordController.text.trim() !=
      //     confirmPasswordController.text.toString()) {
      //   showToast(context, '''passwords don't match''', 'alert');
      //   return;
    } else if (passwordController.text.trim().length < 6) {
      showToast(context, 'password too short', 'alert');
      // return;
    } else if (!EmailValidator.validate(emailController.text)) {
      showToast(context, "Invalid email", 'alert');
      // return;
    } else {
      signup();
    }
  }
}
