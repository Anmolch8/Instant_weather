import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/dataprovider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void errors() {
    if (mounted) {
      bool cnf = Provider.of<DataProvider>(context, listen: false).cnf;

      if (cnf == true) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[600],
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.error),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text("city not found"))),
                ],
              ),
            ),
          );
      }
    }
  }

  final TextEditingController text1 = TextEditingController();
  @override
  void initState() {
    final data = Provider.of<DataProvider>(context, listen: false);

    data.getData();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DataProvider>(context, listen: false).addListener(errors);
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Consumer<DataProvider>(builder: (context, data, child) {
      if (data.err == true && data.loading == true) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const Text('no Internet connection'),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    icon: const Icon(Icons.redo_sharp))
              ],
            ),
          ),
        );
      }

      if (data.loading == true) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                data.lper == true
                    ? " Give location access to app or turn on  device location or set it manually from settings"
                    : "Loading Weather",
                style: TextStyle(
                    fontSize: _size.height / 20, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: data.lper == true
                    ? TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 135, 175, 209)),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: const Text("Try Again"))
                    : const CircularProgressIndicator(
                        color: Colors.blueGrey,
                        strokeWidth: 7,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black38,
                        )),
              )
            ],
          ),
        );
      }

      return Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
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
                          onTap: () {
                            data.getData2(text1.text);
                          },
                          child: Icon(
                            Icons.search,
                            size: _size.height / 25,
                          ),
                        ),
                        Expanded(
                            child: TextField(
                          controller: text1,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            data.getData2(value);
                          },
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
                        height: _size.height / 5.5,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.circular(_size.height / 50)),
                        padding: EdgeInsets.all(_size.width / 50),
                        margin: EdgeInsets.symmetric(
                            horizontal: _size.width / 35,
                            vertical: _size.height / 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                "http://openweathermap.org/img/wn/${data.dt?.weather.icon}@2x.png"),
                            SizedBox(
                              width: _size.width / 25,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data.dt!.weather.description.toString(),
                                  style: TextStyle(
                                      fontSize: _size.height / 29,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: _size.height / 50,
                                ),
                                Text(data.dt!.city.toString(),
                                    style: TextStyle(
                                        fontSize: _size.height / 34,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: _size.height / 3,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius:
                                  BorderRadius.circular(_size.height / 50)),
                          padding: EdgeInsets.all(_size.width / 20),
                          margin: EdgeInsets.symmetric(
                              horizontal: _size.width / 40,
                              vertical: _size.height / 45),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                WeatherIcons.thermometer,
                                color: Color.fromARGB(255, 166, 82, 76),
                              ),
                              SizedBox(
                                height: _size.height / 22,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data.dt!.maincl.temp.toString(),
                                    style:
                                        TextStyle(fontSize: _size.height / 9),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: _size.height / 25),
                                    child: Text(
                                      '℃',
                                      style: TextStyle(
                                          fontSize: _size.height / 16),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                            height: _size.height / 4.5,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius:
                                    BorderRadius.circular(_size.height / 50)),
                            padding: EdgeInsets.all(_size.width / 20),
                            margin: EdgeInsets.symmetric(
                                horizontal: _size.width / 35,
                                vertical: _size.height / 48),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      WeatherIcons.day_windy,
                                      color: Color.fromARGB(255, 100, 131, 157),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: _size.height / 50,
                                ),
                                Text(
                                  ((data.dt!.wind.speed) * 3.6)
                                      .ceil()
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: _size.height / 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Km/h',
                                  style: TextStyle(fontSize: _size.height / 50),
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            height: _size.height / 4.5,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius:
                                    BorderRadius.circular(_size.height / 50)),
                            padding: EdgeInsets.all(_size.width / 20),
                            margin: EdgeInsets.symmetric(
                                horizontal: _size.width / 35,
                                vertical: _size.height / 48),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      WeatherIcons.humidity,
                                      color: Color.fromARGB(255, 14, 41, 175),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: _size.height / 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.dt!.maincl.humidity.toString(),
                                      style: TextStyle(
                                          fontSize: _size.height / 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '%',
                                      style: TextStyle(
                                          fontSize: _size.height / 45,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }

  @override
  void dispose() {
    text1.dispose();
    super.dispose();
  }
}
