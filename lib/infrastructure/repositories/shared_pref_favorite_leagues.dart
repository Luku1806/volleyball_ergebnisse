import 'dart:convert';

import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/repositories/favorite_leagues.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefFavoriteLeaguesRepository extends FavoriteLeaguesRepository {
  static const _preferenceKey = "favorite_leagues";

  @override
  Future<void> add(League league) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final newFavorites = prefs.getStringList(_preferenceKey) ?? [];
    newFavorites.add(toSerializedLeague(league));

    await prefs.setStringList(_preferenceKey, newFavorites);
  }

  @override
  Future<void> remove(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final currentFavorites = prefs.getStringList(_preferenceKey) ?? [];

    final newFavorites =
        currentFavorites.map(toLeague).where((league) => league.id != id);

    await prefs.setStringList(
      _preferenceKey,
      newFavorites.map(toSerializedLeague).toList(),
    );
  }

  @override
  Future<List<League>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_preferenceKey)?.map(toLeague).toList() ?? [];
  }

  String toSerializedLeague(League league) {
    return json.encode(league.toJson());
  }

  League toLeague(String serializedLeague) {
    return League.fromJson(jsonDecode(serializedLeague));
  }
}
