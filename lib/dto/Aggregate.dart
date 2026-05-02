class Aggregate {
  final int home;
  final int away;

  Aggregate({
    required this.home,
    required this.away,
  });

  factory Aggregate.fromJson(Map<String, dynamic> json) {
    return Aggregate(
      home: json['home'],
      away: json['away'],
    );
  }
}