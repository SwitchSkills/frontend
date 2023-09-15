import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import '../../components/job_post.dart';
import '../../components/liked_jobs_counter.dart';


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
    int JobCounter = 3;
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Liked Jobs",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 10),
                LikedJobsCounter(likedJobsCount: JobCounter),
              ],
            ),
          ),
        ),
        
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: JobCounter,
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



