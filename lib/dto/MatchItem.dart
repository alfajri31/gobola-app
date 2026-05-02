import 'Team.dart';
import 'Teams.dart';

class MatchItem {
  final String id;
  final String league;
  final String image;
  final String round;
  final Teams teams;
  final List<Team> match;

  MatchItem({
    required this.id,
    required this.league,
    required this.image,
    required this.round,
    required this.teams,
    required this.match,
  });

  factory MatchItem.fromJson(Map<String, dynamic> json) {
    return MatchItem(
      id: json['id'],
      league: json['league'],
      image: json['image'],
      round: json['round'],
      teams: Teams.fromJson(json['teams']),
      match: (json['match'] as List)
          .map((e) => Team.fromJson(e))
          .toList(),
    );
  }
}