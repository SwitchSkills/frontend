import 'package:flutter/material.dart';
import 'package:flutter_auth/responsive.dart';
import '../../components/background.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileFeedScreen(),
          desktop: Row(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}

class MobileFeedScreen extends StatelessWidget {
  const MobileFeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      ],
    );
  }
}
