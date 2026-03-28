import 'package:flutter/material.dart';
import 'package:knot/models/note_model.dart';
import 'package:knot/provider/notes/notes_provider.dart';
import 'package:knot/utils/app_theme.dart';
import 'package:knot/utils/route_helper.dart';
import 'package:knot/widgets/empty_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotesProvider>().getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () =>
                Navigator.pushNamed(context, RouteHelper.account),
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, provider, child) {
          if (provider.loading && provider.notes.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.notes.isEmpty) {
            return EmptyState();
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 12),
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final note = provider.notes[index];
              return _NoteCard(note: note, provider: provider);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, RouteHelper.newNote),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final NoteModel note;
  final NotesProvider provider;

  const _NoteCard({required this.note, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(
          note.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppTheme.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              note.desc,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _formatDate(note.createdAt),
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary.withOpacity(0.7),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Colors.red.shade400,
          ),
          onPressed: () => _confirmDelete(context),
        ),
        onTap: () => Navigator.pushNamed(
          context,
          RouteHelper.updateNote,
          arguments: note,
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Note?'),
        content: Text('This note will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
            ),
            onPressed: () {
              Navigator.pop(context);
              provider.deleteNote(note);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}