import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import 'components/profile_information.dart';
import '../../components/user_job_post.dart';
import '../../components/liked_jobs_counter.dart';
import 'dart:convert';
import '../../../user_preferences.dart';

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
class MobileProfileScreen extends StatefulWidget {
  @override
  _MobileProfileScreenState createState() => _MobileProfileScreenState();
}


class _MobileProfileScreenState extends State<MobileProfileScreen> {
  String profilePictureUrl = '';
  String firstName = "";
  String lastName = "";
  List<String> skills = [];
  List<String> regions = [];
  String email = "";
  String telephone = "";
  String location = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    Map<String, String> userData = await UserPreferences().getUserData();

    List<dynamic> decodedSkillsList = jsonDecode(userData['labels'] ?? '[]');
    List<dynamic> decodedRegionsList = jsonDecode(userData['regions'] ?? '[]');

    List<Map<String, String>> decodedSkills = decodedSkillsList.cast<Map<String, String>>();
    List<Map<String, String>> decodedRegions = decodedRegionsList.cast<Map<String, String>>();

    setState(() {
      firstName = userData['first_name'] ?? '';
      lastName = userData['last_name'] ?? '';
      email = userData['email_address'] ?? '';
      telephone = userData['phone_number'] ?? '';
      location = userData['location'] ?? '';
      skills = decodedSkills.map((skillMap) => skillMap['label_name'] as String).toList();
      regions = decodedRegions.map((regionMap) => regionMap['region_name'] as String).toList();
    });
}


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
            location: location,
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
