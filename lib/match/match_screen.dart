
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gobola_app/service/match_service.dart';
import 'package:gobola_app/theme/appcolors.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';



class MatchScreen extends StatefulWidget {
  final MatchService matchService;

  const MatchScreen({super.key, required this.matchService});

  @override
  State<StatefulWidget> createState() {
    return Process();
  }
}

class Process extends State<MatchScreen> {
  late Map<String, dynamic> matchData = {};
  late Map<String, dynamic> liveCount = {};
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    fetchApis();
  }


  Future<void> fetchApis() async {
    //working api call in asynchronous in the background
    // _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
    //
    // });

    widget.matchService
        .fetchMatchDataApi(1, 10)
        .then((fetchedData) {
          setState(() {
            matchData = fetchedData;
          });
          debugPrint('Fetched Data: $matchData');
        })
        .catchError((error) {
          debugPrint('Error: $error');
    });

    widget.matchService
        .fetchLiveCountDataApi()
        .then((fetchedData) {
      setState(() {
        liveCount = fetchedData;
      });
      // debugPrint('Fetched Data: $matchData');
    })
        .catchError((error) {
          debugPrint('Error: $error');
    });

  }

  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    /*
    since this variable matchData set by asynchronous and it can be null
    because the result still in progress, but because the api call use 'then' it will return the value
     */
    debugPrint(
      'Fetched Data: ${matchData['data']?.length ?? 'loading match...'}',
    );
    debugPrint(
      'Fetched Data: ${liveCount['count'] ?? 'loading live count...'}',
    );
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 120.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppColors.bottomNavigationBarColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      "eBola",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 180),
                    Text(
                      "Live (${liveCount["count"] ?? 0})",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.red,
                color: Colors.transparent,
                width: double.infinity,
                child: Column(
                  children: [
                    //api response
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: matchData['data']?.length,
                        itemBuilder: (context, index) {
                          int size =
                              matchData.isNotEmpty
                                  ? matchData['data']?.length
                                  : 0;
                          if (size > 0) {
                            Map<String, dynamic> data =
                                matchData['data']?[index];
                            return Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 38,
                                  color: AppColors.darkBlue,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 9),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Image.network(
                                          data["image"],
                                          width: 20,
                                          height: 20,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            progress,
                                          ) {
                                            if (progress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          data['league'],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  // color: Colors.yellow,
                                  color: Colors.transparent,
                                  alignment: Alignment.topLeft,
                                  child: Text(data["round"]),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    height: 100,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          //time
                                          child: Container(
                                            // color: Colors.green,
                                            color: AppColors.softGrey,
                                            height: double.infinity,
                                            alignment: Alignment.center,
                                            child: Text(
                                              data['teams']['times'],
                                              style: TextStyle(
                                                color: AppColors.darkYellow,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          //team 1
                                          child: Container(
                                            // color: Colors.purple,
                                            color: AppColors.softGrey,
                                            height: double.infinity,
                                            child: Image.network(
                                              data["match"][0]["image"],
                                              width: 30,
                                              height: 30,
                                              loadingBuilder: (
                                                context,
                                                child,
                                                progress,
                                              ) {
                                                if (progress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          //vs
                                          child: Container(
                                            color: Colors.transparent,
                                            height: double.infinity,
                                            // padding: EdgeInsets.symmetric(
                                            //   vertical: 6,
                                            // ), // Top & bottom only
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                gradient:
                                                    AppColors
                                                        .bottomNavigationBarColor,
                                              ),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${data['match'][0]['score']} - ${data['match'][1]['score']}",
                                                  style: TextStyle(
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
                                          //team 2
                                          child: Container(
                                            // color: Colors.purple,
                                            color: AppColors.softGrey,
                                            height: double.infinity,
                                            child: Image.network(
                                              data["match"][1]["image"],
                                              width: 30,
                                              height: 30,
                                              loadingBuilder: (
                                                context,
                                                child,
                                                progress,
                                              ) {
                                                if (progress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          //favorite
                                          child: Container(
                                            // color: Colors.green,
                                            color: AppColors.softGrey,
                                            height: double.infinity,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: SvgPicture.asset(
                                                  "lib/assets/icons/favorite.svg",
                                                ),
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
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              height: 150, // Height of your widget
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
