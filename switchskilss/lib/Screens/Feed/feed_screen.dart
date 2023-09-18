import 'package:flutter/material.dart';
import '../../components/background.dart';
import '../../responsive.dart';
import '../../components/job_post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../user_preferences.dart';


class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isActivityFeed = true; 
  bool hasFetchedFeed = false;
  List<dynamic> feedData = []; 

  @override
  void initState() {
    super.initState();
    _initializeFeed();
  }

  void _initializeFeed() async {
  Map<String, dynamic> userDetails = await getUserDetails();
  if (isActivityFeed) {
    fetchFeed(activityFeedArgs: userDetails['regions']);
  } else {
    fetchFeed(matchJobsArgs: {
      'first_name': userDetails['first_name'],
      'last_name': userDetails['last_name'],
    });
  }
}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasFetchedFeed) {
      _initializeFeed();
      hasFetchedFeed = true;
    }
  }

  @override
  void didUpdateWidget(covariant FeedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initializeFeed();
  }



  @override
  Widget build(BuildContext context) {
    return Background(
      child: SafeArea(
        child: Responsive(
          desktop: DesktopFeedScreen(isActivityFeed: isActivityFeed, toggleFeed: toggleFeed),
          mobile: MobileFeedScreen(isActivityFeed: isActivityFeed, toggleFeed: toggleFeed, feedData: feedData),
        ),
      ),
    );
  }

  void toggleFeed() async {
    Map<String, dynamic> userDetails = await getUserDetails();

    setState(() {
      isActivityFeed = !isActivityFeed;
    });

    if (isActivityFeed) {
      fetchFeed(activityFeedArgs: userDetails['regions']);
    } else {
      fetchFeed(matchJobsArgs: {
        'first_name': userDetails['first_name'],
        'last_name': userDetails['last_name'],
      });
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    final userData = await UserPreferences().getUserData();
    List<dynamic> decodedRegions = jsonDecode(userData['regions']!);

    List<Map<String, dynamic>> regionsList = decodedRegions.map((region) {
      return {
        'country': region['country'],
        'region_name': region['region_name'],
      };
    }).toList();

    return {
      'first_name': userData['first_name']!,
      'last_name': userData['last_name']!,
      'regions': regionsList
    };
  }

  Future<void> fetchFeed({
    List<Map<String, dynamic>>? activityFeedArgs, 
    Map<String, String>? matchJobsArgs,
      }) async {
        String url;
        dynamic requestBody; requestBody;

        if (isActivityFeed) {
          if (activityFeedArgs == null || activityFeedArgs.isEmpty) {
            print('No regions provided. Not making the API call.');
            return; 
          }
          url = 'https://ethereal-yen-394407.ew.r.appspot.com/activity_feed';
          requestBody = activityFeedArgs;
        } else {
          url = 'https://ethereal-yen-394407.ew.r.appspot.com/match_jobs';
          requestBody = matchJobsArgs ?? {};
        }


        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json'
          },
          body: json.encode(requestBody),
        );

        if (response.statusCode == 200) {
          var responseData = json.decode(response.body);
          if (responseData.containsKey('code') && responseData['code'] == 200 && responseData.containsKey('message')) {
            var jobsList = responseData['message'];
            

            if (jobsList is List) {
              if (mounted) { 
                    setState(() {
                        feedData = jobsList;
                    });
                }
            } else {
              print('Unexpected data format for "message": $jobsList');
            }
          } else {
            print('Unexpected response data: $responseData');
          }
        } else {
          print('Error fetching feed: ${response.body}');
        }

      }

}
class DesktopFeedScreen extends StatelessWidget {
  final bool isActivityFeed;
  final VoidCallback toggleFeed;

  DesktopFeedScreen({required this.isActivityFeed, required this.toggleFeed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      ],
    );
  }
}


class MobileFeedScreen extends StatelessWidget {
  final bool isActivityFeed;
  final VoidCallback toggleFeed;
  final List<dynamic> feedData;

  const MobileFeedScreen({
    Key? key,
    required this.isActivityFeed,
    required this.toggleFeed,
    required this.feedData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ToggleButtons(
            borderColor: Colors.orange,
            fillColor: Colors.orange,
            borderWidth: 2,
            selectedBorderColor: Colors.orange,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(30),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text('Activity Feed'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text('Matched Posts'),
              ),
            ],
            onPressed: (int index) {
              toggleFeed();
            },
            isSelected: [isActivityFeed, !isActivityFeed],
          ),
        ),
        Expanded(
          child: feedData.isEmpty 
            ? Center(child: Text("No posts available to display.")) 
            : ListView.builder(
                itemCount: feedData.length,
                itemBuilder: (context, index) {
                  final job = feedData[feedData.length - 1 - index];
                  return JobPost(
                    title: job['title'] ?? '',
                    profileImageUrl: 'assets/images/profile_pic.jpg' ?? '',
                    description: job['job_description'] ?? '',
                    postImageUrl: job['pictures'][0]['picture_location_firebase'] ?? "",  
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
