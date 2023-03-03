import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/pages/Task_pages/cubit/states.dart';
import 'package:todo/services/DatabaseHelper.dart';
import '../../../models/taskModel.dart';

class AddTaskCubit extends Cubit<AddTaskStates> {
  AddTaskCubit() : super(IntialAddTskState());
  static AddTaskCubit get(context) => BlocProvider.of(context);

  var noteController = TextEditingController();
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var remindController = TextEditingController();
  var repeatController = TextEditingController();

  DateTime timeSelected = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(seconds: 15)))
      .toString();
  int selectedColor = 0;
  int selectedRemind = 1;
  String selectedRepeat = 'none';
  List<int> remindList = [1, 2, 3, 4, 5];
  List<String> selectedRepeatedList = [
    'none',
    'daily',
    'weakly',
    'monthly',
    'annully'
  ];
  List<TaskModel> tasks = [];
  List<TaskModel> search = [];
  final DatabaseHelper database = DatabaseHelper.instance;
  void changeRemindValue(String? value) {
    selectedRemind == int.parse(value!);
    remindController.text = value;
    emit(ChangingRemindState());
  }

  void changeRepeatValue(String? value) {
    selectedRepeat == value;
    repeatController.text = value!;
    emit(ChangingRepeatState());
  }

  void changeColorValue(int? index) {
    selectedColor == index;
    emit(ChangingColorState());
  }

  void getAllTasks() async {
    tasks = await database.getDatabase();
    print(tasks);
    emit(GettingDatabaseState());
  }

  Future<int> insertAllTasks(TaskModel model) async {
    return await database.insertToDatabase(model).then((value) {
      emit(InsertingDatabaseState());
      return value;
    });
  }

  void searchDatabase(String title) async {
    search = await database.searchOnDatabase(title);
    emit(SearchingDataBaseSuccessfully());
    print(search);
  }

  updateDatabase(int id, TaskModel model) async {
    return await database.updateDatabase(id, model).then((value) {
      getAllTasks();
      emit(UpdatingDatabaseSuccessfully());
    });
  }

  deleteDatabase(int id) async {
    return await database.deleteDatabase(id).then((value) {
      getAllTasks();
      emit(DeletingDatabaseSuccessfully());
    });
  }
}
