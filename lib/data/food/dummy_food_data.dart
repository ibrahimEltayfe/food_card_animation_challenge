import 'package:animation_ui/constants/app_colors.dart';
import 'package:animation_ui/constants/app_images.dart';

import 'food_model.dart';

List<FoodModel> food = [
   FoodModel(
       name: 'Grilled Chicken With Salad',
       description: "a delicious plate of grilled chicken with salad",
       price: 13.00,
       image: AppImages.plate1,
       bgColor: AppColors.cyan
   ),

  FoodModel(
      name: 'Grilled Meat With Fries',
      description: "a delicious plate of grilled meat and baked potato wedges",
      price: 16.00,
      image: AppImages.plate2,
      bgColor: AppColors.orange
  ),

  FoodModel(
      name: 'Grilled Meat With Salad',
      description: "a delicious plate of grilled meat with salad",
      price: 14.00,
      image: AppImages.plate3,
      bgColor: AppColors.red
  ),
];