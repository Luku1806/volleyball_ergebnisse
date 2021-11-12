import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/pages/league/league.dart';

class LeaguePreviewCard extends StatefulWidget {
  final League league;

  LeaguePreviewCard({required this.league});

  @override
  State<LeaguePreviewCard> createState() => _LeaguePreviewCardState();
}

class _LeaguePreviewCardState extends State<LeaguePreviewCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(context) {
    return Card(
      child: InkWell(
        onTap: () => _openLeaguePage(context, widget.league),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(widget.league.name),
              trailing: Icon(Icons.arrow_right_sharp),
            )
          ],
        ),
      ),
    );
  }

  void _openLeaguePage(BuildContext context, League league) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LeaguePage(tenantId: league.tenantId, league: league),
      ),
    );
  }
}
