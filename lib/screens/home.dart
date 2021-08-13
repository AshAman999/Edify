import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edify/database/add_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          title: Text("Edify"),
          backgroundColor: Colors.lightBlue[400],
          elevation: 0,
          toolbarHeight: 40,
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
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.all(8),
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
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 0),
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(Icons.people),
                // SizedBox(
                //   width: 5,
                // ),
                Text(authorName),
                SizedBox(
                  width: 220,
                ),
                Text(
                  "$location",
                  style: TextStyle(
                    fontSize: 14,
                    backgroundColor: Colors.black,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 10, 20),
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
                    height: 180,
                    width: 260,
                    child: Stack(fit: StackFit.expand, children: [
                      CachedNetworkImage(
                        imageUrl: imgurl,
                        fit: BoxFit.cover,
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 90,
                              child: Text(
                                "Title",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 30,
                              child: SingleChildScrollView(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 90,
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 90,
                              height: 100,
                              child: SingleChildScrollView(
                                child: Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 12,
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
