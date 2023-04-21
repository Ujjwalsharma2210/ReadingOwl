import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/res/constants.dart';
import 'package:reading_owl/res/custom_widgets.dart';

import '../data_structures/blog.dart';
import '../res/colors.dart';

class StartWritingScreen extends StatefulWidget {
  const StartWritingScreen({super.key});

  @override
  State<StartWritingScreen> createState() => _StartWritingScreenState();
}

class _StartWritingScreenState extends State<StartWritingScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  late String username;
  String selectedGenre = '';
  // late var dbref;
  String selectGenreHint = 'Select genre';

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  Future getUsername() async {
    final dbRef = firestoreInstance
        .collection('users')
        .doc(firebaseAuthInstance.currentUser!.uid);
    dbRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        username = data['username'];
      },
      onError: (e) => showToast(context, 'Cant get username', 'error'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TitleText(context, 'Publish your story'),
            const SizedBox(
              height: 100,
            ),
            TextInputField(context, titleController, 'Enter title'),
            SizedBox(
              height: separation,
            ),
            TextInputField(context, contentController, 'Enter content'),
            SizedBox(
              height: separation,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: darkGrey,
              ),
              child: DropdownButton(
                hint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    selectGenreHint,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                dropdownColor: darkGrey,
                icon: const Icon(Icons.keyboard_arrow_down),
                underline: const SizedBox(),
                items: listItems.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGenre = newValue!;
                    selectGenreHint = newValue;
                  });
                },
              ),
            ),
            SizedBox(
              height: separation,
            ),
            CustomButton(onPress: sendForReview, label: "Send for review"),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   child: ElevatedButton(
            //     child: const Padding(
            //       padding: EdgeInsets.all(10.0),
            //       child: Text(
            //         'Send for review',
            //         style: TextStyle(
            //           fontSize: 16,
            //         ),
            //       ),
            //     ),
            //     onPressed: () {
            //       // createBlog(blog);
            //       sendForReview();
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void sendForReview() {
    try {
      verifyBlog();
      titleController.clear;
      contentController.clear;
      showToast(context, 'Sent for review successfully.', 'success');
      Navigator.pop(context);
    } catch (e) {
      showToast(context, 'Something went wrong.', 'alert');
    }
  }

  void verifyBlog() {
    final dbRef = firestoreInstance.collection('blogs').doc();
    final blog = Blog(
      id: dbRef.id,
      title: titleController.text,
      content: contentController.text,
      author: username,
      genre: selectedGenre,
      isVerified: false,
    );
    if (titleController.text.trim().isEmpty ||
        contentController.text.trim().isEmpty ||
        selectedGenre.trim().isEmpty) {
      showToast(context, '''Feild(s) can't be empty''', 'alert');
      return;
    } else {
      createBlog(blog, dbRef);
      addBlogToUser(blog, dbRef);
      return;
    }
  }

  Future createBlog(Blog blog, var dbRef) async {
    // FirebaseFirestore.instance.collection('unReviewedBlogs').doc(FirebaseAuth.instance.currentUser.toString());

    final json = blog.toJson();
    await dbRef.set(json).onError(
        (error, stackTrace) => showToast(context, error.toString(), 'error'));
  }

  Future addBlogToUser(Blog blog, var dbRef) async {
    // final json = blog.toJson();

    // await firestoreInstance
    //     .collection('users')
    //     .doc(firebaseAuthInstance.currentUser!.uid)
    //     .update({
    //   'yourBlogs': FieldValue.arrayUnion([json])
    // });

    await firestoreInstance
        .collection('users')
        .doc(firebaseAuthInstance.currentUser!.uid)
        .update({
      'yourBlogs': FieldValue.arrayUnion([dbRef.id])
    });
  }
}
