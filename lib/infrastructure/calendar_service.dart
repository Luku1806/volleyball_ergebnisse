import 'package:flutter/material.dart';
import 'package:handball_ergebnisse/domain/game.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';
import 'package:permission_handler/permission_handler.dart';

class CalendarService {
  static final CalendarPlugin _calendarPlugin = CalendarPlugin();

  static Future<bool> addGames(BuildContext context, List<Game> games) async {
    if (!await Permission.calendar.request().isGranted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Berechtigungen benötigt"),
          content: Text(
              "Um Spiele zum Kalender hinzuzufügen muss die App die nötigen Berechtigungen für den Zugriff auf den Kalender haben."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Schließen"),
            )
          ],
        ),
      );
      return false;
    }

    final calendars = await _calendarPlugin.getCalendars();
    final calendarId = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Kalender wählen"),
        children: calendars!
            .map(
              (calendar) => ListTile(
                title: Text(calendar.name!),
                subtitle: Text(calendar.accountName!),
                onTap: () => Navigator.of(context).pop(calendar.id!),
              ),
            )
            .toList(),
      ),
    );

    if (calendarId == null) {
      return false;
    }

    final events = games.map(toEvent);
    for (CalendarEvent event in events) {
      await _calendarPlugin.createEvent(calendarId: calendarId, event: event);
    }

    return true;
  }

  static CalendarEvent toEvent(Game game) {
    return CalendarEvent(
      title: "${game.team1.name} vs ${game.team2.name}",
      description: 'Importiert aus Volleyball Ergebnisse',
      startDate: game.startTime,
      endDate: game.startTime.add(Duration(hours: 2)),
      location:
          '${game.gymnasium.name}, ${game.gymnasium.street}, ${game.gymnasium.zip} ${game.gymnasium.city}',
    );
  }
}
