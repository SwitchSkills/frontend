import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import 'components/profile_information.dart';
import '../../components/user_job_post.dart';
import '../../components/liked_jobs_counter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: Responsive(
          desktop: DesktopProfileScreen(),
          mobile: MobileProfileScreen(),
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
  final String profilePictureUrl = 'assets/images/profile_pic.jpg';
  final String firstName = "Dag";
  final String lastName = "Malstaf";
  final List<String> skills = ["Flutter", "Dart", "Firebase"];
  final List<String> regions = ["Limburg", "Vlaams-Brabant"];
  final String email = "dag.malstaf@example.com";
  final String telephone = "+1234567890";

  @override
  Widget build(BuildContext context) {
    int JobCounter = 3;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          ProfileInformation(
            profilePictureUrl: profilePictureUrl,
            firstName: firstName,
            lastName: lastName,
            skills: skills,
            regions: regions,
            email: email,
            telephone: telephone,
          ),
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
              child: Text(
                "Your Jobs",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,  
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          ...List.generate(JobCounter, (index) { 
            List<String> tags = [];
            if (index % 3 == 0) tags = ['Skill 1'];
            if (index % 3 == 1) tags = ['Skill 1', 'Skill 2'];
            if (index % 3 == 2) tags = ['Skill 1', 'Skill 2', 'Skill 3'];

            return UserJobPost(
              profileImageUrl: 'assets/images/profile_pic.jpg',
              title: 'Your Job $index',
              description: 'Job description for your job $index...',
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
          }),
          SizedBox(height: 20),  
        ],
      ),
    ); 
  }
}
