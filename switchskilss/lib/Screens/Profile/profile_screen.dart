import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import 'components/profile_information.dart';
import '../../components/user_job_post.dart';
import '../../components/liked_jobs_counter.dart';
import 'dart:convert';
import '../../../user_preferences.dart';
import 'package:http/http.dart' as http;


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
  final String profilePictureUrl = 'assets/images/profile_pic.jpg';
  String firstName = "";
  String lastName = "";
  List<String> skills = [];
  List<String> regions = [];
  String email = "";
  String telephone = "";
  String location = "";
  List<dynamic> userJobs = [];

  @override
  void initState() {
    super.initState();
    _fetchUserDataAndJobs();
  }

  Future<void> _fetchUserDataAndJobs() async {
    final Map<String, String> userData = await UserPreferences().getUserData();
    firstName = userData['first_name'] ?? "";
    lastName = userData['last_name'] ?? "";
    List<dynamic> fetchedRegions = json.decode(userData['regions'] ?? '[]');
    regions = fetchedRegions.map((region) => region['region_name'] as String).toList();
    List<dynamic> fetchedLabels = json.decode(userData['labels'] ?? '[]');
    skills = fetchedLabels.map((label) => label['label_name'] as String).toList();
    email = userData['email_address'] ?? "";
    telephone = userData['phone_number'] ?? "";
    location = userData['location'] ?? "";

    final response = await http.post(
      Uri.parse('https://ethereal-yen-394407.ew.r.appspot.com/jobs_owned_by_user'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'first_name': firstName,
        'last_name': lastName,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['code'] == 200) {
        setState(() {
          userJobs = responseBody['message'];
        });
      } else {
        print("Failed to fetch jobs. Server returned: ${responseBody['message']}");
      }
    } else {
      print('Failed to connect to server with status code: ${response.statusCode}');
    }
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

          ...userJobs.map((job) {

            return UserJobPost(
              profileImageUrl: 'assets/images/profile_pic.jpg' ?? '',
              title: job['title'] ?? "",
              description: job['job_description'] ?? "",
              postImageUrl: job['pictures'][0]['picture_location_firebase'] ?? "", 
              location: job['job_location'] ?? "",
              labels: (job['labels'] as List).map((e) => e['label_name'].toString()).toList(),
              firstName: job['first_name'],
              lastName: job['last_name'],
              phoneNumber: job['phone_number'],
              emailAddress: job['email_address'],
              userLocation: job['user_location'],
              starRating: 4.5, 
            );
          }).toList(),
          
          SizedBox(height: 20),
 
        ],
      ),
    ); 
  }
}
