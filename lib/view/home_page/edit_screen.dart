import 'package:flutter/material.dart';
import 'package:map_exam/data/model/note.dart';
import 'package:map_exam/logic/provider/note_provider.dart';
import 'package:map_exam/view/home_page/home_screen.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  // static Route route() => MaterialPageRoute(builder: (_) => const EditScreen());
  final Note? note;
  const EditScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController(text: widget.note?.title);
    _descriptionController = TextEditingController(text: widget.note?.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Consumer<NoteProvider>(builder: (_, model, child) {
          return Text(model.getAppbarTitle());
        }),
        actions: [
          Consumer<NoteProvider>(builder: (_, model, child) {
            return model.mode != "View"
                ? IconButton(
                    icon: const Icon(
                      Icons.check_circle,
                      size: 30,
                    ),
                    onPressed: () async {},
                  )
                : const SizedBox();
          }),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Consumer<NoteProvider>(builder: (_, model, child) {
              return TextFormField(
                controller: _titleController,
                enabled: model.mode != "View",
                decoration: const InputDecoration(
                  hintText: 'Type the title here',
                ),
                onChanged: (value) {},
              );
            }),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Consumer<NoteProvider>(builder: (_, model, child) {
                return TextFormField(
                    controller: _descriptionController,
                    enabled: model.mode != "View",
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      hintText: 'Type the description',
                    ),
                    onChanged: (value) {});
              }),
            ),
          ],
        ),
      ),
    );
  }
}
