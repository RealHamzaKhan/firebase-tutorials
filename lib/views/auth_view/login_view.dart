import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/res/round_button.dart';
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailContoller=TextEditingController();
  TextEditingController _passwordContoller=TextEditingController();
  final formKey=GlobalKey<FormState>();
  bool isLoading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  void login(){
    setState(() {
      isLoading=true;
    });
    _auth.signInWithEmailAndPassword(email: _emailContoller.text.toString(), password:_passwordContoller.text.toString()).then((value){
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
  void dispose() {
    _emailContoller.dispose();
    _passwordContoller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height*1;
    final width=MediaQuery.of(context).size.width*1;
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
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
              SizedBox(height: height*0.01,),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(onPressed: (){
                  Navigator.pushNamed(context, RoutesNames.forgetPassword);
                },
                    child: Text('Forget Password?')),
              ),
              SizedBox(height: height*0.05,),
              RoundButton(
                  loading: isLoading,
                  title: 'Login', onTap: (){
                if(formKey.currentState!.validate()){
                  login();
                }
              }),
              SizedBox(height: height*0.1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Doesn't have an acoout?"),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, RoutesNames.signupScreen);
                  },
                      child: Text('Sign Up')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
