import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/tabs/home_page.dart';
import 'package:reading_owl/tabs/library_page.dart';
import 'package:reading_owl/res/colors.dart';
import 'package:reading_owl/tabs/your_stories.dart';

import '../res/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  // FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  late String email;

  final tabs = [const HomePage(), const LibraryPage(), const YourStories()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    email = firebaseAuthInstance.currentUser!.email.toString();
    return Scaffold(
      backgroundColor: black,
      drawer: SideDrawer(context, email),
      appBar: AppBar(
        title: Text(
          'Reading Owl',
          style: TextStyle(color: textColor, fontSize: 25),
        ),
        backgroundColor: black,
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: black,
        height: 70,
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: textColor,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: textColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.library_books,
              color: textColor,
            ),
            icon: Icon(
              Icons.library_books_outlined,
              color: textColor,
            ),
            label: 'Library',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: textColor,
            ),
            icon: Icon(
              Icons.person_outline,
              color: textColor,
            ),
            label: 'By You',
          ),
        ],
      ),
    );
  }
}
