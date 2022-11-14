import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  bool loading=false;
  File? image;
  final picker=ImagePicker();
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference=FirebaseDatabase.instance.ref('Post');
  CollectionReference firestoreref=FirebaseFirestore.instance.collection('users');
  Future getImageFromCamera()async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickedFile!=null){
        image=File(pickedFile.path);
      }
      else{
        debugPrint('Image not picked');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: (){
                getImageFromCamera();
              },
              child: Container(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width*0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.5)),
                ),
                child: image!=null?Image.file(image!.absolute,fit: BoxFit.cover,):Icon(Icons.image),
              ),
            ),
          ),
          SizedBox(height: 50,),
          RoundButton(title: 'Upload',loading: loading, onTap: ()async{
            setState(() {
              loading=true;
            });
            String id=DateTime.now().millisecondsSinceEpoch.toString();
            firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/uploaded imaeges/'+id);
            firebase_storage.UploadTask uploadTask=ref.putFile(image!.absolute);
            await Future.value(uploadTask);
            var newUrl=await ref.getDownloadURL();
            databaseReference.child(id).set({
              'id':id,
              'post':newUrl.toString()
            }).then((value) {
              setState(() {
                loading=false;
              });
              Utils().toastMessage('Image Uploaded');
            }).onError((error, stackTrace) {
              setState(() {
                loading=false;
              });
              Utils().toastMessage('Image Upload Error');
            });
            firestoreref.doc(id).set({
              'id':id,
              'title':newUrl.toString()
            });
          }),

        ],
      ),
    );
  }
}
