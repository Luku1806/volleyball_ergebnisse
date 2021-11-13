import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/games_bloc.dart';
import 'package:handball_ergebnisse/domain/game.dart';
import 'package:handball_ergebnisse/infrastructure/calendar_service.dart';
import 'package:handball_ergebnisse/pages/league/widgets/games_view.dart';

class GamesPage extends StatelessWidget {
  final String? title;
  final String tenantId;
  final int leagueId;
  final int teamId;

  GamesPage({
    this.title,
    required this.tenantId,
    required this.leagueId,
    required this.teamId,
  });

  @override
  Widget build(context) {
    return BlocBuilder(
        bloc: BlocProvider.of<GamesBloc>(context),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title ?? "Spiele"),
              actions: [
                IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: state is ApiLoadedState<List<Game>>
                        ? () => CalendarService.addGames(context, state.result)
                        : null),
              ],
            ),
            body: GamesView(
              tenantId: tenantId,
              leagueId: leagueId,
              teamId: teamId,
            ),
          );
        });
  }
}
