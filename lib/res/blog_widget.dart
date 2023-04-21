import 'package:flutter/material.dart';
import 'package:reading_owl/res/constants.dart';

import '../data_structures/blog.dart';
import '../screens/reading_screen.dart';
import 'colors.dart';

class BlogWidget extends StatelessWidget {
  Blog blog;
  BlogWidget({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
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
          // width: width * 0.95,
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
                  style: TextStyle(color: textColor, fontSize: 20),
                  maxLines: 5,
                ),
                const Text(
                  'more',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
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
}
