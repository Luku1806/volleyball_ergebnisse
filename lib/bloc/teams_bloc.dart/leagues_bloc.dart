import 'package:volleyball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/domain/league.dart';
import 'package:volleyball_ergebnisse/domain/repositories/league.dart';

class LeaguesBloc extends ApiBloc<List<League>> {
  final LeagueRepository _leagueRepo;

  LeaguesBloc(this._leagueRepo);

  void loadLeagues(String tenant, int classId, int districtId) async {
    emit(ApiLoadingState());

    try {
      final leagues = await _leagueRepo.getAllByDistrict(
        tenant,
        classId,
        districtId,
      );
      emit(ApiLoadedState(leagues));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
