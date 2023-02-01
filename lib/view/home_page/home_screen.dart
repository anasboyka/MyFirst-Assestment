import 'package:flutter/material.dart';
import 'package:map_exam/data/model/note.dart';
import 'package:map_exam/data/remote/firebase/auth.dart';
import 'package:map_exam/logic/provider/note_provider.dart';
import 'package:map_exam/view/home_page/edit_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomeScreen());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NoteProvider>(context, listen: false).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            child: Consumer<NoteProvider>(builder: (context, model, child) {
              return Text(
                model.notes.length.toString(), //'4',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 22.0),
              );
            }),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Consumer<NoteProvider>(builder: (_, model, child) {
        return ListView.separated(
          itemCount: model.notes.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.blueGrey,
          ),
          itemBuilder: (context, index) => ListTile(
            trailing: model.notes[index].showOption
                ? SizedBox(
                    width: 110.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            model.setMode('Edit');
                            Navigator.of(context).pushNamed(
                              '/editscreen',
                              arguments: {
                                'provider': Provider.of<NoteProvider>(context,
                                    listen: false),
                                'note': model.notes[index],
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            model.deleteNote(index);
                          },
                        ),
                      ],
                    ),
                  )
                : null,
            title: Text(model.notes[index].title ?? ""),
            subtitle: model.showContent
                ? Text(model.notes[index].content ?? "")
                : null,
            onTap: () {
              model.setMode('View');
              Navigator.of(context).pushNamed(
                '/editscreen',
                arguments: {
                  'provider': Provider.of<NoteProvider>(context, listen: false),
                  'note': model.notes[index],
                },
              );
            },
            onLongPress: () {
              model.toggleShowOptions(index);
            },
          ),
        );
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<NoteProvider>(builder: (context, model, child) {
            return FloatingActionButton(
                heroTag: null,
                child: Icon(model.showContent ? Icons.unfold_less : Icons.menu),
                tooltip: 'Show less. Hide notes content',
                onPressed: () {
                  model.toggleContent();
                });
          }),

          /* Notes: for the "Show More" icon use: Icons.menu */

          Consumer<NoteProvider>(builder: (_, model, child) {
            return FloatingActionButton(
              heroTag: null,
              child: const Icon(Icons.add),
              tooltip: 'Add a new note',
              onPressed: () async {
                model.setMode('Add');
                Navigator.of(context).pushNamed(
                  '/editscreen',
                  arguments: {
                    'provider':
                        Provider.of<NoteProvider>(context, listen: false),
                  },
                ).then((value) => print(model.notes.length));
              },
            );
          }),
        ],
      ),
    );
  }
}
