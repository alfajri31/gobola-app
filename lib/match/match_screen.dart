import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gobola_app/match/detail/match_detail.dart';
import 'package:gobola_app/service/match_service.dart';
import 'package:gobola_app/theme/appcolors.dart';
import 'package:gobola_app/toggles/switch_toggle.dart';
import 'package:shimmer/shimmer.dart';

class MatchScreen extends StatefulWidget {
  final MatchService matchService;

  const MatchScreen({super.key, required this.matchService});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  Map<String, dynamic> matchData = {};
  Map<String, dynamic> liveCount = {};
  bool isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if(isLoading) {
        fetchLiveCount();
        fetchApis();
      }
    });

  }

  Future<void> fetchLiveCount() async {
    try {
      final data = await widget.matchService.fetchLiveCountDataApi();
      if (!mounted) return;

      setState(() {
        liveCount = data;
      });
    } catch (_) {}
  }

  Future<void> fetchApis() async {

    setState(() => isLoading = true);

    try {
      final results = await Future.wait([
        widget.matchService.fetchMatchDataApi(1, 10),
        widget.matchService.fetchLiveCountDataApi(),
      ]);

      if (!mounted) return;

      setState(() {
        matchData = results[0];
        liveCount = results[1];
        isLoading = false;
      });

      // log di sini, jangan di build()
      debugPrint('Match length: ${(matchData["data"] as List?)?.length ?? 0}');
      debugPrint('Live count: ${liveCount["count"] ?? 0}');
    } catch (e) {
      if (!mounted) return;
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List dataList = (matchData['data'] as List?) ?? [];
    final int live = (liveCount["count"] as int?) ?? 0;

    return Scaffold(body: _buildListVIew(live, dataList));
  }

  Widget _buildListVIew(live, dataList) {
    return Column(
      children: [
        _Header(live: live),
        Expanded(
          child:
              isLoading
                  ? const ShimmerList()
                  : ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (_, i) => MatchCard(data: dataList[i]),
                  ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final int live;

  const _Header({required this.live});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120.0,
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: AppColors.bottomNavigationBarColor),
        child: Row(
          children: [
            SizedBox(width: 20),
            Text(
              "eBola",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: Text(
                    "Live ($live)",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SwitchToggle(),
              ],
            ),
            // teks live di bawah pakai builder biar const tetap dipakai? kita bikin non-const:
          ],
        ),
      ),
    );
  }
}

/// Match card dipisah supaya build utama lebih ringan & rapi
class MatchCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const MatchCard({super.key, required this.data});

  @override
  State<MatchCard> createState() => _SwitchMatchCard();
}

class _SwitchMatchCard extends State<MatchCard> {
  bool isMatchDetail = false;

  @override
  Widget build(BuildContext context) {
    final String league = (widget.data['league'] ?? '') as String;
    final String leagueImage = (widget.data['image'] ?? '') as String;
    final String round = (widget.data['round'] ?? '') as String;

    final Map teams = (widget.data['teams'] as Map?) ?? {};
    final String times = (teams['times'] ?? '') as String;

    final List match = (widget.data['match'] as List?) ?? [];
    final Map m1 = match.isNotEmpty ? (match[0] as Map) : {};
    final Map m2 = match.length > 1 ? (match[1] as Map) : {};

    final String img1 = (m1['image'] ?? '') as String;
    final String img2 = (m2['image'] ?? '') as String;

    final int s1 = (m1['score'] as int?) ?? 0;
    final int s2 = (m2['score'] as int?) ?? 0;

    return Column(
      children: [
        // League Header
        Container(
          width: double.infinity,
          height: 38,
          color: AppColors.darkBlue,
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            children: [
              const SizedBox(width: 10),
              _NetImage(url: leagueImage, size: 20),
              const SizedBox(width: 10),
              Text(league, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),

        // Round
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.topLeft,
          child: Text(round),
        ),

        // Row Match
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.softGrey,
                    alignment: Alignment.center,
                    child: Text(
                      times,
                      style: TextStyle(
                        color: AppColors.darkYellow,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.softGrey,
                    alignment: Alignment.center,
                    child: _NetImage(url: img1, size: 30),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => Scaffold(
                                body: MatchDetail(),
                                bottomNavigationBar: null, // inject lagi
                              ),
                        ),
                      );
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.bottomNavigationBarColor,
                      ),
                      child: Center(
                        child: Text(
                          "$s1 - $s2",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.softGrey,
                    alignment: Alignment.center,
                    child: _NetImage(url: img2, size: 30),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.softGrey,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "lib/assets/icons/favorite.svg",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Image loader ringan (tanpa spinner) -> lebih hemat render
class _NetImage extends StatelessWidget {
  final String url;
  final double size;

  const _NetImage({required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return SizedBox(width: size, height: size);
    }

    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      // Placeholder ringan biar list gak berat
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(width: size, height: size);
      },
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(width: size, height: size);
      },
    );
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder:
            (_, __) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
      ),
    );
  }
}
