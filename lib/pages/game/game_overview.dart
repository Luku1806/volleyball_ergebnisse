import 'package:flutter/material.dart';
import 'package:handball_ergebnisse/domain/game.dart';

class GameOverviewPage extends StatefulWidget {
  final Game game;

  GameOverviewPage(this.game);

  @override
  State<GameOverviewPage> createState() => _GameOverviewPageState();
}

class _GameOverviewPageState extends State<GameOverviewPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spiel"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "${widget.game.team1.name} vs ${widget.game.team2.name}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text("Sätze"),
            subtitle: Text(
              widget.game.sets.length > 0 ? widget.game.sets.join(" ") : "-:-",
            ),
          ),
          ListTile(
            title: Text("Einlass"),
            subtitle: Text(widget.game.openingTime.toString()),
          ),
          ListTile(
            title: Text("Beginn"),
            subtitle: Text(widget.game.startTime.toString()),
          ),
          ListTile(
            isThreeLine: true,
            title: Text("Sporthalle"),
            subtitle: Text(
                "${widget.game.gymnasium.name}\n${widget.game.gymnasium.street}, ${widget.game.gymnasium.zip} ${widget.game.gymnasium.city}"),
            onTap: () => {},
          )
        ],
      ),
    );
  }
}
