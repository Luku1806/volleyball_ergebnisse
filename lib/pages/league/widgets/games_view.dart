import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/bloc/domain/games_bloc.dart';
import 'package:volleyball_ergebnisse/domain/game.dart';
import 'package:volleyball_ergebnisse/pages/league/widgets/game_timeline.dart';
import 'package:volleyball_ergebnisse/pages/widgets/volleyball_progress_indicator.dart';

class GamesView extends StatefulWidget {
  final String tenantId;
  final int leagueId;
  final int? teamId;

  GamesView({
    required this.tenantId,
    required this.leagueId,
    this.teamId,
  });

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadGames(context);
  }

  @override
  Widget build(context) {
    return RefreshIndicator(
      onRefresh: () async => _loadGames(context),
      child: BlocBuilder(
        bloc: BlocProvider.of<GamesBloc>(context),
        builder: (context, state) {
          if (state is ApiLoadedState<List<Game>>) {
            return GameTimeline(games: state.result, teamId: widget.teamId);
          } else if (state is ApiErrorState<List<Game>>) {
            return Center(child: Text("Spiele konnten nicht geladen werden."));
          } else {
            return Center(child: VolleyballProgressIndicator());
          }
        },
      ),
    );
  }

  void _loadGames(BuildContext context) {
    if (widget.teamId != null) {
      context.read<GamesBloc>().loadGamesForTeam(
            widget.tenantId,
            widget.leagueId,
            widget.teamId!,
          );
    } else {
      context.read<GamesBloc>().loadGamesForLeague(
            widget.tenantId,
            widget.leagueId,
          );
    }
  }
}
