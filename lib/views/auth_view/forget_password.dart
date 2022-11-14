import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailcontroller=TextEditingController();
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),
            RoundButton(title: 'Reset', onTap: (){
              _auth.sendPasswordResetEmail(email: emailcontroller.text).then((value) {
                Utils().toastMessage('Check your email inbox or spam');
              }).onError((error, stackTrace) {
                Utils().toastMessage('Unknown Error occured');
              });
            })
          ],
        ),
      ),
    );
  }
}
