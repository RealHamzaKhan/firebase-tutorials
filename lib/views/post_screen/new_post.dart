import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  bool loading=false;
  TextEditingController postController=TextEditingController();
  final databaseref=FirebaseDatabase.instance.ref('Post');
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
                databaseref.child(id).set({
                  'id':id,
                  'post':postController.text.toString()
                }).then((value) {
                  Utils().toastMessage('Upload Successful');
                  setState(() {
                    loading=false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading=false;
                  });
                });

          }),
        ],
      ),
    );
  }
}
