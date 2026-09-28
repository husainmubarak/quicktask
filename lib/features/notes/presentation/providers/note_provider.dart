import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../repository/note_repository.dart';

final noteRepositoryProvider = Provider((ref) {
  return NoteRepository(Supabase.instance.client);
});

class NoteNotifier extends AsyncNotifier {
  @override
  Future build() async {
    return ref.read(noteRepositoryProvider).fetchNotes();
  }

  Future addNote(String title, String content) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(noteRepositoryProvider);
      await repo.addNote(title, content);
      return repo.fetchNotes();
    });
  }

  Future deleteNote(String id) async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(noteRepositoryProvider);
      await repo.deleteNote(id);
      return repo.fetchNotes();
    });
  }
}

final noteProvider = AsyncNotifierProvider(() {
  return NoteNotifier();
});