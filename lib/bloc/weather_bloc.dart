import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      // TODO: implement even t handler
      emit(WeatherLoading());
      try {
        double latitude = event.position.latitude;
        double longitude = event.position.longitude;
        var endpoint = Uri.parse(
          "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$latitude,$longitude?unitGroup=metric&key=RKAWB4X42UJY5CADRFX2NVVV9&contentType=json&iconSet=icons2",
        );
        var response = await http.get(endpoint);
        var body = jsonDecode(response.body);

        Weather weather = Weather.fromCurrent(body, DateTime.now().hour);
        List<Weather> weatherHoursList = Weather.perDefault()
            .hoursForecastWeather(body, DateTime.now().hour);
        List<Weather> weatherDaysList =
            Weather.perDefault().daysForecastWeather(body);

        emit(WeatherSucces(weather, weatherHoursList, weatherDaysList));
      } catch (e) {
        print(e);
        WeatherFailure();
      }
    });
  }
}
