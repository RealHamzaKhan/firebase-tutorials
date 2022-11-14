import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:firebase_tutorial/views/auth_view/verify_code_screen.dart';
import 'package:flutter/material.dart';
class RegisterWithPhone extends StatefulWidget {
  const RegisterWithPhone({Key? key}) : super(key: key);

  @override
  State<RegisterWithPhone> createState() => _RegisterWithPhoneState();
}

class _RegisterWithPhoneState extends State<RegisterWithPhone> {
  bool loading=false;
  TextEditingController numberController=TextEditingController();
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
              controller: numberController,
              decoration: InputDecoration(
                hintText: '+1 392 9241219'
              ),
            ),
            SizedBox(height: 50,),
            RoundButton(
                loading: loading,
                title: 'Sign Up', onTap: (){
              setState(() {
                loading=true;
              });
              _auth.verifyPhoneNumber(
                phoneNumber: numberController.text,
                  verificationCompleted: (_){

                  },
                  verificationFailed: (e){
                    Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationId,int? token){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCodeScreen(verificationId: verificationId)));
                  },
                  codeAutoRetrievalTimeout: (e){
                    Utils().toastMessage(e.toString());
                  });
              setState(() {
                loading=false;
              });
            }),
          ],
        ),
      ),
    );
  }
}
