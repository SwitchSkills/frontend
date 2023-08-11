import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Screens/Feed/feed_screen.dart';
import '../Screens/Likes/likes_screen.dart';
import '../Screens/Search/search_screen.dart';
import '../Screens/Profile/profile_screen.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Define the pages to be displayed
  final List<Widget> _pages = [
    FeedScreen(),
    LikesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SwitchSkills')),
      body: _pages[_selectedIndex], // Switching between pages
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: const Color(0xff757575),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

final List<SalomonBottomBarItem> _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite_border),
    title: const Text("Likes"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("Search"),
    selectedColor: Colors.green,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.blue,
  ),
];
