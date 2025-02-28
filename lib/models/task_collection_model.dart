class TaskCollectionModel {
  final String collectionName;

  TaskCollectionModel({required this.collectionName});

  toMap() {
    return {"collectionName": collectionName};
  }
}
