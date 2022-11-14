
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:firebase_tutorial/views/auth_view/forget_password.dart';
import 'package:firebase_tutorial/views/auth_view/register_with_phone_number.dart';
import 'package:firebase_tutorial/views/auth_view/signup_view.dart';
import 'package:firebase_tutorial/views/auth_view/verify_code_screen.dart';
import 'package:firebase_tutorial/views/firestore/firestore_new_post.dart';
import 'package:firebase_tutorial/views/firestore/firestore_post_screen.dart';
import 'package:firebase_tutorial/views/post_screen/new_post.dart';
import 'package:firebase_tutorial/views/post_screen/post_screen.dart';
import 'package:firebase_tutorial/views/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../views/auth_view/login_view.dart';
import '../../views/upload_image.dart';

class Routes{
  static MaterialPageRoute generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RoutesNames.loginScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>LoginScreen());
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashScreen());
      case RoutesNames.signupScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>SignUpScreen());
      case RoutesNames.postScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>PostScreen());
      case RoutesNames.registerWithPhoneNumberScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>RegisterWithPhone());
      case RoutesNames.newPost:
        return MaterialPageRoute(builder: (BuildContext context)=>NewPost());
      case RoutesNames.firestorePostScreen:
        return MaterialPageRoute(builder: (BuildContext context)=>FirestorePostScreen());
      case RoutesNames.firestoreNewPost:
        return MaterialPageRoute(builder: (BuildContext context)=>FirestoreNewPost());
      case RoutesNames.uploadImage:
        return MaterialPageRoute(builder: (BuildContext context)=>UploadImage());
      case RoutesNames.forgetPassword:
        return MaterialPageRoute(builder: (BuildContext context)=>ForgetPassword());
      // case RoutesNames.verifyCode:
      //   return MaterialPageRoute(builder: (BuildContext context)=>VerifyCodeScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
           body: Center(
             child: Text('No route defined'),
           ),
          );
        });
    }
  }
}