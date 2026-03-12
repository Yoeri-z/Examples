import 'package:flutter/material.dart';
import 'package:pocketbase_helpers_demo/generated/models.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.title});

  final String title;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final List<Note> notes = [];

  Note? selected;
  @override
  void initState() {
    super.initState();

    _initialLoad();
  }

  void _initialLoad() async {
    notes.addAll(await Notes.api().getFullList());
    if (mounted) setState(() {});
  }

  void addNote() async {
    final note = await showDialog<Note>(
      context: context,
      builder: (_) => NoteDialog(),
    );

    if (note != null) notes.add(note);

    setState(() {});
  }

  void deleteSelected() {
    if (selected == null) return;
    Notes.api().delete(selected!.id);
    notes.remove(selected);
    selected = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 300,
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(notes[index].title),
                subtitle: Text(
                  MaterialLocalizations.of(
                    context,
                  ).formatShortDate(notes[index].created),
                ),
                onTap: () => setState(() {
                  selected = notes[index];
                }),
              ),
            ),
          ),
          VerticalDivider(),
          if (selected == null)
            Expanded(child: Center(child: Text('No note selected')))
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 8,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text(
                          selected!.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: deleteSelected,
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TextFormField(
                        key: ValueKey(selected!.id),
                        initialValue: selected!.content,
                        onChanged: (value) async {
                          final note = await Notes.api().update(
                            selected!.copyWith(content: value),
                          );

                          final replaceIndex = notes.indexWhere(
                            (note) => note.id == selected!.id,
                          );

                          notes[replaceIndex] = note;

                          if (mounted) setState(() {});
                        },
                        textAlignVertical: .top,
                        expands: true,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNote,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteDialog extends StatefulWidget {
  const NoteDialog({super.key});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final formKey = GlobalKey<FormState>();

  String noteTitle = '';

  void _onSave() async {
    if (!formKey.currentState!.validate()) return;
    final note = await Notes.api().create(data: {'title': noteTitle});

    if (mounted) Navigator.of(context).pop(note);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: SizedBox(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: .min,
              children: [
                TextFormField(
                  onChanged: (value) => noteTitle = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Value can't be empty";
                    }

                    return null;
                  },
                ),

                FilledButton(onPressed: _onSave, child: Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
