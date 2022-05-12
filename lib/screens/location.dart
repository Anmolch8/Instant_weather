import 'dart:html';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/loading.dart';


class Location extends StatefulWidget {
  const Location({ Key? key }) : super(key: key);

  @override
  State<Location> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( body:Center( child:Text("home screen"),));
  }
}