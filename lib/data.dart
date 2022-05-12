
import 'dart:ffi';

class DataModel{
final Coord cord;
final Weather weather;
final Maincls maincl;
final int visible;
final Wind wind;
final Clouds cloud;
final DateTime date;
final System sys;
final String city;
final int errcode;
  
   DataModel({required this.cord,required this.weather,required this.maincl,required this.visible, required this.wind,
   required this.cloud,  required this.date,required this.sys,required this.city, required this.errcode});
   factory DataModel.fromjson( Map<String,dynamic> json){
      Coord coord=Coord.fromJson(json["coord"]);
      Weather weather=Weather.fromJson(json["weather"][0]);
      Maincls maincl=Maincls.fromJson(json["main"]);
      int visible=json["visibility"];
      Wind wind=Wind.fromJson(json["wind"]);
      Clouds cloud=Clouds.fromJson(json["clouds"]) ;
      DateTime date=DateTime.fromMillisecondsSinceEpoch(json["dt"]);
      String city=json["name"];
      int errcode=json["cod"];
      System sys=System.fromJson(json["sys"]);
      return DataModel(cord: coord, weather: weather, maincl: maincl, visible: visible, wind: wind, cloud: cloud, date: date, sys: sys, city: city, errcode: errcode);
   }
  
}
class Coord{
final double lat;
final double lon;
Coord({required this.lat,required this.lon});
factory Coord.fromJson(Map<String,dynamic> json){
  double lat=json["lat"];
  double lon=json["lon"];
  return Coord(lat:lat,lon:lon);
} 
}
class Weather{
  final int id;
  final String main;
  final String description;
  final String icon;
 Weather({required this.id,required this.main,required this.description,required this.icon});
 factory Weather.fromJson(Map<String,dynamic> json){
   int id=json["id"];
   String main=json["main"];
   String description=json["description"];
   String icon=json["icon"];
   return Weather(id: id, main: main, description: description, icon: icon);
 }
}
class Maincls{
  final double? temp;
  final double? feelslike;
  final double? tempmin;
  final double? tempmax;
  final int? pressure;
  final int? humidity;
  Maincls({required this.feelslike,required this.humidity,required this.pressure,required this.temp,
  required this.tempmax,required this.tempmin});
factory Maincls.fromJson(Map <String,dynamic> json){
  double? temp=json["temp"];
  double? feelslike=json["feels_like"];
  double? tempmin=json["twmp_min"];
  double? tempmax=json["temp_max"];
  int? pressure=json["pressure"];
  int? humidity=json["humidity"];
return Maincls(feelslike: feelslike, humidity: humidity, pressure: pressure, temp: temp, tempmax: tempmax, tempmin: tempmin);

}
}

class Wind{
  final double speed;
  final dynamic deg;
  final double? gust;
  Wind({required this.deg,required this.gust,required this.speed});
  factory Wind.fromJson(Map <String,dynamic> json){
    double speed=json["speed"] as double;
    dynamic deg=json["deg"] ;
    double? gust=json["gust"];
    return Wind(deg: deg, gust: gust, speed: speed);

  }
}
class Clouds{
  final int all;
  Clouds({required this.all});
  factory Clouds.fromJson(Map<String,dynamic> json){
    int all=json["all"];
    return Clouds(all: all);
  }
}
class System{
  final String country;
  final DateTime sunrise;
  final DateTime sunset;
  System({required this.country,required this.sunrise,required this.sunset});
  factory System.fromJson(Map <String,dynamic> json){
    String country=json["country"];
    DateTime sunrise=DateTime.fromMillisecondsSinceEpoch(json["sunrise"]);
    DateTime sunset=DateTime.fromMillisecondsSinceEpoch(json["sunset"]);
    return System(country: country, sunrise: sunrise, sunset: sunset);
  }
}