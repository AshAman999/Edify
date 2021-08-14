import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:edify/database/add_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sizer/sizer.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  FirebaseHelper helper = FirebaseHelper();

  late TextEditingController location;
  bool isloading = false;
  String imglink = "";
  String title = "", description = "", city = "", author = "";
  String imagePath = "";
  final picker = ImagePicker();
  var pickedFile;
  void selectImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<String> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var first;
    setState(() async {
      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      first = addresses.first.locality;
      print(" : $first");
    });
    city = first;
    return first;
  }

  @override
  void initState() {
    author = (FirebaseAuth.instance.currentUser!.displayName == null
        ? "Aman Tester"
        : FirebaseAuth.instance.currentUser!.displayName)!;

    setState(() {
      getLocation();
      location = TextEditingController(text: city);
    });
    super.initState();
  }

  void postBlog() async {
    if (pickedFile == null) {
      // add a pop up warning
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        text: "Please Select an Image",
      );
      return;
    } else if (title == "" || description == "" || location.text == "") {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        text: "Please Fill all the  fields",
      );
      return;
    } else {
      isloading = true;
      final refr = FirebaseStorage.instance
          .ref("uploadedImages/${randomAlphaNumeric(8)}.jpg");
      final task = refr.putFile(File(imagePath));
      final snapshot = await task.whenComplete(() {});
      imglink = await snapshot.ref.getDownloadURL();
      print(imglink);
      Map<String, String> postMap = {
        "uploadedImgUrl": imglink,
        "uploaderName": author,
        "title": title,
        "desc": description,
        "Location": location.text,
      };
      helper.addData(postMap).then((value) {
        print("upload sucessfull");
        setState(() {
          imagePath = "";
          pickedFile = null;
          title = "";
          description = "";
          location.text = "";
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Sucessfully Posted",
          );
          setState(() {
            isloading = false;
          });
          return;
        });
      }); // upload image to firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Post'),
        backgroundColor: Colors.lightBlue[400],
        elevation: 0,
        toolbarHeight: 6.h,
      ),
      body: SafeArea(
        child: isloading
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(
                        radius: 10,
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 2.h),
                          child: imagePath == ""
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.black26,
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "Select a photo from the device",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                              : Image.file(
                                  File(imagePath),
                                  fit: BoxFit.cover,
                                ),
                          height: 20.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 0.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Title",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoTextField(
                              placeholder: "Enter a short title",
                              onChanged: (value) {
                                title = value;
                              },
                            ),
                            Text(
                              "Description",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoTextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              clearButtonMode: OverlayVisibilityMode.editing,
                              placeholder: "Enter a short description",
                              onChanged: (value) {
                                description = value;
                              },
                            ),
                            Text(
                              "Location",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoTextField(
                              placeholder: city,
                              autofillHints: [city],
                              controller: location,
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 25),
                                padding: EdgeInsets.all(10),
                                child: CupertinoButton(
                                    color: Colors.blue,
                                    child: Text("Post"),
                                    onPressed: () {
                                      setState(() {});
                                      print("clicked");
                                      postBlog();
                                    }),
                              ),
                            ),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
