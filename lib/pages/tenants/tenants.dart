import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/tenants_bloc.dart';
import 'package:handball_ergebnisse/domain/tenant.dart';
import 'package:handball_ergebnisse/pages/classes/classes.dart';

class TenantsPage extends StatefulWidget {
  @override
  State<TenantsPage> createState() => _TenantsPageState();
}

class _TenantsPageState extends State<TenantsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TenantsBloc>().loadTenants();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verbände")),
      body: BlocBuilder(
        bloc: BlocProvider.of<TenantsBloc>(context),
        builder: (context, state) {
          if (state is ApiLoadedState<List<Tenant>>) {
            return ListView(children: _toTenantListItems(state));
          } else if (state is ApiErrorState<List<Tenant>>) {
            return Center(
              child: Text("Verbände konnten nicht geladen werden."),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _toTenantListItems(ApiLoadedState<List<Tenant>> state) {
    return state.result.map((tenant) => _toTenantItem(tenant)).toList();
  }

  Widget _toTenantItem(Tenant tenant) {
    return ListTile(
      title: Text(tenant.name),
      onTap: () => _openDistrictsPage(context, tenant),
    );
  }

  void _openDistrictsPage(BuildContext context, Tenant tenant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClassesPage(tenantId: tenant.shortName),
      ),
    );
  }
}
