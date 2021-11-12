import 'package:flutter/material.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/pages/league/widgets/games_view.dart';
import 'package:handball_ergebnisse/pages/league/widgets/placement_view.dart';

class LeaguePage extends StatefulWidget {
  final String tenantId;
  final League league;

  LeaguePage({Key? key, required this.tenantId, required this.league})
      : super(key: key);

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  int currentTab = 0;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.league.name)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Tabelle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_volleyball),
            label: "Spiele",
          )
        ],
        currentIndex: currentTab,
        onTap: (tabNumber) => setState(() => currentTab = tabNumber),
      ),
      body: [
        //PlacementView(widget.league),
        PlacementView(tenantId: widget.tenantId, leagueId: widget.league.id),
        GamesView(tenantId: widget.tenantId, leagueId: widget.league.id),
      ].elementAt(currentTab),
    );
  }
}
