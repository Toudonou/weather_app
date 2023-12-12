import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> days_of_week = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return Scaffold(
      backgroundColor: Constants.darkBackground,
      body: FutureBuilder(
          future: _determinePosition(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(snapshot.data as Position),
                color: Constants.onDark,
                backgroundColor: Constants.darkBackground,
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherSucces) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: Constants.defaultPadding,
                            left: Constants.defaultPadding,
                            top: Constants.defaultPadding * 2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  /*Constants().iconButton(
                                    FontAwesomeIcons.bars,
                                    () {
                                      return null;
                                    },
                                  ),*/
                                  Expanded(
                                    child: Constants().text(
                                      "${days_of_week[DateTime.now().weekday - 1]} ${DateTime.now().day}, ${months[DateTime.now().month - 1].substring(0, 3)}",
                                      18,
                                    ),
                                  ),
                                  /*Constants().iconButton(
                                    FontAwesomeIcons.gear,
                                    () {
                                      return null;
                                    },
                                  )*/
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Constants.cardOnDark,
                                  borderRadius: BorderRadius.circular(
                                      Constants.borderRaduis),
                                ),
                                padding: EdgeInsets.only(
                                  left: Constants.defaultPadding * 0.7,
                                  right: Constants.defaultPadding * 0.9,
                                  top: Constants.defaultPadding,
                                ),
                                height: 165,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Constants().text(
                                            days_of_week[
                                                DateTime.now().weekday - 1],
                                            12,
                                          ),
                                          Constants().text(
                                              "${state.weather.temp?.round()}°",
                                              50),
                                          Constants().text(
                                            "Feel like : ${state.weather.feelsLike?.round()}°",
                                            14,
                                          ),
                                          Constants().text("Calais", 20),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/${state.weather.icon}.png",
                                          scale: 0.9,
                                        ),
                                        const SizedBox(height: 10),
                                        Constants().text(
                                          state.weather.condition.toString(),
                                          12,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  children: List.generate(
                                    state.hoursForecastWeather.length,
                                    (index) => Container(
                                      decoration: BoxDecoration(
                                        color: Constants.cardOnDark,
                                        borderRadius: BorderRadius.circular(
                                          Constants.borderRaduis,
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        left: 0,
                                        top: Constants.defaultPadding * 0.3,
                                      ),
                                      margin: EdgeInsets.only(
                                        right: Constants.defaultPadding * 0.5,
                                      ),
                                      height: 120,
                                      width: 75,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Constants().text(
                                              state.hoursForecastWeather[index]
                                                  .datetime
                                                  .toString()
                                                  .substring(0, 5),
                                              10),
                                          Image.asset(
                                            scale: 1.7,
                                            "assets/images/${state.hoursForecastWeather[index].icon}.png",
                                          ),
                                          Constants().text(
                                            " ${state.hoursForecastWeather[index].temp}°",
                                            20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Constants.cardOnDark,
                                  borderRadius: BorderRadius.circular(
                                      Constants.borderRaduis),
                                ),
                                height: 60,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Constants().text(
                                      "Sunrise ☀ ${state.weather.sunrise?.substring(0, 5)}",
                                      17,
                                    ),
                                    Constants().text(
                                      "Sunset 🌙 ${state.weather.sunset?.substring(0, 5)}",
                                      17,
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Constants.cardOnDark,
                                  borderRadius: BorderRadius.circular(
                                      Constants.borderRaduis),
                                ),
                                padding: EdgeInsets.only(
                                  left: Constants.defaultPadding * 0.7,
                                  right: Constants.defaultPadding * 0.9,
                                  top: 8,
                                ),
                                height: 75,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Constants().text("Wind Speed", 10),
                                        Constants().text(
                                          "${state.weather.windSpeed?.round()}km/h",
                                          25,
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Constants().text("Humidity", 10),
                                        Constants().text(
                                          "${state.weather.humidity?.round()}%",
                                          25,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Constants.cardOnDark,
                                  borderRadius: BorderRadius.circular(
                                      Constants.borderRaduis),
                                ),
                                padding: EdgeInsets.only(
                                  left: Constants.defaultPadding * 0.7,
                                  right: Constants.defaultPadding * 0.2,
                                  //top: Constants.defaultPadding * 0.5,
                                ),
                                width: double.infinity,
                                child: Column(
                                  children: List.generate(
                                    state.daysForecastWeather.length * 2,
                                    (index) {
                                      if (index % 2 == 1) {
                                        index = index ~/ 2;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Constants().text(
                                                  "${(
                                                    DateTime.now()
                                                        .add(
                                                          Duration(days: index),
                                                        )
                                                        .day,
                                                  ).toString().substring(1, 3)}/${DateTime.now().add(
                                                        Duration(days: index),
                                                      ).month} ",
                                                  10,
                                                ),
                                                Constants().text(
                                                  index == 0
                                                      ? "Today"
                                                      : days_of_week[DateTime
                                                                      .now()
                                                                  .add(Duration(
                                                                      days:
                                                                          index))
                                                                  .weekday -
                                                              1]
                                                          .substring(0, 3),
                                                  10,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                width: index == 0 ? 18 : 25),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  "assets/images/${state.daysForecastWeather[index].icon}.png",
                                                  alignment:
                                                      Alignment.topCenter,
                                                  scale: 2.5,
                                                ),
                                                Constants().text(
                                                    " ${state.daysForecastWeather[index].condition}",
                                                    10),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Constants().text(
                                                    "${state.daysForecastWeather[index].tempMax! < 10 ? " ${state.daysForecastWeather[index].tempMax}" : state.daysForecastWeather[index].tempMax}° ",
                                                    10),
                                                Constants().text(
                                                    "${state.daysForecastWeather[index].tempMin! < 10 ? " ${state.daysForecastWeather[index].tempMin}" : state.daysForecastWeather[index].tempMin}° ",
                                                    10),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        );
                                      } else {
                                        return const SizedBox(height: 20);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return problemContainer();
                    }
                  },
                ),
              );
            } else {
              return problemContainer();
            }
          }),
    );
  }

  Container problemContainer() {
    return Container(
      color: Constants.darkBackground,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Constants.onDark,
              backgroundColor: Constants.darkBackground,
            ),
            //Constants().text("Something goes wrong", 20),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh(Position snapshot) async {
    BlocProvider.of<WeatherBloc>(context).add(
      FetchWeather(snapshot),
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
