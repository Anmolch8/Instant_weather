import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/dataprovider.dart';
import './screens/home.dart';
import 'package:weather_app/data.dart';
import 'package:http/http.dart';
import '../data.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
void main() async{
WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp( const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    
    return ChangeNotifierProvider<DataProvider>(create: (context) => DataProvider(),
      child: MaterialApp(
 
        debugShowCheckedModeBanner: false,
        title: 'Instant Weather',
        theme: ThemeData(
        
          primarySwatch: Colors.blueGrey,
        ),
         routes: {
          //"/load":(context) => Loading(),
           "/":(context) => const HomeScreen(),
         },
      ),
    );
  }
}   
Future<DataModel> dataCalling() async{
  late DataModel result;
  Future<Position> _specifyPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {

    return Future.error(103);
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

         return Future.error(103);
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
 
    return Future.error(
      103);
  } 
  
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best,timeLimit: const Duration(seconds: 10));
}
  Position location= await _specifyPosition();
  double lat=location.latitude;
  double lon=location.longitude;
  try{
  Response response= await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&appid=040ecd064acc379252352cae1dd9f65b'));
  Map<String,dynamic> rawData= await jsonDecode(response.body);
  result= DataModel.fromjson(rawData);
    return result;
  
  }catch(e){
 return Future.error(101);
  }
  }
  


  


  Future<DataModel> searchByCity(String cityname)async {
    late DataModel result;
   String cityName=cityname;
    
    Response response= await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=7460a494d7776c33e36b87c291614d3c"));
  if(response.statusCode==200){
  Map<String,dynamic> rawData= await jsonDecode(response.body);
  result= DataModel.fromjson(rawData);
   return result;
  }
 
 if(response.statusCode==404 || response.statusCode==400){
   throw Exception(102);
 }
   return Future.error('oops');
 
   

  }