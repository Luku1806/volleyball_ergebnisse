import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/favorite_leagues_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/favorites/states.dart';
import 'package:volleyball_ergebnisse/domain/league.dart';

import 'league_card.dart';

class FavoriteLeaguesOverview extends StatefulWidget {
  @override
  State<FavoriteLeaguesOverview> createState() =>
      _FavoriteLeaguesOverviewState();
}

class _FavoriteLeaguesOverviewState extends State<FavoriteLeaguesOverview> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FavoriteLeaguesBloc>().loadFavoriteLeagues();
  }

  @override
  Widget build(context) {
    return BlocBuilder(
        bloc: BlocProvider.of<FavoriteLeaguesBloc>(context),
        builder: (context, state) {
          if (state is FavoritesInitializedState<League>) {
            return ListView(
              children: state.favorites
                  .map((league) => LeaguePreviewCard(league: league))
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
    throw UnimplementedError();
  }
}
