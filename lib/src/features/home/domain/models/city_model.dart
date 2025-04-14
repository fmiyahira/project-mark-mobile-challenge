import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String name;
  final String state;
  final double lat;
  final double long;

  const CityModel({
    required this.name,
    required this.state,
    required this.lat,
    required this.long,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] as String,
      state: map['state'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
    );
  }

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'] as String,
      state: json['state'] as String,
      lat: json['lat'] as double,
      long: json['long'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'state': state,
      'lat': lat,
      'long': long,
    };
  }

  @override
  List<Object?> get props => [name, state, lat, long];
}
