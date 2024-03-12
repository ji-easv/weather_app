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

  WeeklyForecastDto({this.latitude, this.longitude, this.generationtimeMs, this.utcOffsetSeconds, this.timezone, this.timezoneAbbreviation, this.elevation, this.dailyUnits, this.daily});

  WeeklyForecastDto.fromJson(Map<String, dynamic> json) {
    latitude = (json["latitude"] as num).toDouble();
    longitude = (json["longitude"] as num).toDouble();
    generationtimeMs = (json["generationtime_ms"] as num).toDouble();
    utcOffsetSeconds = (json["utc_offset_seconds"] as num).toInt();
    timezone = json["timezone"];
    timezoneAbbreviation = json["timezone_abbreviation"];
    elevation = (json["elevation"] as num).toInt();
    dailyUnits = json["daily_units"] == null ? null : DailyUnits.fromJson(json["daily_units"]);
    daily = json["daily"] == null ? null : Daily.fromJson(json["daily"]);
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
    if(dailyUnits != null) {
      _data["daily_units"] = dailyUnits?.toJson();
    }
    if(daily != null) {
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

  Daily({this.time, this.weatherCode, this.temperature2MMax, this.temperature2MMin});

  Daily.fromJson(Map<String, dynamic> json) {
    time = json["time"] == null ? null : List<String>.from(json["time"]);
    weatherCode = json["weather_code"] == null ? null : List<int>.from(json["weather_code"]);
    temperature2MMax = json["temperature_2m_max"] == null ? null : List<double>.from(json["temperature_2m_max"]);
    temperature2MMin = json["temperature_2m_min"] == null ? null : List<double>.from(json["temperature_2m_min"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(time != null) {
      _data["time"] = time;
    }
    if(weatherCode != null) {
      _data["weather_code"] = weatherCode;
    }
    if(temperature2MMax != null) {
      _data["temperature_2m_max"] = temperature2MMax;
    }
    if(temperature2MMin != null) {
      _data["temperature_2m_min"] = temperature2MMin;
    }
    return _data;
  }
}

class DailyUnits {
  String? time;
  String? weatherCode;
  String? temperature2MMax;
  String? temperature2MMin;

  DailyUnits({this.time, this.weatherCode, this.temperature2MMax, this.temperature2MMin});

  DailyUnits.fromJson(Map<String, dynamic> json) {
    time = json["time"];
    weatherCode = json["weather_code"];
    temperature2MMax = json["temperature_2m_max"];
    temperature2MMin = json["temperature_2m_min"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["time"] = time;
    _data["weather_code"] = weatherCode;
    _data["temperature_2m_max"] = temperature2MMax;
    _data["temperature_2m_min"] = temperature2MMin;
    return _data;
  }
}

// 0 	Clear sky
// 1, 2, 3 	Mainly clear, partly cloudy, and overcast
// 45, 48 	Fog and depositing rime fog
// 51, 53, 55 	Drizzle: Light, moderate, and dense intensity
// 56, 57 	Freezing Drizzle: Light and dense intensity
// 61, 63, 65 	Rain: Slight, moderate and heavy intensity
// 66, 67 	Freezing Rain: Light and heavy intensity
// 71, 73, 75 	Snow fall: Slight, moderate, and heavy intensity
// 77 	Snow grains
// 80, 81, 82 	Rain showers: Slight, moderate, and violent
// 85, 86 	Snow showers slight and heavy
// 95 * 	Thunderstorm: Slight or moderate
// 96, 99 * 	Thunderstorm with slight and heavy hail
enum WeatherCode {
  clearSky(0, 'Clear sky'),

  mainlyClear(1, 'Mainly clear'),
  partlyCloudy(2, 'Partly cloudy'),
  overcast(3, 'Overcast'),

  fog(45, 'Fog'),
  depositingRimeFog(48, 'Depositing rime fog'),

  drizzleLight(51, 'Drizzle: Light intensity'),
  drizzleModerate(53, 'Drizzle: Moderate intensity'),
  drizzleDense(55, 'Drizzle: Dense intensity'),

  freezingDrizzleLight(56, 'Freezing Drizzle: Light intensity'),
  freezingDrizzleDense(57, 'Freezing Drizzle: dense intensity'),

  rainSlight(61, 'Rain: Slight intensity'),
  rainModerate(63, 'Rain: Moderate intensity'),
  rainHeavy(65, 'Rain: Heavy intensity'),

  freezingRainLight(66, 'Freezing Rain: Light intensity'),
  freezingRainHeavy(66, 'Freezing Rain: Heavy intensity'),

  snowFallSlight(71, 'Snow fall: Slight intensity'),
  snowFallModerate(73, 'Snow fall: Moderate intensity'),
  snowFallHeavy(75, 'Snow fall: Heavy intensity'),

  snowGrains(77, 'Snow grains'),

  rainShowersSlight(80, 'Rain showers: Slight'),
  rainShowersModerate(81, 'Rain showers: Moderate'),
  rainShowersVoilent(82, 'Rain showers: Violent'),

  snowShowersSlight(85, 'Snow showers: Slight'),
  snowShowersHeavy(86, 'Snow showers: Heavy'),

  thunerstorm(95, 'Thunderstorm: Slight or moderate'),
  thunderstormSlightHail(96, 'Thunderstorm with slight hail'),
  thunderstormHeavyHail(99, 'Thunderstorm with heavy hail'),
  ;

  final int value;
  final String description;
  const WeatherCode(this.value, this.description);

  factory WeatherCode.fromInt(int value) {
    return WeatherCode.values.singleWhere((code) => code.value == value);
  }
}

/// Holds the same data as as response from Open-Meteo, but in a form that makes
/// it simpler to use in charts.
class WeatherChartData {
  /// Hourly Weather Variables
  final List<TimeSeriesVariable>? hourly;

  /// Daily Weather Variables
  final List<TimeSeriesVariable>? daily;

  WeatherChartData({this.hourly, this.daily});

  static WeatherChartData fromJson(Map<String, dynamic> json) =>
      WeatherDataConverter.convert(json);
}

/// A measure that changes over time
class TimeSeriesVariable {
  final String name;
  final String? unit;
  final List<TimeSeriesDatum> values;

  TimeSeriesVariable({required this.name, this.unit, required this.values});
}

/// A single point
class TimeSeriesDatum {
  final DateTime domain;
  final num measure;

  TimeSeriesDatum({required this.domain, required this.measure});
}

const _kTime = 'time';
const _kHourly = 'hourly';
const _kDaily = 'daily';
const _kUnits = 'units';

class WeatherDataConverter {
  static WeatherChartData convert(Map<String, dynamic> json) {
    return WeatherChartData(
      daily: convertGroup(json, group: _kDaily),
      hourly: convertGroup(json, group: _kHourly),
    );
  }

  static List<TimeSeriesVariable>? convertGroup(Map<String, dynamic> json,
      {required String group}) {
    if (!json.containsKey(group)) return null;

    // Find out what variables exist the group.
    final variables =
    (json[group] as Map<String, dynamic>).keys.where((key) => key != _kTime);

    return variables
        .map((variable) =>
    convertVariable(json, group: group, variable: variable)!)
        .toList();
  }

  static TimeSeriesVariable? convertVariable(Map<String, dynamic> json,
      {required String group, required String variable}) {
    if (!json.containsKey(group)) return null;

    // Find unit for variable
    final unit = json['${group}_$_kUnits']?[variable];

    // A data point is the value of variable at a specific point in time
    final values = List.generate(
      (json[group][_kTime] as List).length,
          (index) => TimeSeriesDatum(
        domain: DateTime.parse(json[group][_kTime][index]),
        measure: json[group][variable][index],
      ),
    );

    return TimeSeriesVariable(name: variable, unit: unit, values: values);
  }
}

