import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../res/custom_widgets.dart';
import '../res/data_structures.dart';
import 'package:reading_owl/res/colors.dart';

class ReadingScreen extends StatefulWidget {
  final Blog blog;
  ReadingScreen({
    super.key,
    required this.blog,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  var firestoreInstance = FirebaseFirestore.instance.collection('blogs');

  Future<dynamic> getReads(String blogId) async {
    // ignore: prefer_typing_uninitialized_variables
    var curReads = 0;
    final dbRef = firestoreInstance.doc(widget.blog.id.toString());
    await dbRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        curReads = data['reads'];
      },
      onError: (e) => showToast(context, 'Cant get blog ID', 'error'),
    );

    var newReads = curReads + 1;
    await Future.delayed(const Duration(seconds: 30));
    await dbRef.update({'reads': newReads}).catchError(
        (onError) => showToast(context, onError.toString(), 'alert'));
  }

  @override
  void initState() {
    getReads(widget.blog.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              widget.blog.title,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              color: textColor,
            ),
            Text(
              widget.blog.content,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
              ),
            ),
            Divider(
              color: textColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'By ${widget.blog.author}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Icon(
                  Icons.remove_red_eye_sharp,
                  color: textColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.blog.reads.toString(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
