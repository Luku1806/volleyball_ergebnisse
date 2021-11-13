import 'package:volleyball_ergebnisse/bloc/favorites/favorites_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/favorites/states.dart';
import 'package:volleyball_ergebnisse/domain/league.dart';
import 'package:volleyball_ergebnisse/domain/repositories/favorite_leagues.dart';

class FavoriteLeaguesBloc extends FavoritesBloc<League> {
  final FavoriteLeaguesRepository _favoriteLeaguesRepo;

  List<League>? _favoriteLeagues;

  FavoriteLeaguesBloc(this._favoriteLeaguesRepo);

  void loadFavoriteLeagues() async {
    emit(FavoritesLoadingState());

    try {
      _favoriteLeagues =
          _favoriteLeagues ?? await _favoriteLeaguesRepo.getAll();

      emit(FavoritesInitializedState(_favoriteLeagues!));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }

  void addFavoriteLeague(League league) async {
    try {
      _favoriteLeaguesRepo.add(league);
      _favoriteLeagues?.add(league);
      emit(FavoritesInitializedState(_favoriteLeagues!));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }

  void removeFavoriteLeague(int leagueId) async {
    try {
      _favoriteLeaguesRepo.remove(leagueId);
      _favoriteLeagues?.remove(leagueId);
      emit(FavoritesInitializedState(_favoriteLeagues!));
    } catch (e) {
      emit(FavoritesErrorState());
    }
  }
}
