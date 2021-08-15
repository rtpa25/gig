import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCircle extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String timestamp;
  StatusCircle(
      {@required this.imageUrl, @required this.name, @required this.timestamp});
  @override
  StatusCircleState createState() => StatusCircleState();
}

class StatusCircleState extends State<StatusCircle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            widget.imageUrl,
          ),
        ),
        Column(
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.white,
              ),
            ),
            Text(
              widget.timestamp,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white38,
              ),
            ),
          ],
        )
      ],
    );
  }
}
