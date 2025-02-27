import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thing_easy/blocs/add_form/add_form_event.dart';
import 'package:thing_easy/blocs/add_form/add_form_state.dart';
import 'package:thing_easy/models/task_model.dart';
import 'package:thing_easy/services/firebase_db_services.dart';

class AddFormBloc extends Bloc<AddFormEvent, AddFormState> {
  final List<SubTask> subTasks = [];
  bool status = false;

  resetAboveValues() {
    subTasks.clear();
    status = false;
  }

  AddFormBloc() : super(InitialAddFormState(status: false, subTasks: [])) {
    on<AddTaskEvent>(_addTaskEvent);
    on<UpdateStatusEvent>(_updateStateEvent);
    on<AddSubTaskEvent>(_addSubTaskEvent);
    on<UpdateSubTaskStatusEvent>(_updateSubTaskStatusEvent);
    on<UpdateSubTaskTitleEvent>(_updateSubTaskTitleEvent);
    on<DeleteSubTaskEvent>(_deletSubTaskEvent);
    on<ResetAddFormEvent>(_resetAddFormEvent);
  }

  void _updateStateEvent(UpdateStatusEvent event, Emitter<AddFormState> emit) {
    status = event.status;
    emit(StatusFormState(status: status));
  }

  void _addSubTaskEvent(AddSubTaskEvent event, Emitter<AddFormState> emit) {
    subTasks.add(SubTask(title: "", status: false));
    emit(SubTaskListFormState(subTasks: subTasks));
  }

  void _updateSubTaskStatusEvent(
    UpdateSubTaskStatusEvent event,
    Emitter<AddFormState> emit,
  ) {
    final removedItem = subTasks.removeAt(event.index);
    final newSubTask = SubTask(title: removedItem.title, status: event.status);
    subTasks.insert(event.index, newSubTask);
    emit(SubTaskListFormState(subTasks: subTasks));
  }

  void _updateSubTaskTitleEvent(
    UpdateSubTaskTitleEvent event,
    Emitter<AddFormState> emit,
  ) {
    final removedItem = subTasks.removeAt(event.index);
    final newSubTask = SubTask(title: event.title, status: removedItem.status);
    subTasks.insert(event.index, newSubTask);
    emit(SubTaskListFormState(subTasks: subTasks));
  }

  void _deletSubTaskEvent(
    DeleteSubTaskEvent event,
    Emitter<AddFormState> emit,
  ) {
    subTasks.removeAt(event.index);
    emit(SubTaskListFormState(subTasks: subTasks));
  }

  void _resetAddFormEvent(ResetAddFormEvent event, Emitter<AddFormState> emit) {
    resetAboveValues();
    emit(InitialAddFormState(status: status, subTasks: subTasks));
  }

  void _addTaskEvent(AddTaskEvent event, Emitter<AddFormState> emit) async {
    final TaskModel taskModel = TaskModel(
      title: event.title,
      desc: event.desc,
      deadline: event.deadline,
      status: status,
      subTasks: subTasks,
    );
    await FirebaseDbServices.createTask(taskModel);
    resetAboveValues();
    emit(InitialAddFormState(status: status, subTasks: subTasks));
  }
}
