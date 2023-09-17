import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import '../../components/job_post.dart';
import '../../components/liked_jobs_counter.dart';


class LikesScreen extends StatefulWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  _LikesScreenState createState() => _LikesScreenState();

  class _LikesScreenState extends State<LikesScreen>{

    List<dynamic> feedData = [];

    @override
    void initState() {
      super.initState();
      fetchFeed();
    }

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

    Future<void> fetchFeed({

    }

    )
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

  final List<dynamic> feedData;

  const MobileLikesScreen({
    Key? key,
    required this.feedData,
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
          child: feedData.isEmpty 
            ? Center(child: Text("No posts available to display.")) 
            : ListView.builder(
                itemCount: feedData.length,
                itemBuilder: (context, index) {
                  final job = feedData[feedData.length - 1 - index];
                  return JobPost(
                    title: job['title'] ?? '',
                    profileImageUrl: job['email_address'] ?? '',
                    description: job['job_description'] ?? '',
                    postImageUrl: 'nogleeg', 
                    jobLocation: job['job_location'] ?? '',
                    region_name: job['region_name'] ?? '',
                    country: job['country'] ?? '',
                    tags: List<String>.from(job['labels'].map((label) => label['label_name'] ?? '')),
                    firstNameOwner: job['first_name'] ?? '',
                    lastNameOwner: job['last_name'] ?? '',
                    phoneNumber: job['phone_number'] ?? '',
                    emailAddress: job['email_address'] ?? '',
                    userLocation: job['user_location'] ?? '',
                    starRating: 4.5,
                  );

                },
              ),
        ),
      ],
    );
  }
}



