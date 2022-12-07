import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';

import 'Bloc/bloc_observer.dart';


void main(){
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
 const  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        'homeScreen':(context) => HomeScreen(),
      },
    );
  }
}
