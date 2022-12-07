import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Bloc/app_cubit.dart';
import 'package:todo_app/widgets/custom_text_form_feild.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _forKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..creatDatabase()
        ..readData(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) Navigator.pop(context);
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(

            key: _scaffoldKey,
            appBar: AppBar(

              title: Text(AppCubit.get(context)
                  .titles[AppCubit.get(context).currentIndex]),
            ),
            body: AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (cubit.isBottomSheetShown) {
                  if (_forKey.currentState!.validate()) {
                    var response = await cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    titleController.clear();
                    dateController.clear();
                    titleController.clear();
                    print(
                        '${response} insertion has been succefuly * * ** * * * ** * *  ');

                    cubit.isBottomSheetShown = !cubit.isBottomSheetShown;
                  }
                } else {
                  _scaffoldKey.currentState
                      ?.showBottomSheet(
                        elevation: 30,
                        (context) => Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Form(
                            key: _forKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CusTextFormFeild(
                                  txtType: TextInputType.text,
                                  textEditingController: titleController,
                                  prefixIcon: Icons.title,
                                  lable: 'Task title',
                                ),
                                SizedBox(height: 15),
                                CusTextFormFeild(
                                  onTap: () async {
                                    var time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    print(
                                        '${time!.format(context)} * * * ** * * ** * * * ** * * * * * *');
                                    timeController.text = time.format(context);
                                  },
                                  lable: 'Task Time',
                                  prefixIcon: Icons.watch_later_outlined,
                                  textEditingController: timeController,
                                  txtType: TextInputType.text,
                                ),
                                SizedBox(height: 15),
                                CusTextFormFeild(
                                  onTap: () async {
                                    var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-05-03'),
                                    );
                                    print(
                                        '${DateFormat.yMMMd().format(date!)} * * * ** * * ** * * * ** * * * * * *');
                                    dateController.text =
                                        DateFormat.yMMMd().format(date);
                                  },
                                  lable: 'Task Date',
                                  prefixIcon: Icons.calendar_month,
                                  textEditingController: dateController,
                                  txtType: TextInputType.datetime,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavyBar(
              backgroundColor: Colors.grey[200],
              // animationDuration: Duration(),
              selectedIndex: AppCubit.get(context).currentIndex,
              showElevation: true,
              // use this to remove appBar's elevation
              onItemSelected: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: [
                BottomNavyBarItem(
                  icon: Icon(Icons.menu),
                  title: Text('Tasks'),
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.check_circle), title: Text('Done')),
                BottomNavyBarItem(
                    icon: Icon(Icons.archive_outlined),
                    title: Text('Archived')),
              ],
            ),
          );
        },
      ),
    );
  }
}
