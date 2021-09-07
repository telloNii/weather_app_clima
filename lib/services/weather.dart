import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'location.dart';
import 'network.dart';

String openWeatherApiKey = 'a9311ac361b7a305493c6a08df9b9fad';
String openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    var url =
        '$openWeatherURL?q=$cityName&appid=$openWeatherApiKey&units=metric';
    Network cityNetwork = Network(url: url);
    var cityWeatherData = await cityNetwork.networkHelp();
    return cityWeatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    Network network = Network(
      url:
          '$openWeatherURL?lat=${location.latitude}&lon=${location.longitude}&appid=$openWeatherApiKey&units=metric',
    );
    var weatherData = await network.networkHelp();
    return weatherData;
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

  BoxDecoration getBackgroundImage(condition) {
    if (condition < 300) {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/thunderstorm background wallpaper.jfif"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    } else if (condition < 400) {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/rainy background wallpaper.jpg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    } else if (condition < 600) {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/rainy background wallpaper.jpg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    } else if (condition < 700) {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/snowy background wallpaper.jfif"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    } else if (condition < 800) {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/misty background wallpaper"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    } else if (condition == 800) {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/sunny weather wallpaper.jfif"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    } else if (condition <= 804) {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Cloud-iPhone-Wallpaper-1.jpg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
    } else {
      return BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/location_background.jpg"),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), BlendMode.dstATop),
        ),
      );
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
