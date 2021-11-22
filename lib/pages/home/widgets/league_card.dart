import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volleyball_ergebnisse/domain/league.dart';
import 'package:volleyball_ergebnisse/pages/league/league.dart';

class LeaguePreviewListItem extends StatefulWidget {
  final League league;

  LeaguePreviewListItem({required this.league});

  @override
  State<LeaguePreviewListItem> createState() => _LeaguePreviewListItemState();
}

class _LeaguePreviewListItemState extends State<LeaguePreviewListItem> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(context) {
    return ListTile(
      title: Text(widget.league.name),
      trailing: Icon(Icons.arrow_right_sharp),
      onTap: () => _openLeaguePage(context, widget.league),
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
