import 'package:clima_app/components/details_widget.dart';
import 'package:clima_app/components/error_message.dart';
import 'package:clima_app/components/loading_widget.dart';
import 'package:clima_app/models/weather_model.dart';
import 'package:clima_app/services/weather.dart';
import 'package:clima_app/utilties/constants.dart';
import 'package:clima_app/utilties/weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDataLoaded = false;
  bool isErrorOccured = false;
  double? latitude, longitude;

  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;
  WeatherModel? weatherModel;
  int code = 0;
  Weather weather = Weather();
  var weatherData;
  String? title, message;

  @override
  initState() {
    super.initState();
    getPermission();
  }

  void getPermission() async {
    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      print('permission denied');
      permission = await geolocatorPlatform.requestPermission();
      if (permission != LocationPermission.denied) {
        if (permission == LocationPermission.deniedForever) {
          print('permission permanently denied');
          setState(() {
            isDataLoaded = true;
            isErrorOccured = true;
            title = 'premission permanently denied';
            message =
                'please provide permission to the app from device settings';
          });
        } else {
          print('Permission granted');
          updataUI();
        }
      } else {
        print('User denied the request');
        updataUI();
      }
    } else {
      updataUI();
    }
  }

  void updataUI({String? cityName}) async {
    weatherData = null;

    if (cityName == null || cityName == '') {
      if (!await geolocatorPlatform.isLocationServiceEnabled()) {
        setState(() {
          isErrorOccured = true;
          isDataLoaded = true;
          title = 'Location is turned off';
          message = 'Please Enable the Location';
          return;
        });
      }
      weatherData = await weather.getLocationWeather();
    } else {
      weatherData = await weather.getCityWeather(cityName);
    }

    if (weatherData == null) {
      setState(() {
        title = 'City not found';
        message = 'please make sure you have entered the right city name';
        isDataLoaded = true;
        isErrorOccured = true;
        return;
      });
    }

    code = weatherData['weather'][0]['id'];
    weatherModel = WeatherModel(
      location: weatherData['name'] + weatherData['sys']['country'],
      description: weatherData['weather'][0]['description'],
      temperature: weatherData['main']['temp'],
      feelsLike: weatherData['main']['feels_like'],
      humidity: weatherData['main']['humidity'],
      wind: weatherData['wind']['speed'],
      icon:
          'assets/weather_icons/${getIconPrefix(code)}${kWeatherIcons[code.toString()]!['icon']}.svg',
    );

    setState(() {
      isDataLoaded = true;
      isDataLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      return const LoadingWidget();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kOverlayColor,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        decoration: kTextFieldDecoration,
                        onSubmitted: (String typedName) {
                          setState(() {
                            isDataLoaded = false;
                            updataUI(cityName: typedName);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isDataLoaded = false;
                              getPermission();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white12,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SizedBox(
                            height: 60,
                            child: Row(
                              children: const [
                                Text(
                                  'My Location',
                                  style: kTextFieldTextStyle,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.gps_fixed,
                                  color: Colors.white60,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              isErrorOccured
                  ? ErrorMessage(title: title!, message: message!)
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_city,
                                color: kMidLightColor,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                weatherModel!.location!,
                                style: kLocationTextStyle,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          SvgPicture.asset(
                            weatherModel!.icon!,
                            height: 280,
                            color: kLightColor,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            '${weatherModel!.temperature!.round()}°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherModel!.description!.toUpperCase(),
                            style: kLocationTextStyle,
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: kOverlayColor,
                  child: SizedBox(
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DetailsWidget(
                            title: 'FEELS LIKE',
                            value:
                                '${weatherModel != null ? weatherModel!.feelsLike!.round() : 0}°'),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        DetailsWidget(
                            title: 'HUMIDITY',
                            value:
                                '${weatherModel != null ? weatherModel!.humidity! : 0}%'),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        DetailsWidget(
                            title: 'WIND',
                            value:
                                '${weatherModel != null ? weatherModel!.wind!.round() : 0}'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
