import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:firebase_tutorial/utils/utils.dart';
import 'package:flutter/material.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailContoller=TextEditingController();
  TextEditingController _passwordContoller=TextEditingController();
  bool isLoading=false;
  final formKey=GlobalKey<FormState>();
  FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  void dispose() {
    _emailContoller.dispose();
    _passwordContoller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void signUp(){
    setState(() {
      isLoading=true;
    });
    _auth.createUserWithEmailAndPassword(email: _emailContoller.text.toString(),
        password: _passwordContoller.text.toString()).then((value) {
      setState(() {
        isLoading=false;
      });
      Navigator.pushNamed(context, RoutesNames.postScreen);
    }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
      setState(() {
        isLoading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*1;
    final width=MediaQuery.of(context).size.width*1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailContoller,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Enter email',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height*0.04,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _passwordContoller,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter password',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.1,),
            RoundButton(
                loading: isLoading,
                title: 'SignUp', onTap: (){
              if(formKey.currentState!.validate()){
                signUp();
              }
            }),
            SizedBox(height: height*0.1,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RoutesNames.registerWithPhoneNumberScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Center(child: Text('Phone Number'),),
              ),
            ),
            SizedBox(height: height*0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an acoout?"),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, RoutesNames.loginScreen);
                },
                    child: Text('Login')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
