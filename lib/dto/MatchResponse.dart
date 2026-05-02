import 'MatchItem.dart';

class MatchResponse {

  final int pageSize;
  final int page;
  final bool live;
  final List<MatchItem> data;

  MatchResponse({
    required this.pageSize,
    required this.page,
    required this.live,
    required this.data,
  });


  factory MatchResponse.fromJson(Map<String, dynamic> json) {
    return MatchResponse(
      pageSize: json['pageSize'],
      page: json['page'],
      live: json['live'],
      data: (json['data'] as List)
          .map((e) => MatchItem.fromJson(e))
          .toList(),
    );
  }
}