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
        ),
        body: loaded
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
        width: 200,
        height: 320,
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
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.person),
                SizedBox(width: 20),
                Text(
                  authorName,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 20),
                Text(location),
              ],
            ),
            CachedNetworkImage(
              imageUrl: imgurl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
                placeholder: (context, url) => CupertinoActivityIndicator(),
              // progressIndicatorBuilder: (context, url, downloadProgress) =>
              //     CircularProgressIndicator(value: downloadProgress.progress),

              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(title),
            Text(description),
          ],
        )

        /* add child content here */
        );
  }
}
