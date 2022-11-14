import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';
class VerifyCodeScreen extends StatefulWidget {
  String verificationId;
  VerifyCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  TextEditingController codeController=TextEditingController();
  bool loading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 100),
        child: Column(
          children: [
            TextFormField(
              controller: codeController,
              decoration: InputDecoration(
                  hintText: '6 digit code'
              ),
            ),
            SizedBox(height: 50,),
            RoundButton(
                loading: loading,
                title: 'Sign Up', onTap: ()async{
              final credential=PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: codeController.text.toString());
              try{
                setState(() {
                  loading=true;
                });
                await _auth.signInWithCredential(credential);
                Navigator.pushNamed(context, RoutesNames.postScreen);
                setState(() {
                  loading=false;
                });
              }
              catch(e){
                Utils().toastMessage(e.toString());
                setState(() {
                  loading=false;
                });
              }
            }),
          ],
        ),
      ),
    );
  }
}
