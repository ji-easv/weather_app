
class CurrentWeatherDto {
    double? latitude;
    double? longitude;
    double? generationtimeMs;
    int? utcOffsetSeconds;
    String? timezone;
    String? timezoneAbbreviation;
    int? elevation;
    CurrentUnits? currentUnits;
    Current? current;

    CurrentWeatherDto({this.latitude, this.longitude, this.generationtimeMs, this.utcOffsetSeconds, this.timezone, this.timezoneAbbreviation, this.elevation, this.currentUnits, this.current});

    CurrentWeatherDto.fromJson(Map<String, dynamic> json) {
        latitude = (json["latitude"] as num).toDouble();
        longitude = (json["longitude"] as num).toDouble();
        generationtimeMs = (json["generationtime_ms"] as num).toDouble();
        utcOffsetSeconds = (json["utc_offset_seconds"] as num).toInt();
        timezone = json["timezone"];
        timezoneAbbreviation = json["timezone_abbreviation"];
        elevation = (json["elevation"] as num).toInt();
        currentUnits = json["current_units"] == null ? null : CurrentUnits.fromJson(json["current_units"]);
        current = json["current"] == null ? null : Current.fromJson(json["current"]);
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
        if(currentUnits != null) {
            _data["current_units"] = currentUnits?.toJson();
        }
        if(current != null) {
            _data["current"] = current?.toJson();
        }
        return _data;
    }
}

class Current {
    String? time;
    int? interval;
    double? temperature2M;
    int? relativeHumidity2M;
    int? precipitation;
    int? weatherCode;
    double? windSpeed10M;
    double? windGusts10M;

    Current({this.time, this.interval, this.temperature2M, this.relativeHumidity2M, this.precipitation, this.weatherCode, this.windSpeed10M, this.windGusts10M});

    Current.fromJson(Map<String, dynamic> json) {
        time = json["time"];
        interval = (json["interval"] as num).toInt();
        temperature2M = (json["temperature_2m"] as num).toDouble();
        relativeHumidity2M = (json["relative_humidity_2m"] as num).toInt();
        precipitation = (json["precipitation"] as num).toInt();
        weatherCode = (json["weather_code"] as num).toInt();
        windSpeed10M = (json["wind_speed_10m"] as num).toDouble();
        windGusts10M = (json["wind_gusts_10m"] as num).toDouble();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["time"] = time;
        _data["interval"] = interval;
        _data["temperature_2m"] = temperature2M;
        _data["relative_humidity_2m"] = relativeHumidity2M;
        _data["precipitation"] = precipitation;
        _data["weather_code"] = weatherCode;
        _data["wind_speed_10m"] = windSpeed10M;
        _data["wind_gusts_10m"] = windGusts10M;
        return _data;
    }
}

class CurrentUnits {
    String? time;
    String? interval;
    String? temperature2M;
    String? relativeHumidity2M;
    String? precipitation;
    String? weatherCode;
    String? windSpeed10M;
    String? windGusts10M;

    CurrentUnits({this.time, this.interval, this.temperature2M, this.relativeHumidity2M, this.precipitation, this.weatherCode, this.windSpeed10M, this.windGusts10M});

    CurrentUnits.fromJson(Map<String, dynamic> json) {
        time = json["time"];
        interval = json["interval"];
        temperature2M = json["temperature_2m"];
        relativeHumidity2M = json["relative_humidity_2m"];
        precipitation = json["precipitation"];
        weatherCode = json["weather_code"];
        windSpeed10M = json["wind_speed_10m"];
        windGusts10M = json["wind_gusts_10m"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["time"] = time;
        _data["interval"] = interval;
        _data["temperature_2m"] = temperature2M;
        _data["relative_humidity_2m"] = relativeHumidity2M;
        _data["precipitation"] = precipitation;
        _data["weather_code"] = weatherCode;
        _data["wind_speed_10m"] = windSpeed10M;
        _data["wind_gusts_10m"] = windGusts10M;
        return _data;
    }
}