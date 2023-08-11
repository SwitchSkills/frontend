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
            itemCount: 3,
            itemBuilder: (context, index) {
              return JobPost(
                profileImageUrl: 'assets/images/profile_pic.jpg',
                title: 'Liked Job $index',
                description: 'Job description for liked job $index...',
                postImageUrl: 'assets/images/post_pic.png',
              );
            },
          ),
        ),
      ],
    );
  }
}


