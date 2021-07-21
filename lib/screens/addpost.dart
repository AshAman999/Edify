import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String title = "", description = "", location = "";
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

  void postBlog() {
    if (pickedFile == null) {
      // add a pop up warning
    } else {
      // upload image to firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Add a Post'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: imagePath == ""
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_a_photo_outlined,
                                color: Colors.black26,
                              ),
                              SizedBox(
                                height: 15,
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
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
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
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CupertinoTextField(
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
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CupertinoTextField(
                        placeholder: "Enter a location",
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 25),
                          padding: EdgeInsets.all(10),
                          child: CupertinoButton(
                              color: Colors.blue,
                              child: Text("Post"),
                              onPressed: () {
                                postBlog();
                                print("clicked");
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
