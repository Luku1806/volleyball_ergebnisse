import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/bloc/domain/districts_bloc.dart';
import 'package:volleyball_ergebnisse/domain/district.dart';
import 'package:volleyball_ergebnisse/pages/leagues/leagues.dart';

class DistrictsPage extends StatefulWidget {
  final String tenantId;
  final int classId;

  DistrictsPage({
    Key? key,
    required this.tenantId,
    required this.classId,
  }) : super(key: key);

  @override
  State<DistrictsPage> createState() => _DistrictsPageState();
}

class _DistrictsPageState extends State<DistrictsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<DistrictsBloc>()
        .loadDistricts(widget.tenantId, widget.classId);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bezirke")),
      body: BlocBuilder(
        bloc: BlocProvider.of<DistrictsBloc>(context),
        builder: (context, state) {
          if (state is ApiLoadedState<List<District>>) {
            return ListView(children: _toDistrictListItems(state));
          } else if (state is ApiErrorState<List<District>>) {
            return Center(child: Text("Could not load handball districts"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _toDistrictListItems(ApiLoadedState<List<District>> state) {
    return state.result.map((district) => _toDistrictItem(district)).toList();
  }

  Widget _toDistrictItem(District district) {
    return ListTile(
      title: Text(district.name),
      onTap: () => _openLeaguePage(context, district),
    );
  }

  void _openLeaguePage(BuildContext context, District district) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaguesPage(
          tenantId: widget.tenantId,
          classId: widget.classId,
          districtId: district.id,
        ),
      ),
    );
  }
}
