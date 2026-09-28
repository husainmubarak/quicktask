import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/models/todo_model.dart';

class TodoRepository {
  final SupabaseClient _supabase;

  TodoRepository(this._supabase);

  Future fetchTodos() async {
    final response = await _supabase
      .from('todos')
      .select()
      .order('created_at', ascending: false);

    return (response as List).map((json) => TodoModel.fromJson(json)).toList();
  }

  Future addTodo(String title) async {
    await _supabase.from('todos').insert({
      'title': title,
      'is_completed': false,
    });
  }

  Future toggleTodo(String id, bool isCompleted) async {
    await _supabase
    .from('todos')
    .update({'is_completed': isCompleted})
    .eq('id', id);
  }

  Future deleteTodo(String id) async {
    await _supabase
    .from('todos')
    .delete()
    .eq('id', id);
  }
}