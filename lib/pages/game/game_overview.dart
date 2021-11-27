import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volleyball_ergebnisse/domain/game.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'game_overview_header.dart';

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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          GameOverviewHeader(game: widget.game),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: Text("Sätze"),
                subtitle: Text(
                  widget.game.sets.length > 0
                      ? widget.game.sets.join(" ")
                      : "-:-",
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
                subtitle: Text(widget.game.gymnasium.displayAddress),
                trailing: Icon(Icons.map),
                onTap: openGoogleMaps,
                onLongPress: () => copyAddress(context),
              )
            ]),
          )
        ],
      ),
    );
  }

  void openGoogleMaps() {
    final gym = widget.game.gymnasium;

    if (gym.lat != null && gym.lon != null) {
      MapsLauncher.launchCoordinates(gym.lat!, gym.lon!, gym.name);
    } else {
      MapsLauncher.launchQuery(
        "${gym.name}, ${gym.street}, ${gym.zip} ${gym.city}",
      );
    }
  }

  void copyAddress(context) async {
    await Clipboard.setData(
      new ClipboardData(text: widget.game.gymnasium.displayAddress),
    );

    HapticFeedback.mediumImpact();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Adresse wurde kopiert"),
      ),
    );
  }
}
