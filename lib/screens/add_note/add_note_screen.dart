import 'package:flutter/material.dart';
import 'package:knot/provider/notes/notes_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Note'),
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
                            provider.addNote(title.text, desc.text);
                          }
                        },
                        child: Text('Save note')
                    );
                  }
              )
            ],
          ),
        )
    );
  }
}
