import 'package:flutter/material.dart';

class JobPost extends StatelessWidget {
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

  const JobPost({
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Profile Information'),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 30, // Adjust as needed
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
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () => showProfileDialog(context), // Open dialog
                    child: CircleAvatar(
                        backgroundImage: AssetImage(profileImageUrl),
                    ),
                ),
                SizedBox(width: 10),
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
                Container( 
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue, 
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
              ],
            ),
            SizedBox(height: 10),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Image.asset(postImageUrl),
            SizedBox(height: 10),
            Center( 
                child: Wrap(
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => print("Shared"),
                  color: Colors.green,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => print("Contact"),
                    child: Text("Contact"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () => print("Liked"),
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
