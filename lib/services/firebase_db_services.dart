import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thing_easy/models/task_collection_model.dart';
import 'package:thing_easy/models/task_model.dart';

class FirebaseDbServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Create Task Collection in firebase db.
  static Future<Map> createTaskCollection(
    TaskCollectionModel taskCollectionModel,
  ) async {
    try {
      final CollectionReference taskCollections = firestore.collection(
        "taskCollections",
      );
      final Map taskCollection = taskCollectionModel.toMap();
      taskCollection["user"] = FirebaseAuth.instance.currentUser!.uid;

      final DocumentReference? doc = await taskCollections.add(taskCollection);

      if (doc != null) {
        return {"status": true, "message": "task Collection is created"};
      }
      return {"status": false, "message": "taskCollectoin is failed"};
    } catch (e) {
      return {"status": false, "message": "taskCollection e failed"};
    }
  }

  /// return true if collectionName exist otherwise false
  static Future<bool> checkTaskCollectionIsExistOrNot(
    String collectionName,
  ) async {
    final CollectionReference taskCollections = firestore.collection(
      "taskCollections",
    );

    final res = await taskCollections
        .where('collectionName', isEqualTo: collectionName)
        .get()
        .then(
          (querySnapshot) {
            if (querySnapshot.docs.isEmpty) {
              return false;
            }
            return true;
          },
          onError: (e) {
            return false;
          },
        );
    return res;
  }

  static Future<Map> createTask(TaskModel taskModel) async {
    try {
      final isTaskCollection = await checkTaskCollectionIsExistOrNot(
        taskModel.collectionName,
      );

      /// create a taskCollection If not exist already
      if (!isTaskCollection) {
        final TaskCollectionModel taskCollectionModel = TaskCollectionModel(
          collectionName: taskModel.collectionName,
        );
        await createTaskCollection(taskCollectionModel);
      }

      /// Create a tasks collection and add task on it.
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

  /// Delete a task based on id
  static Future<void> deleteTask(String id) async {
    final CollectionReference tasks = firestore.collection("tasks");
    await tasks.doc(id).delete();
  }
}
