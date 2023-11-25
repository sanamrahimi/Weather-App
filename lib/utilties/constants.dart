import 'package:flutter/material.dart';

const apiKey = "f1c69203284901646a7678aadcfe779a";

const openWeatherMapUrl = "https://api.openweathermap.org/data/2.5/weather";

const kLightColor = Colors.white;

const kMidLightColor = Colors.white60;

const kOverlayColor = Colors.white10;

const kDarkColor = Colors.white24;

const kTextFieldTextStyle = TextStyle(fontSize: 16, color: kMidLightColor);

const kLocationTextStyle = TextStyle(fontSize: 20, color: kMidLightColor);

const kTempTextStyle = TextStyle(fontSize: 80);

const kDetailsTextStyle =
    TextStyle(fontSize: 20, color: kMidLightColor, fontWeight: FontWeight.bold);

const kDetailsTitleTextStyle = TextStyle(
  fontSize: 16,
  color: kDarkColor,
);

const kDetailsSuffixTextStyle = TextStyle(
  fontSize: 12,
  color: kMidLightColor,
);

const kTextFieldDecoration = InputDecoration(
    fillColor: kOverlayColor,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ),
    hintText: 'Enter City Name',
    hintStyle: kTextFieldTextStyle,
    prefixIcon: Icon(Icons.search));
