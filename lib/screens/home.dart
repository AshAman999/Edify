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
            blogSnapshot.docs[index].get("title"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text(
            "Edify",
            style: GoogleFonts.shadowsIntoLight(
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.lightBlue[400],
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
  String imgurl, title, description, authorName, location;
  PostTile(
    this.authorName,
    this.imgurl,
    this.description,
    this.location,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("postTile tapped");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PostDetails(authorName, imgurl, description, location, title),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 2.h),
        margin: EdgeInsets.all(2.w),
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
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 3.w)),
                      Icon(
                        Icons.people,
                        color: Colors.lightBlue,
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
                            color: Colors.blue,
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
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                            spreadRadius: 8,
                            blurRadius: 9,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 28.h,
                      width: 65.w,
                      child: Stack(fit: StackFit.expand, children: [
                        CachedNetworkImage(
                          imageUrl: imgurl,
                          fit: BoxFit.cover,
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 20.w,
                                child: Text(
                                  "Title",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 20.w,
                                height: 4.h,
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
                                width: 22.w,
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 24.w,
                                height: 10.h,
                                child: SingleChildScrollView(
                                  child: Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
