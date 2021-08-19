import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edify/database/add_post.dart';
import 'package:edify/screens/postdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  late QuerySnapshot blogSnapshot;
  bool loaded = false;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    firebaseHelper.getBlogs().then((result) {
      blogSnapshot = result;
      loaded = true;
      print(result.docs[0].get("uploaderName").toString());
      setState(() {});
      super.initState();
    });
  }

  Widget postlist() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _controller,
      itemCount: blogSnapshot.docs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return PostTile(
          blogSnapshot.docs[index].get("uploaderName"),
          blogSnapshot.docs[index].get("uploadedImgUrl"),
          blogSnapshot.docs[index].get("desc"),
          blogSnapshot.docs[index].get("Location"),
          blogSnapshot.docs[index].get("title"),
          blogSnapshot.docs[index].id,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: Icon(Icons.menu),
          title: Text(
            "Edify",
            style: GoogleFonts.shadowsIntoLight(
              letterSpacing: 2.sp,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0,
          toolbarHeight: 6.h,
        ),
        body: loaded
            ? postlist()
            : Center(
                child: CupertinoActivityIndicator(),
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PostTile extends StatelessWidget {
  String imgurl, title, description, authorName, location, id;
  PostTile(
    this.authorName,
    this.imgurl,
    this.description,
    this.location,
    this.title,
    this.id,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("postTile tapped");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetails(
                authorName, imgurl, description, location, title, id),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),
        margin: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 3.w)),
                      Icon(
                        Icons.people,
                        color: Colors.lightBlueAccent,
                      ),
                      Container(
                        padding: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // round the corners

                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          authorName,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      // round the corners

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      "$location",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(2.w, 0, 1.w, 2.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 14.h,
                      width: 44.w,
                      child: Stack(fit: StackFit.expand, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Hero(
                            tag: imgurl,
                            child: CachedNetworkImage(
                              imageUrl: imgurl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 42.w,
                              child: SingleChildScrollView(
                                child: Text(
                                  "Title",
                                  style: TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 42.w,
                              height: 2.h,
                              child: SingleChildScrollView(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 42.w,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 42.w,
                              height: 4.h,
                              child: SingleChildScrollView(
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
      ),
    );
  }
}

//  width: 200,
//         height: 320,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//               bottomLeft: Radius.circular(10),
//               bottomRight: Radius.circular(10)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(Icons.person),
//                 SizedBox(width: 20),
//                 Text(
//                   authorName,
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 SizedBox(width: 20),
//                 Text(location),
//               ],
//             ),
//             CachedNetworkImage(
//               imageUrl: imgurl,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: 200,
//               placeholder: (context, url) => CupertinoActivityIndicator(),
//               // progressIndicatorBuilder: (context, url, downloadProgress) =>
//               //     CircularProgressIndicator(value: downloadProgress.progress),

//               errorWidget: (context, url, error) => Icon(Icons.error),
//             ),
//             Text(title),
//             Text(description),
//           ],
//         )
