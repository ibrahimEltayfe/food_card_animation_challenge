import 'dart:developer';

import 'package:animation_ui/constants/app_colors.dart';
import 'package:animation_ui/constants/app_icons.dart';
import 'package:animation_ui/constants/app_styles.dart';
import 'package:animation_ui/data/restaurants/dummy_restaurants_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/food_cards.dart';
import '../widgets/restaurant_cards.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTap: (i) {

        },
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 6.w),

          children: [
            SizedBox(
              height: 10.h,
            ),

            const _BuildSearchBar(),

            SizedBox(
              height: 20.h,
            ),

            const RestaurantsCards(),

            SizedBox(
              height: 16.h,
            ),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Most\n",
                    style: getBoldTextStyle(
                      color: AppColors.black,
                      fontSize: 28
                    ),
                  ),

                  TextSpan(
                     text: "Popular Food",
                     style: getRegularTextStyle(
                      color: AppColors.semiBlack,
                      fontSize: 28
                    )
                  ),
                ]
              ),
            ),

            SizedBox(
              height: 16.h,
            ),

            const FoodCards(),

          ],
        ),
      ),
    );
  }
}

class _BuildSearchBar extends StatelessWidget {
  const _BuildSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.072.sh,
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 15.w),
      decoration: getRoundedDecoration(
        bgColor: AppColors.white,
      ),

      child: Row(
        children: [
          Icon(
            AppIcons.search,
            size: 24.r,
            color: AppColors.semiBlack,
          ),

          SizedBox(width: 10.w,),

          Text(
            'search for beautiful plates',
            style: getBoldTextStyle(
               color: AppColors.lightGrey,
               fontSize: 15
            ),
          )
        ],
      ),

    );
  }
}

