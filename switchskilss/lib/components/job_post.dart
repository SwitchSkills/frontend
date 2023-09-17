import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../Screens/Likes/likes_screen.dart';
import 'bottom_nav_bar.dart';
import '../../../user_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JobPost extends StatefulWidget {
  final String profileImageUrl;
  final String title;
  final String description;
  final String postImageUrl;
  final String jobLocation;
  final String region_name;
  final String country; 
  final List<String> tags;
  final String firstNameOwner; 
  final String lastNameOwner;
  final String phoneNumber; 
  final String emailAddress; 
  final String userLocation; 
  final double starRating;

  JobPost({
    Key? key,
    required this.profileImageUrl,
    required this.title,
    required this.description,
    required this.postImageUrl,
    required this.jobLocation, 
    required this.region_name,
    required this.country,
    required this.tags,
    required this.firstNameOwner, 
    required this.lastNameOwner, 
    required this.phoneNumber, 
    required this.emailAddress, 
    required this.userLocation,
    required this.starRating, 
  }) : super(key: key);

  @override
  _JobPostState createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {

  String firstNameLiker = "";
  String lastNameLiker = "";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }


  Future<void> _fetchUserData() async {
    final Map<String, String> userData = await UserPreferences().getUserData();

    setState(() {
      firstNameLiker = userData['first_name'] ?? "";
      lastNameLiker = userData['last_name'] ?? "";
    });
  }

_showContactOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue),
              title: Text('Call'),
              onTap: () => _launchURL(context, 'tel:${widget.phoneNumber}'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.green),
              title: Text('Email'),
              onTap: () => _launchURL(context, 'tel:${widget.emailAddress}'),
            ),
          ],
        ),
      );
    },
  );
}

_launchURL(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not launch $url'),
      ),
    );
  }
}
  


void showProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        ),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Profile Information'),
            IconButton(
                icon: Icon(Icons.close),
                color: Colors.orange,
                onPressed: () => Navigator.of(context).pop(),
            ),
            ],
        ),
        content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 30, 
            ),
            child: Table(
                border: TableBorder.all(color: Colors.orange),
                columnWidths: {
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
                },
                children: [
                _createRow('First Name:', widget.firstNameOwner),
                _createRow('Last Name:', widget.lastNameOwner),
                _createRow('Phone Number:', widget.phoneNumber),
                _createRow('Email Address:', widget.emailAddress),
                _createRow('Location:', widget.userLocation),
                ],
            ),
            ),
        ),
    ),
  );
}


TableRow _createRow(String label, String value) {
  return TableRow(
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
        ),
        child: Text(label),
      ),
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
        ),
        child: Text(value),
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () => showProfileDialog(context),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.profileImageUrl),
                    ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final url = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(widget.jobLocation)}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      widget.jobLocation,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Image.asset(widget.postImageUrl),
            SizedBox(height: 10),
            Center( 
                child: Wrap(
                    spacing: 8,
                    children: widget.tags.map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                        tag,
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        ),
                    ),
                    )).toList(),
                ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => Share.share('Check out this job post!'),
                  color: Colors.green,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showContactOptions(context),
                    child: Text("Contact"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () async {
                    final requestData = {
                      'first_name': firstNameLiker,
                      'last_name': lastNameLiker,
                      'title': widget.title,
                      'job_region': {
                        'country': widget.country, 
                        'region_name': widget.region_name,
                      },
                      'first_name_owner': widget.firstNameOwner,
                      'last_name_owner': widget.lastNameOwner
                    };
                    print(requestData);

                    final response = await http.post(
                      Uri.parse('https://ethereal-yen-394407.ew.r.appspot.com/user_liked_job'),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                      body: json.encode(requestData),
                    );

                    
                    if (response.statusCode == 200) {
                      final responseBody = json.decode(response.body);
                      if (responseBody['code'] == 200) {
                       
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Post has been added to your liked post.'),
                            action: SnackBarAction(
                              label: 'Go to Likes',
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                                BottomNavBarState? bottomNavBarState = context.findAncestorStateOfType<BottomNavBarState>();
                                if (bottomNavBarState != null) {
                                  bottomNavBarState.navigateToLikesScreen();
                                }
                              },
                            ),
                          ),
                        );
                      } else if (responseBody['code'] == 400) {
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Client error: ${responseBody['message']}'),
                          ),
                        );
                      } else {
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Unexpected response from the server.'),
                          ),
                        );
                      }
                    } else {
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to connect to the server.'),
                        ),
                      );
                    }
                  },
                  color: Colors.pink,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}





