import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/res/custom_widgets.dart';

import '../res/data_structures.dart';

Color black = Colors.black;
Color darkGrey = Colors.grey.shade900;
Color textColor = Colors.grey.shade500;
Color primaryColor = Colors.deepPurple;
Color grey = Colors.grey.shade800;
Color white = Colors.white;

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
  late String selectedGenre;
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

  Future createBlog(Blog blog) async {
    final dbRef = firestoreInstance
        .collection('blogs')
        .doc(firebaseAuthInstance.currentUser!.uid.toString());
    // FirebaseFirestore.instance.collection('unReviewedBlogs').doc(FirebaseAuth.instance.currentUser.toString());

    blog.id = dbRef.id;
    final json = blog.toJson();
    await dbRef.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TitleText(context, 'Publish your story'),
            SizedBox(
              height: 70,
            ),
            TextInputField(context, titleController, 'Enter title'),
            TextInputField(context, contentController, 'Enter content'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: darkGrey,
                ),
                child: DropdownButton(
                  hint: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      selectGenreHint,
                      style: TextStyle(color: textColor, fontSize: fontSize),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ElevatedButton(
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Send for review',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () {
                  final blog = Blog(
                      title: titleController.text,
                      content: contentController.text,
                      author: username,
                      genre: selectedGenre);
                  createBlog(blog);
                  titleController.clear;
                  contentController.clear;

                  showToast(
                      context, 'Sent for review suuccessfully.', 'success');
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
