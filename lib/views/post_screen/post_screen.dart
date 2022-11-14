import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../utils/utils.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ref=FirebaseDatabase.instance.ref('Post');
  FirebaseAuth _auth=FirebaseAuth.instance;
  final searchController=TextEditingController();
  final editController=TextEditingController();
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
              Navigator.pushNamed(context, RoutesNames.newPost);
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (String value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search",
                ),
              ),
            ),
            Expanded(child: StreamBuilder(
                stream: ref.onValue,
                builder: (context,AsyncSnapshot<DatabaseEvent> snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context,index){
                          Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
                          List<dynamic> list=[];
                          list.clear();
                          list=map.values.toList();
                          final title=list[index]['post'].toString();
                          if(searchController.text.isEmpty){
                            return ListTile(
                              title: Text(list[index]['post']),
                              subtitle: Text(list[index]['id'].toString()),
                              trailing: PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context)=>[
                                    PopupMenuItem(
                                        value:1,
                                        onTap: (){
                                          //debugPrint('popup');

                                          showDialogBox(title,list[index]['id'].toString());
                                        },
                                        child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    )),
                                    PopupMenuItem(
                                        value:1,
                                        onTap: (){
                                          ref.child(list[index]['id'].toString()).remove();
                                        },
                                        child: ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    )),
                                  ]),
                            );
                          }
                          else if(title.toLowerCase().contains(searchController.text.toLowerCase())){
                            return ListTile(
                              title: Text(list[index]['post']),
                              subtitle: Text(list[index]['id'].toString()),
                              trailing: PopupMenuButton(
                                  icon: Icon(Icons.more_vert),
                                  itemBuilder: (context)=>[
                                    PopupMenuItem(
                                        value:1,
                                        onTap: (){
                                          //debugPrint('popup');

                                          showDialogBox(title,list[index]['id'].toString());
                                        },
                                        child: ListTile(
                                          leading: Icon(Icons.edit),
                                          title: Text('Edit'),
                                        )),
                                    PopupMenuItem(
                                        value:1,
                                        // onTap: (){
                                        //   Navigator.pop(context);
                                        //   showDialogBox();
                                        // },
                                        child: ListTile(
                                          leading: Icon(Icons.delete),
                                          title: Text('Delete'),
                                        )),
                                  ]),
                            );
                          }
                          else{
                            return Container();
                          }


                        });
                  }

            }))
          ],
        ),
      ),
    );
  }
  Future<void> showDialogBox(String title,String id)async{
    await Future.delayed(const Duration(milliseconds: 500));
    editController.text=title;
    return showDialog<void>(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context){
         return AlertDialog(
           title: Text('Update'),
           content: Container(
             child: TextFormField(
               controller: editController,
             ),
           ),
           actions: [
             TextButton(onPressed: (){
               Navigator.pop(context);
               ref.child(id).update({
                 'id':id,
                 'post':editController.text,
               }).then((value) {
                 Utils().toastMessage('Post Updated');
               }).onError((error, stackTrace) {
                 Utils().toastMessage(error.toString());
               });
             }, child: Text('Update')),
             TextButton(onPressed: (){
               Navigator.pop(context);
             }, child: Text('Cancel')),
           ],
         );
       }
   );
  }
}
