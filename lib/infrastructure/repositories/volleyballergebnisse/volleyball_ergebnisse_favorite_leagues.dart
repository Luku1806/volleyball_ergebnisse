import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:volleyball_ergebnisse/domain/repositories/favorite_leagues.dart';
import 'package:volleyball_ergebnisse/infrastructure/repositories/shared_pref_favorite_leagues.dart';

import '../../../domain/league.dart';
import 'api_http_client.dart';

class VolleyballErgebnisseFavoriteLeaguesRepository
    implements FavoriteLeaguesRepository {
  final SharedPrefFavoriteLeaguesRepository
      _sharedPrefFavoriteLeaguesRepository =
      SharedPrefFavoriteLeaguesRepository();

  Future<String?> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.androidId;
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info.identifierForVendor;
    } else if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return info.machineId;
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return info.systemGUID;
    }

    throw UnsupportedError('Unsupported platform');
  }

  Future<void> migrateFromSharedPrefs() async {
    final existing = await _sharedPrefFavoriteLeaguesRepository.getAll();

    for (final league in existing) {
      await add(league);
      await _sharedPrefFavoriteLeaguesRepository.remove(league.id);
    }
  }

  @override
  Future<List<League>> getAll() async {
    final deviceId = await _getDeviceId();

    await migrateFromSharedPrefs();

    final client = VolleyballErgebnisseApiHttpClient();
    final response = await client.get(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/favorites/$deviceId',
      ),
    );

    return jsonDecode(
      utf8.decode(response.bodyBytes),
    )["leagues"]
        .map<League>((league) => League.fromJson(league))
        .toList();
  }

  @override
  Future<void> add(League league) async {
    final deviceId = await _getDeviceId();

    final client = VolleyballErgebnisseApiHttpClient();

    await client.post(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/favorites/$deviceId',
      ),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(league.toJson()),
    );
  }

  @override
  Future<void> remove(int leagueId) async {
    final deviceId = await _getDeviceId();

    final client = VolleyballErgebnisseApiHttpClient();
    await client.delete(
      Uri.parse(
        '${VolleyballErgebnisseApiHttpClient.BASE_URL}/favorites/$deviceId/$leagueId',
      ),
    );
  }
}
