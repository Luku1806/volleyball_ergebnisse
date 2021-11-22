import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/bloc/domain/favorite_leagues_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/leagues_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/favorites/states.dart';
import 'package:volleyball_ergebnisse/domain/league.dart';
import 'package:volleyball_ergebnisse/pages/league/league.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:volleyball_ergebnisse/pages/widgets/volleyball_progress_indicator.dart';

class LeaguesPage extends StatefulWidget {
  final String tenantId;
  final int classId;
  final int districtId;

  LeaguesPage({
    Key? key,
    required this.tenantId,
    required this.classId,
    required this.districtId,
  }) : super(key: key);

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FavoriteLeaguesBloc>().loadFavoriteLeagues();
    context.read<LeaguesBloc>().loadLeagues(
          widget.tenantId,
          widget.classId,
          widget.districtId,
        );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ligen")),
      body: BlocBuilder(
        bloc: BlocProvider.of<FavoriteLeaguesBloc>(context),
        builder: (context, favoritesState) {
          return BlocBuilder(
            bloc: BlocProvider.of<LeaguesBloc>(context),
            builder: (context, leaguesApiState) {
              if (leaguesApiState is ApiLoadedState<List<League>>) {
                return ListView(
                  children: _toLeagueListItems(
                      leaguesApiState.result,
                      favoritesState is FavoritesInitializedState<League>
                          ? favoritesState.favorites
                          : null),
                );
              } else if (leaguesApiState is ApiErrorState<List<League>>) {
                return Center(
                  child: Text("Ligen konnten nicht geladen werden."),
                );
              } else {
                return Center(child: VolleyballProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }

  List<Widget> _toLeagueListItems(
      List<League> leagues, List<League>? favorites) {
    return leagues
        .map((league) => _toLeagueListItem(league, favorites))
        .toList();
  }

  Widget _toLeagueListItem(League league, List<League>? favorites) {
    final isFavorite =
        favorites?.any((favoriteLeague) => favoriteLeague.id == league.id);

    return ListTile(
      title: Text(league.name),
      trailing: IconButton(
        icon: isFavorite != null
            ? Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              )
            : SkeletonLoader(
                builder: Icon(Icons.favorite),
              ),
        onPressed: () => isFavorite != null
            ? _toggleFavorite(context, league, isFavorite)
            : null,
      ),
      onTap: () => _openLeaguePage(context, league),
    );
  }

  void _toggleFavorite(BuildContext context, League league, bool isFavorite) {
    if (isFavorite) {
      context.read<FavoriteLeaguesBloc>().removeFavoriteLeague(league.id);
    } else {
      context.read<FavoriteLeaguesBloc>().addFavoriteLeague(league);
    }
  }

  void _openLeaguePage(BuildContext context, League league) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaguePage(
          tenantId: widget.tenantId,
          league: league,
        ),
      ),
    );
  }
}
