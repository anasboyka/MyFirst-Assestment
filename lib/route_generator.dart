import 'package:flutter/material.dart';
import 'package:map_exam/data/model/note.dart';
import 'package:map_exam/logic/provider/note_provider.dart';
import 'package:map_exam/view/home_page/edit_screen.dart';
import 'package:map_exam/view/wrapper_startup.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WrapperStartup());
      case '/editscreen':
        return MaterialPageRoute(builder: (_) {
          Map<String, dynamic> data = args as Map<String, dynamic>;
          return ChangeNotifierProvider.value(
            value: data['provider'] as NoteProvider,
            child: EditScreen(
              note: data['note'] as Note?,
            ),
          );
        });
      default:
        return MaterialPageRoute(builder: (_) => WrapperStartup());
    }
  }
}
