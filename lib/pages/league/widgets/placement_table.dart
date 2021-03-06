import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volleyball_ergebnisse/domain/team.dart';
import 'package:volleyball_ergebnisse/pages/games/games.dart';

class PlacementTable extends StatelessWidget {
  final List<Team> teams;

  PlacementTable(this.teams);

  @override
  Widget build(context) {
    return DataTable(
      columnSpacing: 8,
      columns: [
        DataColumn(label: Text(""), numeric: true),
        DataColumn(label: Text("Team"), numeric: false),
        DataColumn(label: Text("Sp."), numeric: true),
        DataColumn(label: Text("S."), numeric: true),
        DataColumn(label: Text("Gw."), numeric: true),
        DataColumn(label: Text("Pkte."), numeric: true),
      ],
      rows: _toTeamDataRows(context, teams),
    );
  }

  List<DataRow> _toTeamDataRows(BuildContext context, List<Team> teams) {
    final sortedTeams = [...teams];
    sortedTeams.sort(
      (team1, team2) => team1.placement.compareTo(team2.placement),
    );

    return sortedTeams.map((team) => _toTeamDataRow(context, team)).toList();
  }

  DataRow _toTeamDataRow(BuildContext context, Team team) {
    return DataRow(
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(
            team.placement.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        )),
        DataCell(Text(team.name), onTap: () => _openGamesPage(context, team)),
        DataCell(Text(team.games.toString())),
        DataCell(Text("${team.wonSets}:${team.lostSets}")),
        DataCell(Text(team.gamesWon.toString())),
        DataCell(Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Text(team.points.toString()),
        )),
      ],
    );
  }

  void _openGamesPage(BuildContext context, Team team) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamesPage(
          title: team.name,
          tenantId: team.tenant,
          leagueId: team.leagueId,
          teamId: team.id,
        ),
      ),
    );
  }
}
