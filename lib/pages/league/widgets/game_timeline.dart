import 'package:flutter/material.dart';
import 'package:handball_ergebnisse/domain/game.dart';
import 'package:handball_ergebnisse/pages/game/game_overview.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class GameTimeline extends StatelessWidget {
  final List<Game> games;
  final int? teamId;

  GameTimeline({required this.games, this.teamId});

  List<Game> get _sortedGames => _sortByDate(games);

  @override
  Widget build(context) {
    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0.05,
        connectorTheme: ConnectorThemeData(
          thickness: 3.0,
          color: Color(0xffd3d3d3),
        ),
        indicatorTheme: IndicatorThemeData(
          size: 15.0,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        contentsAlign: ContentsAlign.basic,
        indicatorBuilder: (context, index) {
          final game = _sortedGames.elementAt(index);

          return game.isOver
              ? DotIndicator(
                  color: colorForResult(game),
                  child: game.isOver
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 10.0,
                        )
                      : Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10.0,
                        ),
                )
              : OutlinedDotIndicator();
        },
        connectorBuilder: (context, index, connectorType) {
          return Connector.solidLine();
        },
        contentsBuilder: (context, index) {
          final game = _sortedGames.elementAt(index);

          return Padding(
            padding: EdgeInsets.fromLTRB(6.0, 16.0, 6.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd. MMMM yyyy HH:mm').format(game.startTime),
                  style: TextStyle(color: Colors.grey),
                ),
                Card(
                  child: InkWell(
                    onTap: () => _openGameOverview(context, game),
                    child: Column(
                      children: [
                        ListTile(
                          title:
                              Text("${game.team1.name} vs ${game.team2.name}"),
                          subtitle: Text(
                            game.hasData
                                ? "${game.team1.points}:${game.team2.points}"
                                : "-:-",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: games.length,
      ),
    );
  }

  Color? colorForResult(Game game) {
    return teamId != null
        ? game.winnerTeamId == teamId
            ? Color(0xff6ad192)
            : Color(0xffff5454)
        : null;
  }

  List<Game> _sortByDate(List<Game> games) {
    final sorted = [...games];
    sorted.sort((game1, game2) => game1.startTime.compareTo(game2.startTime));
    return sorted;
  }

  void _openGameOverview(BuildContext context, Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameOverviewPage(game)),
    );
  }
}
