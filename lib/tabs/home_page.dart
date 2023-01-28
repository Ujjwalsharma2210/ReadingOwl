import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/screens/reading_screen.dart';

import '../res/custom_widgets.dart';
import '../res/data_structures.dart';

import 'package:reading_owl/res/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var firestoreInstance = FirebaseFirestore.instance.collection('blogs');
  var firebaseAuthInstance = FirebaseAuth.instance;
  late int curReads;

  Widget BlogWidget(Blog blog) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
        onTap: () {
          // firestoreInstance
          //     .doc(blog.id.toString())
          //     .update({'reads': curReads + 1});
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadingScreen(blog: blog)));
        },
        child: Container(
          width: width * 0.95,
          // height: height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: darkGrey,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: textColor),
                ),
                Divider(
                  color: textColor,
                ),
                Text(
                  blog.content,
                  style: TextStyle(color: textColor, fontSize: 19),
                  maxLines: 5,
                ),
                const Text(
                  'more',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'By ${blog.author}',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Icon(
                      Icons.remove_red_eye_sharp,
                      color: textColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      blog.reads.toString(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Blog>> readBlogs() => FirebaseFirestore.instance
        .collection('blogs')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => Blog.fromJson(e.data())).toList());

    return StreamBuilder<List<Blog>>(
      stream: readBlogs(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong!',
            style: TextStyle(color: textColor),
          );
        } else if (snapshot.hasData) {
          final blogs = snapshot.data;

          return ListView(
            children: blogs!.map(BlogWidget).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
