import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PostDetails extends StatelessWidget {
  String imgurl, title, description, authorName, location;
  PostDetails(
    this.authorName,
    this.imgurl,
    this.description,
    this.location,
    this.title,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_left),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.lightBlue[400],
        elevation: 0,
        toolbarHeight: 6.h,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: imgurl,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: 30.h,
                    width: 90.w,
                    imageUrl: imgurl,
                  ),
                ),
              )),
              SizedBox(
                height: 2.h,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Title",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(title,
                            style: GoogleFonts.benchNine(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto-Regular',
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        Container(
                          width: 70.w,
                          child: Text(description,
                              style: GoogleFonts.benchNine(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                    height: 1),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(authorName),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          width: 100.w,
          height: 100.h,
          color: Colors.white,
        ),
      ),
    );
  }
}
