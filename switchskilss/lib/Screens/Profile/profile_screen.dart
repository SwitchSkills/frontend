import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: DesktopProfileScreen(),
            mobile: const MobileProfileScreen(),
          ),
        ),
      ),
    );
  }
}

class DesktopProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
      ],
    );
  }
}

class MobileProfileScreen extends StatelessWidget {
  const MobileProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container(); 
  }
}
