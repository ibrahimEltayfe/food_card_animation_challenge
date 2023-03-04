import 'package:animation_ui/data/restaurants/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../data/restaurants/dummy_restaurants_data.dart';

class RestaurantsCards extends StatelessWidget {
  const RestaurantsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.142.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Restaurants",
            style: getBoldTextStyle(
              color: AppColors.semiBlack,
              fontSize: 16
            ),
          ),

          SizedBox(height: 2.h,),

          Expanded(
            child: ListView.separated(
              clipBehavior: Clip.none,
              padding: EdgeInsets.symmetric(vertical: 6.h),
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              separatorBuilder: (_, index) => SizedBox(width: 10.w,),
              itemBuilder: (_, index) {
                return _BuildRestaurantCard(restaurants[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildRestaurantCard extends StatelessWidget {
  final RestaurantModel restaurantModel;
  const _BuildRestaurantCard(this.restaurantModel,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: 74.w,
        height: 45.h,
        padding: EdgeInsets.all(5.r),
        decoration: getRoundedDecoration(),
        child: Column(
          children: [
            SizedBox(height: 2.h,),

            Expanded(
              flex: 3,
              child: Image.asset(
                restaurantModel.image,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 6.h,),

            Expanded(
              flex: 1,
              child: FittedBox(
                child: Text(
                  restaurantModel.name,
                  style: getRegularTextStyle(),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

