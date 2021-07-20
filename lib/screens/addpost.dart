import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = "", description = "", location = "";
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Add a Post'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
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
                      )
                    ],
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(8),
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
