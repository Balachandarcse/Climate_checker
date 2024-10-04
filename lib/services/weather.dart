import 'package:climate_checker/services/location.dart';
import 'package:climate_checker/services/network.dart';
const api='6c3f6dd00d0974d481c9e78f4b913ec2';
const openweather='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {

  Future<dynamic> GetCityWeather(String cityName) async{
    var url ='$openweather?q=$cityName&appid=$api&units=metric';
    NetworkData networkd=NetworkData(url);
    var weatherdata=await networkd.getdata();
    return weatherdata;
  }

  Future<dynamic> getlocation() async{
    Location loc=Location();
    await loc.getLocation();
    NetworkData networkd=NetworkData('$openweather?'
        'lat=${loc.latitude}&lon=${loc.longitude}&appid=$api&units=metric');
    var data=await networkd.getdata();
    return data;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
