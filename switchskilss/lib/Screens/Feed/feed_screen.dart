import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';


class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Responsive(
            desktop: DesktopFeedScreen(),
            mobile: const MobileFeedScreen(),
          ),
        ),
      ),
    );
  }
}

class DesktopFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
      ],
    );
  }
}

class MobileFeedScreen extends StatelessWidget {
  const MobileFeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
