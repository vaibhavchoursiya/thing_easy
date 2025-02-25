import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thing_easy/models/task_model.dart';

class FirebaseDbServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<Map> createTask(TaskModel taskModel) async {
    try {
      final CollectionReference tasks = firestore.collection("tasks");
      final Map task = taskModel.toMap();
      task["user"] = FirebaseAuth.instance.currentUser!.uid;

      final DocumentReference? doc = await tasks.add(task);
      if (doc != null) {
        return {"status": true, "message": "task is created"};
      }
      return {"status": false, "message": "task failed"};
    } catch (e) {
      return {"status": false, "message": "task e failed"};
    }
  }

  static Future<void> deleteTask(String id) async {
    final CollectionReference tasks = firestore.collection("tasks");
    await tasks.doc(id).delete();
  }
}
