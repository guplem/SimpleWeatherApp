class Weather {
  final double latitude;
  final double longitude;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final List<DateTime> times;
  final List<dynamic> temperatures; // should be double, but ints are returned sometimes, so made dynamic
  final List<dynamic> precipitationProbabilities; // should be double, but ints are returned sometimes, so made dynamic
  final List<dynamic> precipitations; // should be double, but ints are returned sometimes, so made dynamic

  Weather({
    required this.latitude,
    required this.longitude,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.times,
    required this.temperatures,
    required this.precipitationProbabilities,
    required this.precipitations,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      latitude: json['latitude'],
      longitude: json['longitude'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      times: (json['hourly']['time'] as List).map((e) => DateTime.parse(e)).toList(),
      temperatures: List<dynamic>.from(json['hourly']['temperature_2m']).map((e) => e.toDouble()).toList(),
      precipitationProbabilities: List<dynamic>.from(json['hourly']['precipitation_probability']).map((e) => e.toDouble()).toList(),
      precipitations: List<dynamic>.from(json['hourly']['precipitation']).map((e) => e.toDouble()).toList(),
    );
  }
}
