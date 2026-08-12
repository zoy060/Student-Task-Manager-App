import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ------------------------------------------------------------
  // CURRENT USER
  // ------------------------------------------------------------

  String get _userId {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in.');
    }

    return user.uid;
  }

  // ------------------------------------------------------------
  // TASK COLLECTION
  // ------------------------------------------------------------

  CollectionReference<Map<String, dynamic>> get _tasksCollection {
    return _firestore.collection('tasks');
  }

  // ------------------------------------------------------------
  // GET USER TASKS
  // ------------------------------------------------------------

  Stream<QuerySnapshot<Map<String, dynamic>>> getTasks() {
    return _tasksCollection
        .where('userId', isEqualTo: _userId)
        .orderBy('dueDate')
        .snapshots();
  }

  // ------------------------------------------------------------
  // ADD TASK
  // ------------------------------------------------------------

  Future<void> addTask({
    required String title,
    required String description,
    required String subject,
    required DateTime dueDate,
    required String priority,
  }) async {
    await _tasksCollection.add({
      'userId': _userId,
      'title': title.trim(),
      'description': description.trim(),
      'subject': subject.trim(),
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ------------------------------------------------------------
  // UPDATE TASK
  // ------------------------------------------------------------

  Future<void> updateTask({
    required String taskId,
    required String title,
    required String description,
    required String subject,
    required DateTime dueDate,
    required String priority,
  }) async {
    await _tasksCollection.doc(taskId).update({
      'title': title.trim(),
      'description': description.trim(),
      'subject': subject.trim(),
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority,
    });
  }

  // ------------------------------------------------------------
  // MARK COMPLETE / INCOMPLETE
  // ------------------------------------------------------------

  Future<void> toggleTaskCompletion({
    required String taskId,
    required bool completed,
  }) async {
    await _tasksCollection.doc(taskId).update({
      'completed': completed,
    });
  }

  // ------------------------------------------------------------
  // DELETE TASK
  // ------------------------------------------------------------

  Future<void> deleteTask(String taskId) async {
    await _tasksCollection.doc(taskId).delete();
  }
}