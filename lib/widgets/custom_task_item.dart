import 'package:flutter/material.dart';
import 'package:todo_app/Bloc/app_cubit.dart';

class CusTaskItem extends StatelessWidget {
  Map? model;

  CusTaskItem({this.model});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model!['id'].toString()) ,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                model!['time'],
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model!['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model!['date'],
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 7,
            ),
            IconButton(
                onPressed: ()async {
               int res = await   AppCubit.get(context).updateDataFromDatabase(status: 'done', id: model!['id']);
                  print('$res updated done succefuly * * * * ** ');
                },
                icon: Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: ()async {

          int res = await   AppCubit.get(context).updateDataFromDatabase(status: 'archive', id: model!['id']);
          print('$res updated archive succefuly * * * * ** ');

        },
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.black,
                )),
          ],
        ),
      ),
      onDismissed:(direction) {
      AppCubit.get(context).deleteFromDatabase(id: model!['id']);
      } ,
    );
  }
}
