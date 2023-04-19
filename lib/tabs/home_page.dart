import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../res/blog_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    Stream<List<Blog>> readBlogs() => FirebaseFirestore.instance
        .collection('blogs')
        .orderBy('score', descending: true) // Sort blogs by score
        .limit(15)
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

          // If a blog becomes visible and inivisible and is not
          // clicked => reduce score by n
          return ListView(
            // children: blogs!.map(BlogWidget).toList(),
            children: blogs!
                .map((blog) => BlogWidget(
                      blog: blog,
                    ))
                .toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
