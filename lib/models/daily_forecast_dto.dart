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

  DailyForecastDto({this.latitude, this.longitude, this.generationtimeMs, this.utcOffsetSeconds, this.timezone, this.timezoneAbbreviation, this.elevation, this.hourlyUnits, this.hourly});

  DailyForecastDto.fromJson(Map<String, dynamic> json) {
    latitude = (json["latitude"] as num).toDouble();
    longitude = (json["longitude"] as num).toDouble();
    generationtimeMs = (json["generationtime_ms"] as num).toDouble();
    utcOffsetSeconds = (json["utc_offset_seconds"] as num).toInt();
    timezone = json["timezone"];
    timezoneAbbreviation = json["timezone_abbreviation"];
    elevation = (json["elevation"] as num).toInt();
    hourlyUnits = json["hourly_units"] == null ? null : HourlyUnits.fromJson(json["hourly_units"]);
    hourly = json["hourly"] == null ? null : Hourly.fromJson(json["hourly"]);
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
    if(hourlyUnits != null) {
      _data["hourly_units"] = hourlyUnits?.toJson();
    }
    if(hourly != null) {
      _data["hourly"] = hourly?.toJson();
    }
    return _data;
  }
}

class Hourly {
  List<String>? time;
  List<double>? temperature2M;
  List<int>? relativeHumidity2M;
  List<double>? apparentTemperature;
  List<int>? precipitationProbability;
  List<int>? precipitation;
  List<int>? weatherCode;
  List<int>? visibility;
  List<double>? windSpeed10M;
  List<double>? windGusts10M;

  Hourly({this.time, this.temperature2M, this.relativeHumidity2M, this.apparentTemperature, this.precipitationProbability, this.precipitation, this.weatherCode, this.visibility, this.windSpeed10M, this.windGusts10M});

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    temperature2M = json["temperature_2m"] == null ? null : List<double>.from(json["temperature_2m"]);
    relativeHumidity2M = json["relative_humidity_2m"] == null ? null : List<int>.from(json["relative_humidity_2m"]);
    apparentTemperature = json["apparent_temperature"] == null ? null : List<double>.from(json["apparent_temperature"]);
    precipitationProbability = json["precipitation_probability"] == null ? null : List<int>.from(json["precipitation_probability"]);
    precipitation = json["precipitation"] == null ? null : List<int>.from(json["precipitation"]);
    weatherCode = json["weather_code"] == null ? null : List<int>.from(json["weather_code"]);
    visibility = json["visibility"] == null ? null : List<int>.from(json["visibility"]);
    windSpeed10M = json["wind_speed_10m"] == null ? null : List<double>.from(json["wind_speed_10m"]);
    windGusts10M = json["wind_gusts_10m"] == null ? null : List<double>.from(json["wind_gusts_10m"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(time != null) {
      _data["time"] = time;
    }
    if(temperature2M != null) {
      _data["temperature_2m"] = temperature2M;
    }
    if(relativeHumidity2M != null) {
      _data["relative_humidity_2m"] = relativeHumidity2M;
    }
    if(apparentTemperature != null) {
      _data["apparent_temperature"] = apparentTemperature;
    }
    if(precipitationProbability != null) {
      _data["precipitation_probability"] = precipitationProbability;
    }
    if(precipitation != null) {
      _data["precipitation"] = precipitation;
    }
    if(weatherCode != null) {
      _data["weather_code"] = weatherCode;
    }
    if(visibility != null) {
      _data["visibility"] = visibility;
    }
    if(windSpeed10M != null) {
      _data["wind_speed_10m"] = windSpeed10M;
    }
    if(windGusts10M != null) {
      _data["wind_gusts_10m"] = windGusts10M;
    }
    return _data;
  }
}

class HourlyUnits {
  String? time;
  String? temperature2M;
  String? relativeHumidity2M;
  String? apparentTemperature;
  String? precipitationProbability;
  String? precipitation;
  String? weatherCode;
  String? visibility;
  String? windSpeed10M;
  String? windGusts10M;

  HourlyUnits({this.time, this.temperature2M, this.relativeHumidity2M, this.apparentTemperature, this.precipitationProbability, this.precipitation, this.weatherCode, this.visibility, this.windSpeed10M, this.windGusts10M});

  HourlyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    temperature2M = json["temperature_2m"];
    relativeHumidity2M = json["relative_humidity_2m"];
    apparentTemperature = json["apparent_temperature"];
    precipitationProbability = json["precipitation_probability"];
    precipitation = json["precipitation"];
    weatherCode = json["weather_code"];
    visibility = json["visibility"];
    windSpeed10M = json["wind_speed_10m"];
    windGusts10M = json["wind_gusts_10m"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["temperature_2m"] = temperature2M;
    _data["relative_humidity_2m"] = relativeHumidity2M;
    _data["apparent_temperature"] = apparentTemperature;
    _data["precipitation_probability"] = precipitationProbability;
    _data["precipitation"] = precipitation;
    _data["weather_code"] = weatherCode;
    _data["visibility"] = visibility;
    _data["wind_speed_10m"] = windSpeed10M;
    _data["wind_gusts_10m"] = windGusts10M;
    return _data;
  }
}