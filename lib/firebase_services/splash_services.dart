import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/utils/routes/routes.dart';
import 'package:firebase_tutorial/utils/routes/routes_names.dart';
import 'package:flutter/cupertino.dart';

class SplashServices{
  void isLogin(BuildContext context){
    FirebaseAuth auth=FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesNames.postScreen);
      });
    }
    else{
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesNames.loginScreen);
      });
    }

  }
}