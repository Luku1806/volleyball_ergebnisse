import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/teams_bloc.dart/games_bloc.dart';
import 'package:handball_ergebnisse/domain/team.dart';
import 'package:handball_ergebnisse/pages/league/widgets/placement_table.dart';

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
    context
        .read<TeamsBloc>()
        .loadTeamsForLeague(widget.tenantId, widget.leagueId);
  }

  @override
  Widget build(context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TeamsBloc>(context),
      builder: (context, state) {
        if (state is ApiLoadedState<List<Team>>) {
          return SingleChildScrollView(child: PlacementTable(state.result));
        } else if (state is ApiErrorState<List<Team>>) {
          return Center(child: Text("Tabelle konnte nicht geladen werden."));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
