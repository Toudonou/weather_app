import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Constants.darkBackground,
      systemNavigationBarDividerColor: Constants.darkBackground,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc()
                ..add(
                  FetchWeather(
                    snapshot.data as Position,
                  ),
                ),
              child: const HomeScreen(),
            );
          } else {
            return Container(
              color: Constants.darkBackground,
              child: Center(
                child: CircularProgressIndicator(
                  color: Constants.onDark,
                  backgroundColor: Constants.darkBackground,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
