import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  String title;
  final loading;
  final VoidCallback onTap;
  RoundButton({Key? key,required this.title,
  required this.onTap,
    this.loading=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child:loading?CircularProgressIndicator(color: Colors.white,):
            Text(title,style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),),
          ),
        ),
      ),
    );
  }
}
