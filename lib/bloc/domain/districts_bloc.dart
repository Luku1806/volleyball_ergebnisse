import 'package:volleyball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/domain/district.dart';
import 'package:volleyball_ergebnisse/domain/repositories/district.dart';

class DistrictsBloc extends ApiBloc<List<District>> {
  final DistrictRepository _districtRepo;

  DistrictsBloc(this._districtRepo);

  void loadDistricts(String tenant, int classId) async {
    emit(ApiLoadingState());

    try {
      final districts = await _districtRepo.getAll(tenant, classId);
      emit(ApiLoadedState(districts));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
