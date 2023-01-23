import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_owl/res/custom_widgets.dart';
import 'package:reading_owl/tabs/home_page.dart';
import 'package:reading_owl/tabs/library_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Widget SideDrawer(BuildContext context, String username) {
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
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
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
              fontSize: 20,
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
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

  var username = FirebaseAuth.instance.currentUser?.email.toString();

  final tabs = [const HomePage(), const LibraryPage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      drawer: SideDrawer(context, username!),
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
