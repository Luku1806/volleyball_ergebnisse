import 'package:volleyball_ergebnisse/bloc/api/api_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/domain/tenant.dart';
import 'package:volleyball_ergebnisse/domain/repositories/tenant.dart';

class TenantsBloc extends ApiBloc<List<Tenant>> {
  final TenantRepository _tenantRepo;

  TenantsBloc(this._tenantRepo);

  void loadTenants() async {
    emit(ApiLoadingState());

    try {
      final tenants = await _tenantRepo.getAll();
      emit(ApiLoadedState(tenants));
    } catch (e) {
      print(e);
      emit(ApiErrorState());
    }
  }
}
