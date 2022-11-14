import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreNewPost extends StatefulWidget {
  const FirestoreNewPost({Key? key}) : super(key: key);

  @override
  State<FirestoreNewPost> createState() => _FirestoreNewPostState();
}

class _FirestoreNewPostState extends State<FirestoreNewPost> {
  bool loading=false;
  TextEditingController postController=TextEditingController();
  final firestore=FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: "What's in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 50,),
          RoundButton(
              loading: loading,
              title: 'Post', onTap: (){
            setState(() {
              loading=true;
            });
            String id=DateTime.now().millisecondsSinceEpoch.toString();
            firestore.doc(id).set({
              'id' :id,
              'title':postController.text
            }).then((value) {
              setState(() {
                loading=false;
              });
              Utils().toastMessage('Post Uploaded');
            }).onError((error, stackTrace) {
              Utils().toastMessage(error.toString());
            });

          }),
        ],
      ),
    );
  }
}
