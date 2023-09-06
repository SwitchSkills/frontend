import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../Screens/Likes/likes_screen.dart';
import 'bottom_nav_bar.dart';

class UserJobPost extends StatelessWidget {
  final String profileImageUrl;
  final String title;
  final String description;
  final String postImageUrl;
  final String location; 
  final List<String> tags;
  final String firstName; 
  final String lastName;
  final String phoneNumber; 
  final String emailAddress; 
  final String userLocation; 
  final double starRating;

  const UserJobPost({
    Key? key,
    required this.profileImageUrl,
    required this.title,
    required this.description,
    required this.postImageUrl,
    required this.location, 
    required this.tags,
    required this.firstName, 
    required this.lastName, 
    required this.phoneNumber, 
    required this.emailAddress, 
    required this.userLocation,
    required this.starRating, 
  }) : super(key: key);

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
                _createRow('First Name:', firstName),
                _createRow('Last Name:', lastName),
                _createRow('Phone Number:', phoneNumber),
                _createRow('Email Address:', emailAddress),
                _createRow('Location:', userLocation),
                _createRow('Rating:', starRating.toString()),
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
      side: BorderSide(
        color: Colors.black,
        width: 0.5, 
        ),
    ),

    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              InkWell(
                onTap: () async {
                  final url = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    location,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Image.asset(
                postImageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.edit, size: 16, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: Size(32, 32),
                    ),
                  ),
              Expanded(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: tags.map((tag) => Container(
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
              ),
              ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.delete, size: 16, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        minimumSize: Size(32, 32),
                    ),
                  ),
              
            ],
          ),
        ],
      ),
    ),
  );
}

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
              onTap: () => _launchURL(context, 'tel:+32471785072'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.green),
              title: Text('Email'),
              onTap: () => _launchURL(context, 'mailto:dag.malstaf@gmail.com'),
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


