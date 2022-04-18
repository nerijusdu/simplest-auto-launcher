import 'package:flutter/material.dart';
import 'package:simplest_auto_launcher/pages/apps.dart';
import 'package:simplest_auto_launcher/pages/home.dart';

const List<Widget> _pages = <Widget>[HomePage(), AppsPage()];

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int selectedIndex = 0;
  bool darkMode = false;

  void onItemTapped(int index) {
    setState(() {
      if (index + 1 > _pages.length) {
        darkMode = true;
      } else {
        selectedIndex = index;
      }
    });
  }

  void lightMode() {
    setState(() {
      darkMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (darkMode) {
      return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: lightMode,
          backgroundColor: const Color(0xFF1F272D),
          child: const Icon(Icons.wb_sunny, color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1F272D),
      body: SafeArea(
        child: Column(
          children: [
            BottomNavigationBar(
              backgroundColor: const Color(0xFF1F272D),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Apps',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dark_mode),
                  label: 'Dark',
                )
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              onTap: onItemTapped,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: _pages[selectedIndex],
            ),
          ],
        ),
      ),
    );
  }
}
