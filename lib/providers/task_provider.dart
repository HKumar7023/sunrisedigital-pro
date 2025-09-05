import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> get completedTasks => 
      _tasks.where((task) => task.isCompleted).toList();

  List<Task> get incompleteTasks => 
      _tasks.where((task) => !task.isCompleted).toList();

  int get totalTasks => _tasks.length;
  int get completedTasksCount => completedTasks.length;
  int get incompleteTasksCount => incompleteTasks.length;

  void addTask(String title, String description) {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      createdAt: DateTime.now(),
    );
    
    _tasks.insert(0, task); // Add new tasks at the beginning
    notifyListeners();
  }

  void toggleTaskCompletion(String taskId) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(
        isCompleted: !_tasks[taskIndex].isCompleted,
      );
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void updateTask(String taskId, String title, String description) {
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(
        title: title.trim(),
        description: description.trim(),
      );
      notifyListeners();
    }
  }

  void clearCompletedTasks() {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }

  void clearAllTasks() {
    _tasks.clear();
    notifyListeners();
  }
}
