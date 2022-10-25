import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';


Widget defTextEditing({
  required TextEditingController controller,
  required String? Function(String? v) validate,
  void Function()? onTap,
  void Function(String v)? onChanged,
  void Function(String v)? onSubmit,
  type = TextInputType.text,
  IconData? suffix,
  void Function()? suffixPressed,
  required bool isPassword,
  required String label,
  required IconData prefix,
}) =>
    TextFormField(
      keyboardType: type,
      validator: validate,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: isPassword ,
      onFieldSubmitted:onSubmit,

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(
          label,
        ),
        prefixIcon: Icon(
            prefix
        ),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix
          ),

        ),
      ),
    );

Widget defaultButton({
  required void Function()? onPressed,
  Color borderSideColor = defaultColor,
  Color background = defaultColor,
  double? width,
  required String text,
  required BuildContext context,
  required isUpper
})=>SizedBox(
    width: width,
    height: 60,
    child:MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side:BorderSide(color: borderSideColor)
      ),
      color: background,
      child: Text(
        isUpper?text.toUpperCase():text,
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1?.color,
            fontSize: 20,
            fontWeight: FontWeight.normal,
        ),

      ),
    )
);

Widget defaultTextButton({
  required String text,
  Color textColor = defaultColor,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.normal,
  AlignmentGeometry? align = Alignment.center,
  void Function()? onPressed,
  bool isUpper = false
})=>TextButton(
    onPressed: onPressed,

    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      alignment: align,
    ),
    child:Text(
      isUpper?text.toUpperCase():text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight
      ),
    )
);

Future navigateAndFinish({
  required BuildContext context,
  required Widget route
})=>Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (context)=>route
), (route) => false);

Future navigate({
  required BuildContext context,
  required Widget route,
})=>Navigator.push(
    context,
    MaterialPageRoute(
        builder:(context)=>route
    )
);


Future<bool?> toast({
  required String msg,
  required ToastStates state,

})=> Fluttertoast.showToast(
msg: msg,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: changeToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates{success,error,warning}
Color? changeToastColor(ToastStates state){
  if(state == ToastStates.success){
    return Colors.green;
  }
  if(state == ToastStates.error){
    return Colors.red;
  }
  if(state == ToastStates.warning){
    return Colors.amber;
  }
  return null;
}

PreferredSizeWidget? defaultAppBar({
  String? title,
  List<Widget>? actions,
  IconData? leading = Icons.arrow_back_ios,
  VoidCallback? leadingOnPressed
})=>AppBar(
  title:title != null? Text(title):Container(),
  titleSpacing: 5,
  actions: actions,
  leading: IconButton(
    icon: Icon(
      leading
    ),
    onPressed:leadingOnPressed,
  ),
);

