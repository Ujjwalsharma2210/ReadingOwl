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
  List<Blog> usersBlogsList = <Blog>[];
  // List<BlogWidget> blogs = <BlogWidget>[];

  var _firestore = FirebaseFirestore.instance;
  var _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          "Your Blogs",
          style: TextStyle(
            color: textColor,
            fontSize: 22,
          ),
        ),
        createUserBlogsList(),
      ],
    );
  }

  @override
  void initState() {
    getUsersBlogIds();

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
    getBlogs();
  }

  void getBlogs() async {
    usersBlogsList = await fetchUserBlogsList();
  }

  Widget createUserBlogsList() {
    List<Widget> listOfBlogWidget = <Widget>[];
    for (var blog in usersBlogsList) {
      listOfBlogWidget.add(BlogWidget(blog: blog));
    }
    setState(() {});
    return Column(
      children: listOfBlogWidget,
    );
  }

  Future<List<Blog>> fetchUserBlogsList() async {
    // List<Widget> usersBlogsList = <Widget>[];
    final List<Blog> blogs = <Blog>[];
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
          blogs.add(usersBlog);
          print(usersBlog.reads.toString() + " " + usersBlog.id);
          // setState(() {});
        }
      }).catchError((error) {
        print("can't get user blogs \n $error");
      });
    }
    // print(usersBlogIds);
    return blogs;
  }
}
