class Team {
  final String id;
  final String name;
  final int score;
  final String image;

  Team({
    required this.id,
    required this.name,
    required this.score,
    required this.image,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      score: json['score'],
      image: json['image'],
    );
  }
}