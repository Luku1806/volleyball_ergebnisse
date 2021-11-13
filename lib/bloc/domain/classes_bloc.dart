import 'package:volleyball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/domain/class.dart';
import 'package:volleyball_ergebnisse/domain/repositories/class.dart';

class ClassesBloc extends ApiBloc<List<Class>> {
  final ClassRepository _classRepo;

  ClassesBloc(this._classRepo);

  void loadClasses(String tenant) async {
    emit(ApiLoadingState());

    try {
      final districts = await _classRepo.getAll(tenant);
      emit(ApiLoadedState(districts));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
