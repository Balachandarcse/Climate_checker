import 'package:flutter/material.dart';
import 'package:climate_checker/utilities/constants.dart';
import 'package:climate_checker/services/weather.dart';
import 'package:climate_checker/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherdata});
  final weatherdata;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather =WeatherModel();
  var temperature;
  var weatherIcon;
  var weatherMsg;
  var name;
  void initState()
  {
    super.initState();
    updatedUi(widget.weatherdata);
  }
void updatedUi(dynamic data)
{
  setState(() {
    if (data == null) {
      temperature = 0;
      weatherIcon = 'Error';
      weatherMsg = 'Unable to get weather data';
      name = '';
      return;
    }
  double temp=data['main']['temp'];
  temperature=temp.toInt();
  var condition=data['weather'][0]['id'];
  weatherIcon=weather.getWeatherIcon(condition);
  weatherMsg=weather.getMessage(temperature);
  name=data['name'];
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/w2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherdata=await weather.getlocation();
                      updatedUi(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityname=await Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return CityScreen();
                      },
                      ),
                      );
                      var weatherdata=await weather.GetCityWeather(cityname);
                      updatedUi(weatherdata);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMsg in $name!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



