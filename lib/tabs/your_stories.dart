import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/res/blog_widget.dart';

import '../data_structures/blog.dart';
import '../res/colors.dart';

class YourStories extends StatefulWidget {
  const YourStories({super.key});

  @override
  State<YourStories> createState() => _YourStoriesState();
}

class _YourStoriesState extends State<YourStories> {
  List<String> usersBlogIds = <String>[];
  late List<Widget> usersBlogsList;
  // List<BlogWidget> blogs = <BlogWidget>[];

  var _firestore = FirebaseFirestore.instance;
  var _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        createUserBlogsList(),
      ],
    );
  }

  @override
  void initState() {
    getBlogs();

    super.initState();
  }

  void getUsersBlogIds() async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      usersBlogIds = List<String>.from(value.data()!['yourBlogs']);
    });
    createUserBlogsList();
  }

  void getBlogs() async {
    usersBlogsList = await fetchUserBlogsList();
    // setState(() {});
  }

  Widget createUserBlogsList() {
    if (usersBlogsList.isEmpty) {
      return Text(
        "You have not written anything yet",
        style: TextStyle(color: textColor, fontSize: 22),
      );
    } else if (usersBlogsList.isNotEmpty) {
      return Column(
        children: usersBlogsList,
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }

    // return ListView.builder(
    //   itemCount: usersBlogsList.length,
    //   itemBuilder: (context, index) {
    //     return BlogWidget(blog: usersBlogsList[index]);
    //   },
    // );
  }

  List<Widget> fetchUserBlogsList() {
    List<Widget> usersBlogsList = <Widget>[];
    Map<String, dynamic>? data;
    for (String blogId in usersBlogIds) {
      var userBlogDoc = _firestore.collection('blogs').doc(blogId);
      userBlogDoc.get().then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.exists) {
          data = snapshot.data();
          Blog usersBlog = Blog(
              id: data!['id'],
              title: data!['title'],
              content: data!['content'],
              author: data!['author'],
              genre: data!['genre'],
              isVerified: data!['isVerified'],
              reads: data!['reads'],
              score: data!['score']);
          usersBlogsList.add(BlogWidget(blog: usersBlog));
          print(data!['title']);
          // setState(() {});
        }
      }).catchError((error) {
        print("can't get user blogs");
      });
    }

    return usersBlogsList;
  }
}
