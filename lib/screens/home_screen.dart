import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/tabs/home_page.dart';
import 'package:reading_owl/tabs/library_page.dart';
import 'package:reading_owl/res/colors.dart';

import '../res/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Widget SideDrawer(BuildContext context, String email) {
  return Drawer(
    backgroundColor: darkGrey,
    child: ListView(
      children: [
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Signed In as',
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        Divider(
          color: textColor,
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, '/StartWritingScreen'),
          title: Text(
            'Start writing',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Report problem',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
          onTap: () => Navigator.pushNamed(context, '/IssueReportScreen'),
        ),
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
          onTap: () => FirebaseAuth.instance.signOut(),
        ),
      ],
    ),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  late String email;

  final tabs = [const HomePage(), const LibraryPage()];
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
        // leading: Padding(
        //   padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
        //   child: OwlImage(context),
        // ),
        // toolbarHeight: 70,
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
        ],
      ),
    );
  }
}
