import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/app_cubit.dart';
import 'custom_task_item.dart';
class ArchiveTasksWidget extends StatelessWidget {
  const ArchiveTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ListView.separated(

          separatorBuilder: (context, index) => Divider(thickness: 5),
          itemBuilder: (context, index) =>
              Row(
                children: [
                  CusTaskItem(model: cubit.archiveTtasks[index]),
                ],
              ),
          itemCount: cubit.archiveTtasks .length,

        );
      },
    );
  }
}
