import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/classes_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/districts_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/favorite_leagues_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/games_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/leagues_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/domain/tenants_bloc.dart';
import 'package:volleyball_ergebnisse/bloc/teams_bloc.dart/games_bloc.dart';
import 'package:volleyball_ergebnisse/domain/repositories/class.dart';
import 'package:volleyball_ergebnisse/domain/repositories/district.dart';
import 'package:volleyball_ergebnisse/domain/repositories/favorite_leagues.dart';
import 'package:volleyball_ergebnisse/domain/repositories/game.dart';
import 'package:volleyball_ergebnisse/domain/repositories/league.dart';
import 'package:volleyball_ergebnisse/domain/repositories/team.dart';
import 'package:volleyball_ergebnisse/domain/repositories/tenant.dart';
import 'package:volleyball_ergebnisse/infrastructure/notifications/notification_action_service.dart';
import 'package:volleyball_ergebnisse/infrastructure/notifications/notification_registration_service.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/volleyballergebnisse/volleyball_ergebnisse_class.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/volleyballergebnisse/volleyball_ergebnisse_district.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/volleyballergebnisse/volleyball_ergebnisse_favorite_leagues.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/volleyballergebnisse/volleyball_ergebnisse_game.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/volleyballergebnisse/volleyball_ergebnisse_league.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/volleyballergebnisse/volleyball_ergebnisse_team.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/volleyballergebnisse/volleyball_ergebnisse_tenant.dart';
import 'package:volleyball_ergebnisse/pages/home/home.dart';
import 'package:intl/date_symbol_data_local.dart';

final notificationRegistrationService = NotificationRegistrationService();
final notificationActionService = NotificationActionService();

void registerNotifications() async {
  await notificationRegistrationService.registerDevice();

  notificationActionService.actionTriggered.listen((event) {
    print(event);
  });

  await notificationActionService.checkLaunchAction();
}

void main() {
  initializeDateFormatting("de_DE")
      .then((value) => runApp(VolleyballErgebnisseApp()))
      .then((value) => registerNotifications());
}

class VolleyballErgebnisseApp extends StatelessWidget {
  final tenantRepository = VolleyballErgebnisseTenantRepository();
  final classRepository = VolleyballErgebnisseClassRepository();
  final districtRepository = VolleyballErgebnisseDistrictRepository();
  final leagueRepository = VolleyballErgebnisseLeagueRepository();
  final gameRepository = VolleyballErgebnisseGameRepository();
  final teamRepository = VolleyballErgebnisseTeamRepository();
  final favoriteLeaguesRepository =
      VolleyballErgebnisseFavoriteLeaguesRepository();

  int primaryColorHex = 0xFFd02f26;
  Map<int, Color> color = {
    50: Color(0xffd02f26),
    100: Color(0xffbb2a22),
    200: Color(0xffa6261e),
    300: Color(0xff92211b),
    400: Color(0xff7d1c17),
    500: Color(0xff7d1c17),
    600: Color(0xff53130f),
    700: Color(0xff3e0e0b),
    800: Color(0xff2a0908),
    900: Color(0xff150504),
  };

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TenantRepository>.value(
          value: tenantRepository,
        ),
        RepositoryProvider<ClassRepository>.value(
          value: classRepository,
        ),
        RepositoryProvider<DistrictRepository>.value(
          value: districtRepository,
        ),
        RepositoryProvider<LeagueRepository>.value(
          value: leagueRepository,
        ),
        RepositoryProvider<GameRepository>.value(
          value: gameRepository,
        ),
        RepositoryProvider<TeamRepository>.value(
          value: teamRepository,
        ),
        RepositoryProvider<FavoriteLeaguesRepository>.value(
          value: favoriteLeaguesRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TenantsBloc(
              RepositoryProvider.of<TenantRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => ClassesBloc(
              RepositoryProvider.of<ClassRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => DistrictsBloc(
              RepositoryProvider.of<DistrictRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => LeaguesBloc(
              RepositoryProvider.of<LeagueRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => GamesBloc(
              RepositoryProvider.of<GameRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => TeamsBloc(
              RepositoryProvider.of<TeamRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => FavoriteLeaguesBloc(
              RepositoryProvider.of<FavoriteLeaguesRepository>(context),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VolleyballErgebnisse',
          theme: ThemeData(
            primarySwatch: MaterialColor(primaryColorHex, color),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(primaryColorHex),
            ),
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
