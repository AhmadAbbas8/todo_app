import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../configuration/sql_db.dart';
import '../widgets/archive_tasks_widget.dart';
import '../widgets/done_tasks_widget.dart';
import '../widgets/new_task_widget.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map> tasks = [];
  List<Map> newTtasks = [];
  List<Map> doneTtasks = [];
  List<Map> archiveTtasks = [];
  int currentIndex = 0;
  List screens = [
    NewTaskWidget(),
    DoneTasksWidget(),
    ArchiveTasksWidget(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];
  SqlDB sqldb = SqlDB();
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  readData() async {
    List<Map> response = await sqldb.readData("SELECT * FROM tasks");
    // print(response);
    newTtasks = [] ;
    doneTtasks = [] ;
    archiveTtasks = [];
    tasks = response;
    print(tasks);
    tasks.forEach((element) {
    if(element['status'] == 'new')
      newTtasks.add(element);
    else if(element['status'] == 'done')
      doneTtasks.add(element);
    else
      archiveTtasks.add(element);
    });
    emit(AppGetDatabaseState());
  }

  void creatDatabase() async {
    var res = await sqldb.db;
    print('$res data base with bloc state * * * * ');
    emit(AppCreatDatabaseState());
  }

  Future<int> insertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    var res = await sqldb.insert('tasks', {
      'title': title,
      'date': date,
      'time': time,
      'status': 'new',
    });
    emit(AppInsertDatabaseState());
    readData();
    return res;
  }

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  Future<int> updateDataFromDatabase({required String status, required int id}) async {
  int res =  await sqldb.update(
        'tasks',
        {
          'status': status,
        },
        'id = $id',
    );
  emit(AppUpdateDatabaseState());
  readData();

  return res ;
  }
  Future<int> deleteFromDatabase({required int id})async{
   int res = await sqldb.delete('tasks', 'id = $id');
emit(AppDeleteFromDatabaseState());
  readData();
   return res ;
  }

}
