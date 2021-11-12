import 'package:handball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/repositories/team.dart';
import 'package:handball_ergebnisse/domain/team.dart';

class TeamsBloc extends ApiBloc<List<Team>> {
  final TeamRepository _teamRepo;

  TeamsBloc(this._teamRepo);

  void loadTeamsForLeague(String tenant, int leagueId) async {
    emit(ApiLoadingState());

    try {
      final games = await _teamRepo.getAll(tenant, leagueId);
      emit(ApiLoadedState(games));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
