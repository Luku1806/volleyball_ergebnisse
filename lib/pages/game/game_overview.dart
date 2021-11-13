import 'package:flutter/material.dart';
import 'package:volleyball_ergebnisse/domain/game.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

class GameOverviewPage extends StatefulWidget {
  final Game game;

  GameOverviewPage(this.game);

  @override
  State<GameOverviewPage> createState() => _GameOverviewPageState();
}

class _GameOverviewPageState extends State<GameOverviewPage> {
  final _dateTimeFormat = DateFormat.yMMMMEEEEd("de_DE").add_Hm();

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
            subtitle: Text(
              _dateTimeFormat.format(widget.game.openingTime.toLocal()),
            ),
          ),
          ListTile(
            title: Text("Beginn"),
            subtitle: Text(
              _dateTimeFormat.format(widget.game.startTime.toLocal()),
            ),
          ),
          ListTile(
            isThreeLine: true,
            title: Text("Sporthalle"),
            subtitle: Text(
                "${widget.game.gymnasium.name}, ${widget.game.gymnasium.street}, ${widget.game.gymnasium.zip} ${widget.game.gymnasium.city}"),
            onTap: () {
              final gym = widget.game.gymnasium;

              if (gym.lat != null && gym.lon != null) {
                MapsLauncher.launchCoordinates(gym.lat!, gym.lon!, gym.name);
              } else {
                MapsLauncher.launchQuery(
                  "${gym.name}, ${gym.street}, ${gym.zip} ${gym.city}",
                );
              }
            },
          )
        ],
      ),
    );
  }
}
