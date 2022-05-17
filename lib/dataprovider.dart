

import 'package:flutter/material.dart';

import './main.dart';
import './data.dart';
class DataProvider extends ChangeNotifier{
  
      DataModel? dt;

    // Future<DataModel> get DataLoaded async{
    //       return dt;
    // }
   bool cnf=false;
   bool err=false;
   String h="hello";
   bool loading=true;
   bool lper=false;
  
 getData()async{
  try{
     loading=true;
     err=false;
     lper=false;
     dt= await dataCalling();

     
      loading=false;
     notifyListeners();
     
     }catch(e){
       loading=false;
       if(e==101){
       err=true;
      }
      if(e==103){
         lper=true;
         loading=true;
         notifyListeners();
       
        
      }
     
      
       
  }

     }
 
     getData2(String city)async{
       try{
       loading=true;
       
       dt=await searchByCity(city);
       loading=false;
       notifyListeners();
       }catch(e){
         cnf=true;
         loading=false;
       
         notifyListeners();
         cnf=false;
                }}
   
   

  }
   
  
    
  

  
