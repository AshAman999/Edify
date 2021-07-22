import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edify/database/add_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  late QuerySnapshot blogSnapshot;
  bool loaded = false;
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
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: Icon(Icons.menu),
            middle: Text("Edify"),
          ),
          child: loaded
              ? Container(
                  margin: EdgeInsets.fromLTRB(2, 0, 2, 2),
                  child: postlist(),
                )
              : Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                )),
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
      margin: EdgeInsets.only(bottom: 8),
      height: 150,
      child: Container(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: NetworkImage(imgurl),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(title),
                  Text(description),
                  Text(authorName),
                  Text(location),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
