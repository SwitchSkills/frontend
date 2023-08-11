import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: DesktopLikesScreen(),
            mobile: const MobileLikesScreen(),
          ),
        ),
      ),
    );
  }
}

class DesktopLikesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
      ],
    );
  }
}

class MobileLikesScreen extends StatelessWidget {
  const MobileLikesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Container();
  }
}
