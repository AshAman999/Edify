// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseHelper {
// // Future <void> addBlog(blodData)async{
// //   Firebase.

//   Future<void> addData(blogData) async {
//     print(blogData);
//     FirebaseFirestore.instance
//         .collection("blogs")
//         .add(blogData)
//         .then((value) => print(value))
//         .catchError((e) {
//       print(e);
//     });
//   }

//   getBlogs() async {
//     return FirebaseFirestore.instance.collection("blogs").get();
//   }
// }
