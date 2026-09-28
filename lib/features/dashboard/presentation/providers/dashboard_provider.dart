// lib/features/dashboard/presentation/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../todo/presentation/providers/todo_provider.dart';
import '../../../notes/presentation/providers/note_provider.dart';

// Model sederhana untuk menampung statistik
class DashboardStats {
  final int totalPendingTodos;
  final int totalNotes;

  DashboardStats({
    required this.totalPendingTodos,
    required this.totalNotes,
  });
}

// Provider ini bergantung pada todoProvider dan noteProvider
final dashboardStatsProvider = Provider((ref) {
  // 1. Ambil data dari todoProvider menggunakan ref.watch
  final todosAsync = ref.watch(todoProvider);
  
  // 2. Ambil data dari noteProvider menggunakan ref.watch
  final notesAsync = ref.watch(noteProvider);

  // Ambil data jika sudah selesai loading, jika belum/error default ke list kosong
  final todos = todosAsync.value ?? [];
  final notes = notesAsync.value ?? [];

  // Hitung berapa todo yang belum selesai (isCompleted == false)
  final pendingTodosCount = todos.where((todo) => !todo.isCompleted).length;

  // Return objek statistik
  return DashboardStats(
    totalPendingTodos: pendingTodosCount,
    totalNotes: notes.length,
  );
});