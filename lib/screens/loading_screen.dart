import 'package:flutter/material.dart';
import 'package:climate_checker/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:climate_checker/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  void initState()
  {
    super.initState();
    getloc();
  }
  void getloc() async {
    var data=await WeatherModel().getlocation();
    Navigator.push(context, MaterialPageRoute(builder: (context)
    {
      return LocationScreen(weatherdata:data);
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.green,
        size: 110.0,
      )
    );
  }
}
