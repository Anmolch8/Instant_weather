import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/dataprovider.dart';
import 'package:weather_app/screens/loading.dart';
import './screens/home.dart';
import 'package:weather_app/data.dart';
import 'package:http/http.dart';
import '../data.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
void main() async{
WidgetsFlutterBinding.ensureInitialized();
 
  runApp( MyApp());
}
class MyApp extends StatefulWidget {
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
        title: 'Flutter Demo',
        theme: ThemeData(
        
          primarySwatch: Colors.blue,
        ),
         routes: {
          //"/load":(context) => Loading(),
           "/":(context) => HomeScreen(),
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

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
 
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
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
  Map<String,dynamic> rawData= await jsonDecode(response.body);
  result= DataModel.fromjson(rawData);

 
    return result;

  }