part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitialState extends AppState {}

class AppChangeBottomNavBarState extends AppState {}
class AppChangeBottomSheetState extends AppState {}

class AppCreatDatabaseState extends AppState {}
class AppGetDatabaseState extends AppState {}
class AppGetDatabaseLoadingState extends AppState {}
class AppInsertDatabaseState extends AppState {}
class AppUpdateDatabaseState extends AppState {}
class AppDeleteFromDatabaseState extends AppState {}

