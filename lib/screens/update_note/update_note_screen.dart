import 'package:flutter/material.dart';
import 'package:knot/models/note_model.dart';
import 'package:provider/provider.dart';

import '../../provider/notes/notes_provider.dart';

class UpdateNoteScreen extends StatefulWidget {
  final NoteModel note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    title.text = widget.note.title;
    desc.text = widget.note.desc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Note'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value== null || value.isEmpty){
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: desc,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value== null || value.isEmpty){
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              Consumer<NotesProvider>(
                  builder: (context, provider,child) {
                    return provider.loading? Center(child: CircularProgressIndicator()) :
                    ElevatedButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            provider.updateNote(title.text,desc.text, widget.note.id);
                          }
                        },
                        child: Text('Update note')
                    );
                  }
              )
            ],
          ),
        )
    );
  }
}
