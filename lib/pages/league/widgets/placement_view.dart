import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/bloc/teams_bloc.dart/games_bloc.dart';
import 'package:volleyball_ergebnisse/domain/team.dart';
import 'package:volleyball_ergebnisse/pages/league/widgets/placement_table.dart';
import 'package:volleyball_ergebnisse/pages/widgets/volleyball_progress_indicator.dart';

class PlacementView extends StatefulWidget {
  final String tenantId;
  final int leagueId;

  PlacementView({required this.tenantId, required this.leagueId});

  @override
  State<PlacementView> createState() => _PlacementViewState();
}

class _PlacementViewState extends State<PlacementView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadTeams(context);
  }

  @override
  Widget build(context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TeamsBloc>(context),
      builder: (context, state) {
        if (state is ApiLoadedState<List<Team>>) {
          return RefreshIndicator(
            onRefresh: () async {
              HapticFeedback.mediumImpact();
              _loadTeams(context);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
                child: PlacementTable(state.result),
              ),
            ),
          );
        } else if (state is ApiErrorState<List<Team>>) {
          return Center(child: Text("Tabelle konnte nicht geladen werden."));
        } else {
          return Center(child: VolleyballProgressIndicator());
        }
      },
    );
  }

  void _loadTeams(BuildContext context) {
    context
        .read<TeamsBloc>()
        .loadTeamsForLeague(widget.tenantId, widget.leagueId);
  }
}
