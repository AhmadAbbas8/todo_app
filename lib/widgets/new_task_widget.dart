import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Bloc/app_cubit.dart';
import 'package:todo_app/widgets/custom_task_item.dart';

class NewTaskWidget extends StatelessWidget {
  NewTaskWidget();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return cubit.newTtasks.length != 0
            ? ListView.separated(
                separatorBuilder: (context, index) => Divider(thickness: 5),
                itemBuilder: (context, index) => Row(
                  children: [
                    CusTaskItem(model: cubit.newTtasks[index]),
                  ],
                ),
                itemCount: cubit.newTtasks.length,
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 35,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No Tasks Yet 🙃,\nPlease Add Some Tasks 😃',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
