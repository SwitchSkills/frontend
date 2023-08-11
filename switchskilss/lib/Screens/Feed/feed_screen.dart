import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import '../../components/job_post.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: Responsive(
          desktop: DesktopFeedScreen(),
          mobile: const MobileFeedScreen(),
        ),
      ),
    );
  }
}

class DesktopFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [],
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
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return JobPost(
                profileImageUrl: 'assets/images/profile_pic.jpg',
                title: 'Job Title $index',
                description: 'Job description for job $index...',
                postImageUrl: 'assets/images/post_pic.png',
              );
            },
          ),
        ),
      ],
    );
  }
}
