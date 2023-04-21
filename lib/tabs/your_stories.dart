import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data_structures/blog.dart';
import '../res/colors.dart';

class YourStories extends StatefulWidget {
  const YourStories({super.key});

  @override
  State<YourStories> createState() => _YourStoriesState();
}

class _YourStoriesState extends State<YourStories> {
  List<String> usersBlogIds = <String>[];

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
              // children: blogs!
              //     .map((blog) => BlogWidget(
              //           blog: blog,
              //         ))
              //     .toList(),
              );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsersBlogIds();
  }

  void getUsersBlogIds() async {
    // usersBlogIds = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid.toString())
    //     .get()
    //     .then((value) {
    //   setState(() {
    //     List.from(value.data['yourBlogs']).forEach((element) {
    //       usersBlogIds.add(element);
    //     });
    //   });
    // });
  }
}
