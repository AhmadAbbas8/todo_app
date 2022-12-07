import 'package:flutter/material.dart';

class CusTextFormFeild extends StatelessWidget {
  TextInputType? txtType ;
  TextEditingController? textEditingController ;
  String? lable ;
  IconData? prefixIcon;
  VoidCallback ? onTap;


   CusTextFormFeild({ this.textEditingController, this.lable, this.prefixIcon, this.txtType ,this.onTap}  ) ;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      keyboardType: txtType,
      controller: textEditingController,
      validator: (value){
        if(value!.isEmpty)
          return 'requierd';
        else
          return null;
      },
      decoration: InputDecoration(

        label: Text(lable!),
        prefixIcon: Icon(prefixIcon),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
