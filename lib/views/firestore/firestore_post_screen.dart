import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../utils/utils.dart';
class FirestorePostScreen extends StatefulWidget {
  const FirestorePostScreen({Key? key}) : super(key: key);

  @override
  State<FirestorePostScreen> createState() => _FirestorePostScreenState();
}

class _FirestorePostScreenState extends State<FirestorePostScreen> {
  final firestore=FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference reference=FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth=FirebaseAuth.instance;
  final searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Post Screen'),
          actions: [
            GestureDetector(
                onTap: (){
                  _auth.signOut().then((value){
                    Navigator.pushNamed(context, RoutesNames.loginScreen);
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Icon(Icons.logout_outlined)),
            SizedBox(width: 10,),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            Navigator.pushNamed(context, RoutesNames.firestoreNewPost);
          },
          child: Icon(Icons.add),),
        body: Column(
          children: [
            // Expanded(
            //     child:FirebaseAnimatedList(
            //         query: ref,
            //         itemBuilder: (context,snapshot,animation,index){
            //           return ListTile(
            //             title: Text(snapshot.child('post').value.toString()),
            //           );
            //         }
            //     ),
            // ),

           StreamBuilder<QuerySnapshot>(
               stream: firestore,
               builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
             if(snapshot.connectionState==ConnectionState.waiting){
               return Center(child: CircularProgressIndicator());
             }
             if(snapshot.hasError){
               return Center(child: Text('Something went wrong'));
             }
             return Expanded(
               child: ListView.builder(
                   itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context,index){
                 return ListTile(
                   onTap: (){
                     reference.doc(snapshot.data!.docs[index]['id'].toString()).update({
                       'title' : 'Updated post',
                       'id': snapshot.data!.docs[index]['id'].toString()
                     }).then((value) {
                       Utils().toastMessage('Post updated');
                     }).onError((error, stackTrace) {
                       Utils().toastMessage(error.toString());
                     });
                   },
                   onLongPress: (){
                     reference.doc(snapshot.data!.docs[index]['id'].toString()).delete().then((value){
                       Utils().toastMessage('Post deleted');
                     }).onError((error, stackTrace) {
                       Utils().toastMessage(error.toString());
                     });
                   },
                   title: Text(snapshot.data!.docs[index]['title'].toString()),
                   subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                 );
               }),
             );
           })
          ],
        ),
      ),
    );
  }
  // Future<void> showDialogBox(String title,String id)async{
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   editController.text=title;
  //   return showDialog<void>(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //           title: Text('Update'),
  //           content: Container(
  //             child: TextFormField(
  //               controller: editController,
  //             ),
  //           ),
  //           actions: [
  //             TextButton(onPressed: (){
  //               Navigator.pop(context);
  //               ref.child(id).update({
  //                 'id':id,
  //                 'post':editController.text,
  //               }).then((value) {
  //                 Utils().toastMessage('Post Updated');
  //               }).onError((error, stackTrace) {
  //                 Utils().toastMessage(error.toString());
  //               });
  //             }, child: Text('Update')),
  //             TextButton(onPressed: (){
  //               Navigator.pop(context);
  //             }, child: Text('Cancel')),
  //           ],
  //         );
  //       }
  //   );
  // }
}
