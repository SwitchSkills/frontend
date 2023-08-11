import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import '../../components/job_post.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: Responsive(
          desktop: DesktopLikesScreen(),
          mobile: const MobileLikesScreen(),
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
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            List<String> tags = [];
            if (index % 3 == 0) tags = ['Skill 1'];
            if (index % 3 == 1) tags = ['Skill 1', 'Skill 2'];
            if (index % 3 == 2) tags = ['Skill 1', 'Skill 2', 'Skill 3'];

            return JobPost(
              profileImageUrl: 'assets/images/profile_pic.jpg',
              title: 'Liked Job $index',
              description: 'Job description for liked job $index...',
              postImageUrl: 'assets/images/post_pic.png',
              location: 'Location $index', 
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


