import 'package:flutter/material.dart';

import './main.dart';
import './data.dart';
class DataProvider extends ChangeNotifier{
  
     late DataModel dt;

    // Future<DataModel> get DataLoaded async{
    //       return dt;
    // }
  
   bool err=false;
   String h="hello";
   bool loading=true;
  
 getData()async{
  try{
     loading=true;
     err=false;
     dt= await dataCalling();

     
      loading=false;
     notifyListeners();
     
     }catch(e){
       loading=false;
       if(e==101){
       err=true;}
       notifyListeners();
  }
  

     }
 
     getData2(String city)async{
       loading=true;
       dt=await searchByCity(city);
       loading=false;
       notifyListeners();
     }
   
   
   }
  
    
  

  
