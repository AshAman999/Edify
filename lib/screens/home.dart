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
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: Icon(Icons.menu),
          middle: Text("Edify"),
        ),
        child: loaded
            ? postlist()
            : Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
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
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(3, 4, 3, 4),
      child: Container(
        height: 180,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imgurl,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
      )
      /* add child content here */,
    );
  }
}
