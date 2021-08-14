import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class PostDetails extends StatefulWidget {
  String imgurl, title, description, authorName, location;
  PostDetails(
    this.authorName,
    this.imgurl,
    this.description,
    this.location,
    this.title,
  );

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        height: 30.h,
        width: 30.w,
        child: Icon(Icons.redeem),
      ),
    );
  }
}
