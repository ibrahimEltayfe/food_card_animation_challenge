import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

TextStyle _getTextStyle(double fontSize, Color color,String fontFamily,TextDecoration? textDecoration,FontWeight? fontWeight){
  return TextStyle(
    fontFamily: fontFamily,
    fontSize: fontSize.sp,
    color: color,
    decoration: textDecoration,
    fontWeight: fontWeight,

  );
}

TextStyle getRegularTextStyle({
   double fontSize = 20,
   Color color = Colors.black,
   String fontFamily = 'sen',
   TextDecoration? textDecoration,
   FontWeight? fontWeight,
}) {
  return _getTextStyle(fontSize,color,fontFamily,textDecoration,fontWeight);
}

TextStyle getBoldTextStyle({
  double fontSize = 18,
  Color color = Colors.black,
  String fontFamily = 'sen',
  FontWeight fontWeight = FontWeight.bold,
  TextDecoration? textDecoration
}) {
  return _getTextStyle(fontSize,color,fontFamily,textDecoration,fontWeight);
}

//button styles
ButtonStyle getRegularButtonStyle({required Color bgColor,required double radius}){
  return ButtonStyle(
    elevation: MaterialStateProperty.all(0),
    backgroundColor: MaterialStateProperty.all<Color>(bgColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide.none
        )
    ),
    overlayColor:MaterialStateProperty.all<Color>(AppColors.white.withOpacity(0.05)),
  );
}

ButtonStyle getBorderedButtonStyle({required Size minSize,required Size maxSize}){
  return ButtonStyle(
      minimumSize: MaterialStatePropertyAll<Size>(minSize),
      maximumSize: MaterialStatePropertyAll<Size>(maxSize),

      backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
      ),
    shadowColor: const MaterialStatePropertyAll<Color>(AppColors.semiBlack),
    padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h))

  );
}

//container decorations
BoxDecoration getRoundedDecoration(
{
  double borderRadius = 20,
  double blurRadius = 8,
  Color bgColor = Colors.white
}
){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: AppColors.lightGrey,
        blurRadius: blurRadius.r,
        offset: Offset(0,2.h),
      ),
    ],
    color: bgColor,
  );
}
