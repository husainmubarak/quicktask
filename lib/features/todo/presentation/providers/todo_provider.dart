import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../repository/todo_repository.dart';

final todoRepositoryProvider = Provider((ref) {
  return TodoRepository(Supabase.instance.client);
});

class TodoNotifier extends AsyncNotifier {
  @override
  Future build() async {
    final repository = ref.read(todoRepositoryProvider);
    return repository.fetchTodos();
  }

  Future addTodo(String title) async {
    if (title.trim().isEmpty) return;
    
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.addTodo(title);
      return repository.fetchTodos();
    });
  }

  Future toggleTodo(String id, bool currentStatus) async {
    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.toggleTodo(id, !currentStatus);
      return repository.fetchTodos();
    });
  }

  Future deleteTodo(String id) async {
    state = await AsyncValue.guard(() async {
      final repository = ref.read(todoRepositoryProvider);
      await repository.deleteTodo(id);
      return repository.fetchTodos();
    });
  }
}


final todoProvider = AsyncNotifierProvider(() {
  return TodoNotifier();
});