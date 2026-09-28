import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/models/note_model.dart';

class NoteRepository {
  final SupabaseClient _supabase;

  NoteRepository(this._supabase);

  Future fetchNotes() async {
    final response =  await _supabase.from('notes').select().order('created_at', ascending: false);

    return (response as List).map((json) => NoteModel.fromJson(json)).toList();
  }

  Future addNote(String title, String content) async {
    await _supabase.from('notes').insert({'title': title, 'content': content,});
  }

  Future deleteNote (String id) async {
    await _supabase.from('notes').delete().eq('id', id);
  }
}