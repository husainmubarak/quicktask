// lib/features/todo/presentation/screens/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item_card.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  void _showAddDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Tugas Baru'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nama tugas...'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = controller.text;
              Navigator.pop(context);
              await ref.read(todoProvider.notifier).addTodo(title);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // asyncTodos sekarang bertipe AsyncValue>
    final asyncTodos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickTask + Supabase'),
        centerTitle: true,
      ),
      // .when() mempermudah penanganan kondisi Loading, Error, dan Data
      body: asyncTodos.when(
        data: (todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('Belum ada tugas di database!'));
          }

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return TodoItemCard(
                todo: todo,
                onToggle: () {
                  ref.read(todoProvider.notifier).toggleTodo(todo.id, todo.isCompleted);
                },
                onDelete: () {
                  ref.read(todoProvider.notifier).deleteTodo(todo.id);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Terjadi Kesalahan: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}