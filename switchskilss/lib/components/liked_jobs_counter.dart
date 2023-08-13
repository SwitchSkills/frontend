import 'package:flutter/material.dart';

class LikedJobsCounter extends StatelessWidget {
  final int likedJobsCount;

  const LikedJobsCounter({
    Key? key,
    required this.likedJobsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            '$likedJobsCount Liked Job${likedJobsCount == 1 ? "" : "s"}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
