class WeeklyForecastDto {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  int? elevation;
  DailyUnits? dailyUnits;
  Daily? daily;
  List<ForecastForOneDay> dailyForecast = [];

  WeeklyForecastDto(
      {this.latitude,
      this.longitude,
      this.generationtimeMs,
      this.utcOffsetSeconds,
      this.timezone,
      this.timezoneAbbreviation,
      this.elevation,
      this.dailyUnits,
      this.daily});

  WeeklyForecastDto.fromJson(Map<String, dynamic> json) {
    latitude = (json["latitude"] as num).toDouble();
    longitude = (json["longitude"] as num).toDouble();
    generationtimeMs = (json["generationtime_ms"] as num).toDouble();
    utcOffsetSeconds = (json["utc_offset_seconds"] as num).toInt();
    timezone = json["timezone"];
    timezoneAbbreviation = json["timezone_abbreviation"];
    elevation = (json["elevation"] as num).toInt();
    dailyUnits = json["daily_units"] == null
        ? null
        : DailyUnits.fromJson(json["daily_units"]);
    daily = json["daily"] == null ? null : Daily.fromJson(json["daily"]);

    for (int i = 0; i < daily!.time!.length; i++) {
      dailyForecast.add(ForecastForOneDay.fromDaily(daily!, i));
    }
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
    if (dailyUnits != null) {
      _data["daily_units"] = dailyUnits?.toJson();
    }
    if (daily != null) {
      _data["daily"] = daily?.toJson();
    }
    return _data;
  }
}

class Daily {
  List<String>? time;
  List<int>? weatherCode;
  List<double>? temperature2MMax;
  List<double>? temperature2MMin;
  List<String>? sunrise;
  List<String>? sunset;

  Daily(
      {this.time,
      this.weatherCode,
      this.temperature2MMax,
      this.temperature2MMin,
      this.sunrise,
      this.sunset});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    weatherCode = json["weather_code"] == null
        ? null
        : List<int>.from(json["weather_code"]);
    temperature2MMax = json["temperature_2m_max"] == null
        ? null
        : List<double>.from(json["temperature_2m_max"]);
    temperature2MMin = json["temperature_2m_min"] == null
        ? null
        : List<double>.from(json["temperature_2m_min"]);
    sunrise =
        json["sunrise"] == null ? null : List<String>.from(json["sunrise"]);
    sunset = json["sunset"] == null ? null : List<String>.from(json["sunset"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (time != null) {
      _data["time"] = time;
    }
    if (weatherCode != null) {
      _data["weather_code"] = weatherCode;
    }
    if (temperature2MMax != null) {
      _data["temperature_2m_max"] = temperature2MMax;
    }
    if (temperature2MMin != null) {
      _data["temperature_2m_min"] = temperature2MMin;
    }
    if (sunrise != null) {
      _data["sunrise"] = sunrise;
    }
    if (sunset != null) {
      _data["sunset"] = sunset;
    }
    return _data;
  }
}

class DailyUnits {
  String? time;
  String? weatherCode;
  String? temperature2MMax;
  String? temperature2MMin;
  String? sunrise;
  String? sunset;

  DailyUnits(
      {this.time,
      this.weatherCode,
      this.temperature2MMax,
      this.temperature2MMin,
      this.sunrise,
      this.sunset});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    weatherCode = json["weather_code"];
    temperature2MMax = json["temperature_2m_max"];
    temperature2MMin = json["temperature_2m_min"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["weather_code"] = weatherCode;
    _data["temperature_2m_max"] = temperature2MMax;
    _data["temperature_2m_min"] = temperature2MMin;
    _data["sunrise"] = sunrise;
    _data["sunset"] = sunset;
    return _data;
  }
}

class ForecastForOneDay {
  String? time;
  int? weatherCode;
  double? temperature2MMax;
  double? temperature2MMin;
  String? sunrise;
  String? sunset;

  ForecastForOneDay(
      {this.time,
      this.weatherCode,
      this.temperature2MMax,
      this.temperature2MMin,
      this.sunrise,
      this.sunset});

  static fromDaily(Daily daily, int index) {
    return ForecastForOneDay(
      time: daily.time!.elementAt(index),
      weatherCode: daily.weatherCode!.elementAt(index),
      temperature2MMax: daily.temperature2MMax!.elementAt(index),
      temperature2MMin: daily.temperature2MMin!.elementAt(index),
      sunrise: daily.sunrise!.elementAt(index),
      sunset: daily.sunset!.elementAt(index),
    );
  }
}
