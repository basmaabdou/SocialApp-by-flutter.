import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/icon_broken.dart';

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue,
  bool isUpperCase=true,
  double raduis=0.0,
  required final function,
  required String text,
})=>
    Container(
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text ,
          style:  TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
    );

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword=false,
  required String labelText,
  required final validate,
  required IconData prefix,
  final  suffixPressed,
  final onChanged,
  final onSubmit,
  final suffix,
  final onTap,
  bool isEnabled=true,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onChanged:onChanged ,
  onFieldSubmitted: onSubmit,
  validator: validate,
  obscureText: isPassword,
  onTap: onTap,
  enabled: isEnabled,

  decoration: InputDecoration(
    labelText: labelText,
    border:  OutlineInputBorder(),
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
          suffix
      ),
    ) : null,

  ),

);

Widget defaultTextButton({
  required final  function ,
  required String text
})=>TextButton(
    onPressed: function,
    child: Text(text.toUpperCase())
);



Widget myDivider()=>Padding(
  padding:  EdgeInsetsDirectional.only(start: 10,end: 10),
  child:   Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);


void navigateTo(context,Widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>Widget)
);

void navigateFinish(context,Widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>Widget),
        (route) => false
);

void messageToast({
  required String msg,
  required ToastStates state
})=>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastStates{SUCCESS,ERROR,WARNING}

Color ChooseToastColor(ToastStates state){
  Color color;

  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;

}


