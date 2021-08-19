import 'package:edify/screens/ProfileEdit.dart';
import 'package:edify/screens/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.lightBlueAccent;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipRRect(
      borderRadius: BorderRadius.circular(90.0),
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          height: 150,
          width: 150,
          fit: BoxFit.cover,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoButton(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.lightBlueAccent,
        child: Text(text),
        onPressed: onClicked,
      );
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get user about information

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Section"),
        backgroundColor: Colors.lightBlue[400],
        elevation: 0,
        toolbarHeight: 6.h,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_rounded),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileWidget(
            imagePath: user!.photoURL == null
                ? "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F13%2F2015%2F04%2F05%2Ffeatured.jpg&q=85"
                : user.photoURL.toString(),
            onClicked: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileForm(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton(user)),
          // const SizedBox(height: 5),
          buildName(user),
          const SizedBox(height: 24),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(user) => Column(
        children: [
          const SizedBox(height: 4),
          Text(
            user.email == null ? "Not logged in" : user.email,
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          )
        ],
      );

  Widget buildUpgradeButton(user) => ButtonWidget(
      text: user.displayName == "" ? "Edit Name" : user.displayName,
      onClicked: () async {});

  Widget buildAbout(user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Container(
              height: 34.h,
              child: SingleChildScrollView(
                child: Text(
                  // user.about,
                  "Some random giberish text  thea galley ofSome random giberiSomSome random giberish text  thea galley ofSome random giberish text  thea galley ofSome random giberish text  thea galley ofe random giberish text  thea galley ofSome random giberish text  thea galley ofsh text  thea galley ofrr type am giberish text  thea galley of type am giberish text  thea galley of type am giberish text  thea galley of type ",
                  style: TextStyle(fontSize: 12.sp, height: 1.4.sp),
                ),
              ),
            ),
          ],
        ),
      ));
}
