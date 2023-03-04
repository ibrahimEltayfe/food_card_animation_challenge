import 'package:animation_ui/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onTap;
  const BottomNavBar({Key? key, required this.onTap}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final icons = [
    AppIcons.home,
    AppIcons.profile,
    AppIcons.list
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.075.sh,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight:  Radius.circular(15.r),
          ),
          boxShadow: [
            BoxShadow(
                color: AppColors.lightGrey,
                blurRadius: 6,
                offset: Offset(0,2.h)
            )
          ]
      ),

      child: Row(
          textDirection: TextDirection.rtl,
          children:[
            ...List.generate(icons.length, (i){
              return Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      currentIndex = i;
                    });

                    widget.onTap;
                  },
                  child: Icon(
                    icons[i],
                    color: currentIndex==i? AppColors.black : AppColors.mediumGrey,
                    size: 28.r,
                  ),
                ),
              );
            }),
          ]
      ),
    );
  }
}