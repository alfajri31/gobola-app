import 'Aggregate.dart';

class Teams {
  final String times;
  final String color;
  final Aggregate? aggregate;

  Teams({
    required this.times,
    required this.color,
    this.aggregate,
  });

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      times: json['times'],
      color: json['color'],
      aggregate: json['aggregate'] == null
          ? null
          : Aggregate.fromJson(json['aggregate']),
    );
  }
}