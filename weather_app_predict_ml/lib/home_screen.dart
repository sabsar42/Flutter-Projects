import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_predict_ml/data_key.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory _weatherFactory = WeatherFactory(openWeatherApiKey);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _weatherFactory.currentWeatherByCityName("Sylhet").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? " ",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: TextStyle(fontSize: 35),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now), // for weekdays
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              " ${DateFormat("dd.MM.yyyy").format(now)}", // for weekdays
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ],
        )
      ],
    );
  }

  Widget _weatherIcon() {
    final url =
        "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png";
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(url),
            ),
          ),
        ),
        Text(_weather?.weatherDescription ?? " ",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
                color: Colors.black54))
      ],
    );
  }

  Widget _currentTemp() {
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)} °C",
        style: TextStyle(
            fontSize: 80, fontWeight: FontWeight.w100, color: Colors.black));
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).height * 0.35,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all((8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  'Max Temp: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              Text(
                  'Min Temp: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              Text('Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))
            ],
          )
        ],
      ),
    );
  }
}
