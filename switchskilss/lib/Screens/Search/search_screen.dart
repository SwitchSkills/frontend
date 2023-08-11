import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: DesktopSearchScreen(),
            mobile: const MobileSearchScreen(),
          ),
        ),
      ),
    );
  }
}

class DesktopSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
      ],
    );
  }
}

class MobileSearchScreen extends StatelessWidget {
  const MobileSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(); 
  }
}
