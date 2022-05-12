import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/dataprovider.dart';
import 'package:weather_app/screens/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController text1 = TextEditingController();
  @override
  void initState() {
    final data = Provider.of<DataProvider>(context, listen: false);

    data.getData();

    print("initstae called");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build is called');

    //return Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blue,Color.fromARGB(255, 97, 182, 224)],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
    //   child: Scaffold(backgroundColor: Colors.transparent,
    // body: SafeArea(child: Container(padding: const EdgeInsets.only(top: 19,left: 13),
    return Scaffold(body: Consumer<DataProvider>(
      builder: (context, data, child) {
        if (data.err == true && data.loading == true) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Text('no Internet connection'),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      icon: Icon(Icons.redo_sharp))
                ],
              ),
            ),
          );
        }
        final _size = MediaQuery.of(context).size;
        return Scaffold(
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromARGB(255, 116, 151, 211),
                    Color.fromARGB(255, 194, 190, 190)
                  ],
                      stops: [
                    0.3,
                    0.6
                  ])),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: _size.height / 300,
                        horizontal: _size.width / 40),
                    margin: EdgeInsets.symmetric(
                        horizontal: _size.width / 35,
                        vertical: _size.height / 35),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(_size.width / 3)),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.search,
                            size: _size.height / 25,
                          ),
                        ),
                        Expanded(
                            child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Search by city",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: _size.height / 36),
                        ))
                      ],
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.circular(_size.height / 50)),
                        padding: EdgeInsets.all(_size.width / 9),
                        margin: EdgeInsets.symmetric(
                            horizontal: _size.width / 35,
                            vertical: _size.height / 500),
                        child:Row(children: [
                        //  Image.network("src")
                        Text("image"),
                          Column(
                            children: const [  Text(" weather",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),),
                          Text("city",style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)
                          )],
                          )
                        
                        ],),
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: _size.height/3,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius:
                                      BorderRadius.circular(_size.height / 50)),
                              padding: EdgeInsets.all(_size.width / 20),
                              margin: EdgeInsets.symmetric(
                                  horizontal: _size.width / 40,
                                  vertical: _size.height / 45),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.thermometer)
                                  ,Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('23',textScaleFactor: 10,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      
                                      Text('o',textScaleFactor: 3,),
                                      Padding(
                                        padding:  EdgeInsets.zero,
                                        child: Text('C',textScaleFactor: 4,),
                                      )
                                    ],)
                                    ],
                                  )
                                ],
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          height: _size.height/5,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.circular(_size.height / 50)),
                          padding: EdgeInsets.all(_size.width / 9),
                          margin: EdgeInsets.symmetric(
                              horizontal: _size.width / 35,
                              vertical: _size.height / 200),
                          child:const  Text('hello'),),
                      ),
                      Expanded(
                        child: Container(
                          height: _size.height/5,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.circular(_size.height / 50)),
                          padding: EdgeInsets.all(_size.width / 9),
                          margin: EdgeInsets.symmetric(
                              horizontal: _size.width / 35,
                              vertical: _size.height / 200),
                          child:const  Text('hello')),
                      )
                    ],
                  )
                ],
              
              ),
              
            ),
          ),
        );
      },
    ));

    //   return Scaffold(appBar: AppBar(
    //       title: const  Text("test"),
    //     ),body:Center(child:Consumer<DataProvider>(builder:(context, data, child) {
    //     //  return Text(data.loading==true?" ":data.dt.city.toString());

    //  //   final data=Provider.of<DataProvider>(context);
    //  return Consumer<DataProvider>(builder: (context, data, child) {

    //     if(data.err==true&&data.loading==true){
    //      return Scaffold(body: SafeArea(
    //        child: Column(
    //          children: [
    //             Text('no Internet connection'),
    //            IconButton(onPressed:(){ Navigator.pushReplacementNamed(context,'/');}, icon: Icon(Icons.redo_sharp))
    //          ],
    //        ),
    //      ),);

    //  }

    // //  if(data.err==false&& data.loading==false)
    //   {
    // return Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.blue,Color.fromARGB(255, 97, 182, 224)],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
    //   child: Scaffold(backgroundColor: Colors.transparent,
    //   body: SafeArea(child: Container(padding: const EdgeInsets.only(top: 19,left: 13),

    //   child:
    //   Row(mainAxisAlignment: MainAxisAlignment.start,

    //   children: [
    //     Expanded(child:TextField(controller: text1,style: const TextStyle(fontWeight: FontWeight.bold),decoration: InputDecoration(isDense: true,labelStyle: const TextStyle(color: Colors.black,fontSize: 20),labelText: 'Search city',focusedBorder:OutlineInputBorder(borderSide:const  BorderSide(color: Colors.black,width: 2.5),borderRadius: BorderRadius.circular(69.0) ),enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black,width: 2.5),
    //     borderRadius: BorderRadius.circular(69.0))))),
    //     IconButton(onPressed:() => data.getData2(text1.text),icon: Icon(Icons.search),iconSize: 40,)
    //   ,
    //   Text(data.dt.cord.lat.toString())
    //    ,
    //   ],),
    //   )

    //   ),
    //   ),
    // );
    //}
  }

  @override
  void dispose() {
    print('widget is disposed');
    text1.dispose();
    super.dispose();
  }
}
