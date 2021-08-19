import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
// Future <void> addBlog(blodData)async{
//   Firebase.

  Future<void> addData(blogData) async {
    print(blogData);
    FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
    });
  }
  //delete a post

  delete(id) async {
    await FirebaseFirestore.instance.collection("blogs").doc(id).delete();
  }

  getBlogs() async {
    return await FirebaseFirestore.instance.collection("blogs").get();
  }
}
