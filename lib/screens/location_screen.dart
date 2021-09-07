import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app_clima/screens/city_screen.dart';
import '/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app_clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});
  late final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  late String city;
  late int temperature;
  late String weatherDescription;
  late String weatherIcon;
  late String weatherMessage;
  late BoxDecoration backgroundImage;
  @override
  void initState() {
    super.initState();
    updateFigures(widget.locationWeather);
  }

  void updateFigures(dynamic weatherData) {
    setState(
      () {
        if (weatherData == null) {
          temperature = 0;
          weatherIcon = 'Error';
          weatherMessage = 'Unable to get weather data';
          city = 'Location';
          backgroundImage = BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/sunny weather wallpaper.jfif"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          );
          return;
        }
        city = weatherData['name'];
        double temp = weatherData["main"]['temp'];
        temperature = temp.toInt();
        weatherDescription = weatherData["weather"][0]['description'];
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        weatherMessage = weatherModel.getMessage(temperature);
        backgroundImage = weatherModel.getBackgroundImage(condition);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundImage,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          var weatherData =
                              await weatherModel.getLocationWeather();
                          updateFigures(weatherData);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.locationArrow,
                          size: 35.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );
                          print(typedName);
                          if (typedName != null) {
                            var weatherData =
                                await weatherModel.getCityWeather(typedName);
                            updateFigures(weatherData);
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.city,
                          size: 35.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
                margin: EdgeInsets.only(left: 16.0, right: 16.0),
                decoration: BoxDecoration(
                  color: Color(0x44464658),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
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
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
                margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
                decoration: BoxDecoration(
                  color: Color(0x44464658),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$weatherMessage in $city!",
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
