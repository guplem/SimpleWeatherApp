class Location {
  final double latitude;
  final double longitude;
  final String name;

  Location({required this.latitude, required this.longitude, required this.name});

  // factory Location.fromJson(Map<String, dynamic> json) {
  //   return Location(
  //     latitude: json['latitude'],
  //     longitude: json['longitude'],
  //     name: json['address'],
  //   );
  // }
}