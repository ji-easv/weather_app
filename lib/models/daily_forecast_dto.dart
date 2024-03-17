class DailyForecastDto {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  int? elevation;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;
  List<ForecastForOneHour> forecastForOneHourList = [];

  DailyForecastDto(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.hourlyUnits,
      this.hourly});

  DailyForecastDto.fromJson(Map<String, dynamic> json) {
    latitude = (json["latitude"] as num).toDouble();
    longitude = (json["longitude"] as num).toDouble();
    generationtimeMs = (json["generationtime_ms"] as num).toDouble();
    utcOffsetSeconds = (json["utc_offset_seconds"] as num).toInt();
    timezone = json["timezone"];
    timezoneAbbreviation = json["timezone_abbreviation"];
    elevation = (json["elevation"] as num).toInt();
    hourlyUnits = json["hourly_units"] == null
        ? null
        : HourlyUnits.fromJson(json["hourly_units"]);
    hourly = json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]);

    for (int i = 0; i < hourly!.time!.length; i++) {
      forecastForOneHourList.add(ForecastForOneHour.fromHourly(hourly!, i));
    }
    print(forecastForOneHourList.length);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    _data["generationtime_ms"] = generationtimeMs;
    _data["utc_offset_seconds"] = utcOffsetSeconds;
    _data["timezone"] = timezone;
    _data["timezone_abbreviation"] = timezoneAbbreviation;
    _data["elevation"] = elevation;
    if (hourlyUnits != null) {
      _data["hourly_units"] = hourlyUnits?.toJson();
    }
    if (hourly != null) {
      _data["hourly"] = hourly?.toJson();
    }
    return _data;
  }
}

class Hourly {
  List<String>? time;
  List<double>? temperature2M;
  List<int>? precipitationProbability;
  List<int>? weatherCode;
  List<double>? windSpeed10M;

  Hourly(
      {this.time,
      this.temperature2M,
      this.precipitationProbability,
      this.weatherCode,
      this.windSpeed10M});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    temperature2M = json["temperature_2m"] == null
        ? null
        : List<double>.from(json["temperature_2m"]);
    precipitationProbability = json["precipitation_probability"] == null
        ? null
        : List<int>.from(json["precipitation_probability"]);
    weatherCode = json["weather_code"] == null
        ? null
        : List<int>.from(json["weather_code"]);
    windSpeed10M = json["wind_speed_10m"] == null
        ? null
        : List<double>.from(json["wind_speed_10m"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (time != null) {
      _data["time"] = time;
    }
    if (temperature2M != null) {
      _data["temperature_2m"] = temperature2M;
    }
    if (precipitationProbability != null) {
      _data["precipitation_probability"] = precipitationProbability;
    }
    if (weatherCode != null) {
      _data["weather_code"] = weatherCode;
    }
    if (windSpeed10M != null) {
      _data["wind_speed_10m"] = windSpeed10M;
    }
    return _data;
  }
}

class HourlyUnits {
  String? time;
  String? temperature2M;
  String? precipitationProbability;
  String? weatherCode;
  String? windSpeed10M;

  HourlyUnits(
      {this.time,
      this.temperature2M,
      this.precipitationProbability,
      this.weatherCode,
      this.windSpeed10M});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    temperature2M = json["temperature_2m"];
    precipitationProbability = json["precipitation_probability"];
    weatherCode = json["weather_code"];
    windSpeed10M = json["wind_speed_10m"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["temperature_2m"] = temperature2M;
    _data["precipitation_probability"] = precipitationProbability;
    _data["weather_code"] = weatherCode;
    _data["wind_speed_10m"] = windSpeed10M;
    return _data;
  }
}

class ForecastForOneHour {
  String? time;
  double? temperature2M;
  int? precipitationProbability;
  int? weatherCode;
  double? windSpeed10M;

  ForecastForOneHour(
      {this.time,
      this.temperature2M,
      this.precipitationProbability,
      this.weatherCode,
      this.windSpeed10M});

  static fromHourly(Hourly hourly, int index) {
    return ForecastForOneHour(
        time: hourly.time!.elementAt(index),
        temperature2M: hourly.temperature2M!.elementAt(index),
        precipitationProbability:
            hourly.precipitationProbability!.elementAt(index),
        weatherCode: hourly.weatherCode!.elementAt(index),
        windSpeed10M: hourly.windSpeed10M!.elementAt(index));
  }
}
