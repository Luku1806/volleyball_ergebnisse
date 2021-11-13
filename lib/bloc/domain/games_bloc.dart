import 'package:volleyball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/domain/game.dart';
import 'package:volleyball_ergebnisse/domain/repositories/game.dart';

class GamesBloc extends ApiBloc<List<Game>> {
  final GameRepository _gameRepo;

  GamesBloc(this._gameRepo);

  void loadGamesForLeague(String tenant, int leagueId) async {
    emit(ApiLoadingState());

    try {
      final games = await _gameRepo.getAllByLeague(tenant, leagueId);
      emit(ApiLoadedState(games));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }

  void loadGamesForTeam(String tenant, int leagueId, int teamId) async {
    emit(ApiLoadingState());

    try {
      final games = await _gameRepo.getAllByTeam(tenant, leagueId, teamId);
      emit(ApiLoadedState(games));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
