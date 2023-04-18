import 'package:flutter/material.dart';
import 'package:reading_owl/res/custom_widgets.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListView(
          children: [
            CategoryItem(context, 'Continue Reading', () {}),
            CategoryItem(context, 'For you', () {}),
            CategoryItem(context, 'Latest & Trending', () {}),
            TitleText(context, "Categories"),
            // ListView(
            //   children: [
            //     CategoryItem(context, 'Cat 1', () {}),
            //     CategoryItem(context, 'Cat 1', () {}),
            //     CategoryItem(context, 'Cat 1', () {}),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
