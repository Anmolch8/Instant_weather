import 'package:flutter/material.dart';


class Loading extends StatefulWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold( body:SafeArea(
    //   child: Column(children: <Widget>[FlatButton.icon(onPressed: 
    //   (){
    //     Navigator.pushNamed(context, "/home");
    //   }, icon: const Icon(Icons.add_to_home_screen), label:const Text("go to home"))],),
    // ));
    return Scaffold(body: Center(child: Image.asset("assets/images/cloudy.png"),),);
  }
}