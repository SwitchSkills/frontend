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
            
            List<String> tags = [];
            if (index % 3 == 0) tags = ['Skill 1'];
            if (index % 3 == 1) tags = ['Skill 1', 'Skill 2'];
            if (index % 3 == 2) tags = ['Skill 1', 'Skill 2', 'Skill 3'];

            return JobPost(
              profileImageUrl: 'assets/images/profile_pic.jpg',
              title: 'Job Title $index',
              description: 'Job description for job $index...',
              postImageUrl: 'assets/images/post_pic.png',
              location: 'Hasselt', 
              tags: tags, 
              firstName: 'First Name $index',
              lastName: 'Last Name $index',
              phoneNumber: '+32 471 23 45 67',
              emailAddress: 'mail@example.com',
              userLocation: 'User $index Location',
              starRating: 4.5,
            );
          },
        ),
      ),
    ],
  );
}

}
