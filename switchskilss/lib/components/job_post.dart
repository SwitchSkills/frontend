import 'package:flutter/material.dart';

class JobPost extends StatelessWidget {
  final String profileImageUrl;
  final String title;
  final String description;
  final String postImageUrl;

  const JobPost({
    Key? key,
    required this.profileImageUrl,
    required this.title,
    required this.description,
    required this.postImageUrl,
  }) : super(key: key);

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
                CircleAvatar(
                  backgroundImage: AssetImage(profileImageUrl),
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
