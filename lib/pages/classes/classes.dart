import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/api/states.dart';
import 'package:volleyball_ergebnisse/bloc/domain/classes_bloc.dart';
import 'package:volleyball_ergebnisse/domain/class.dart';
import 'package:volleyball_ergebnisse/domain/tenant.dart';
import 'package:volleyball_ergebnisse/pages/districts/districts.dart';

class ClassesPage extends StatefulWidget {
  final String tenantId;

  ClassesPage({Key? key, required this.tenantId}) : super(key: key);

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ClassesBloc>().loadClasses(widget.tenantId);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Klassen")),
      body: BlocBuilder(
        bloc: BlocProvider.of<ClassesBloc>(context),
        builder: (context, state) {
          if (state is ApiLoadedState<List<Class>>) {
            return ListView(children: _toClassListItems(state));
          } else if (state is ApiErrorState<List<Class>>) {
            return Center(
              child: Text("Klassen konnten nicht geladen werden."),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _toClassListItems(ApiLoadedState<List<Class>> state) {
    return state.result.map((ageClass) => _toClassItem(ageClass)).toList();
  }

  Widget _toClassItem(Class ageClass) {
    return ListTile(
      title: Text(ageClass.name),
      onTap: () => _openDistrictsPage(context, ageClass),
    );
  }

  void _openDistrictsPage(BuildContext context, Class ageClass) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DistrictsPage(
          tenantId: widget.tenantId,
          classId: ageClass.id,
        ),
      ),
    );
  }
}
