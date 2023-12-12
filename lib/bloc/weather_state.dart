part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSucces extends WeatherState {
  final Weather weather;
  final List<Weather> hoursForecastWeather;
  final List<Weather> daysForecastWeather;
  const WeatherSucces(
      this.weather, this.hoursForecastWeather, this.daysForecastWeather);

  @override
  List<Object> get props => [weather, hoursForecastWeather];
}

final class WeatherFailure extends WeatherState {}
