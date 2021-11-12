import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handball_ergebnisse/pages/league/widgets/games_view.dart';

class GamesPage extends StatelessWidget {
  final String tenantId;
  final int leagueId;
  final int teamId;

  GamesPage({
    required this.tenantId,
    required this.leagueId,
    required this.teamId,
  });

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Spiele")),
      body: GamesView(
        tenantId: tenantId,
        leagueId: leagueId,
        teamId: teamId,
      ),
    );
  }
}
