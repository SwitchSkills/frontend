import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../Screens/Feed/feed_screen.dart';
import '../Screens/Likes/likes_screen.dart';
import '../Screens/Search/search_screen.dart';
import '../Screens/Profile/profile_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  
  final List<Widget> _pages = [
    FeedScreen(),
    LikesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SwitchSkills'),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.logout),  
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ));
          },
        ),
      ),
      body: _pages[_selectedIndex], 
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


  void navigateToLikesScreen() {
    setState(() {
      _selectedIndex = 1;
    });
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
