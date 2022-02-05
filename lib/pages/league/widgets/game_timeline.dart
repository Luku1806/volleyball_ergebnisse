import 'package:flutter/material.dart';
import 'package:volleyball_ergebnisse/domain/game.dart';
import 'package:volleyball_ergebnisse/pages/game/game_overview.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class GameTimeline extends StatefulWidget {
  final _tileHeight = 150.0;

  final List<Game> games;
  final int? teamId;

  GameTimeline({required this.games, this.teamId});

  @override
  State<GameTimeline> createState() => _GameTimelineState();
}

class _GameTimelineState extends State<GameTimeline> {
  late final ScrollController _scrollController;

  final _dateTimeFormat = DateFormat.yMd("de_DE").add_Hm();

  List<Game> get _sortedGames => _sortByDate(widget.games);

  @override
  void initState() {
    final nextGameIndex = widget.games.indexOf(nextGame);
    _scrollController = ScrollController(
      initialScrollOffset: nextGameIndex * widget._tileHeight,
    );

    super.initState();
  }

  Game get nextGame {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return widget.games.firstWhere((game) => game.startTime.isAfter(today),
        orElse: () => widget.games.last);
  }

  @override
  Widget build(context) {
    return Timeline.tileBuilder(
      controller: _scrollController,
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

          return SizedBox(
            height: widget._tileHeight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(6.0, 16.0, 6.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _dateTimeFormat.format(game.startTime.toLocal()),
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 100,
                    child: Card(
                      child: InkWell(
                        onTap: () => _openGameOverview(context, game),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GameCardText(
                                text: game.team1.name,
                                size: 14,
                                alignment: Alignment.centerRight,
                              ),
                              GameCardText(
                                text: game.hasData
                                    ? "${game.team1.points}:${game.team2.points}"
                                    : "-:-",
                                size: 24,
                                alignment: Alignment.center,
                              ),
                              GameCardText(
                                text: game.team2.name,
                                size: 14,
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: widget.games.length,
      ),
    );
  }

  Color? colorForResult(Game game) {
    return widget.teamId != null
        ? game.winnerTeamId == widget.teamId
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

class GameCardText extends StatelessWidget {
  final String text;
  final double size;
  final Alignment alignment;
  final TextAlign textAlign;
  final int flex;

  GameCardText(
      {Key? key,
      required this.text,
      required this.size,
      required this.alignment,
      this.flex = 1})
      : textAlign = alignment == Alignment.centerLeft
            ? TextAlign.left
            : alignment == Alignment.centerRight
                ? TextAlign.right
                : TextAlign.center,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      flex: flex,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: size,
          ),
        ),
      ),
    );
  }
}
