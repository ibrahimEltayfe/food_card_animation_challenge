import 'dart:developer';
import 'dart:math';

import 'package:animation_ui/constants/app_colors.dart';
import 'package:animation_ui/constants/app_icons.dart';
import 'package:animation_ui/constants/app_images.dart';
import 'package:animation_ui/constants/app_styles.dart';
import 'package:animation_ui/controllers/food_card_animation_handler.dart';
import 'package:animation_ui/data/food/food_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/food/dummy_food_data.dart';

class FoodCards extends StatefulWidget {
  const FoodCards({Key? key}) : super(key: key);

  @override
  State<FoodCards> createState() => _FoodCardsState();
}

class _FoodCardsState extends State<FoodCards> {
  final FoodCardAnimationHandler foodCardAnimationHandler = FoodCardAnimationHandler();

  @override
  void initState() {
    super.initState();
    foodCardAnimationHandler.init();
  }

  @override
  void dispose() {
    foodCardAnimationHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.54.sh,
      child: ListView.separated(
        padding: EdgeInsets.only(right: 0.25.sw),
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          controller: foodCardAnimationHandler.scrollController,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, index) => SizedBox(width:10.w,),
          itemCount: food.length,
          itemBuilder: (context, index) {
            return _BuildFoodCard(
              foodModel: food[index],
              foodCardAnimationHandler : foodCardAnimationHandler,
              index: index,
            );
          },
      ),
    );
  }
}

class _BuildFoodCard extends StatelessWidget {
  final FoodModel foodModel;
  final FoodCardAnimationHandler foodCardAnimationHandler;
  final int index ;
  const _BuildFoodCard({
    Key? key,
    required this.foodModel,
    required this.foodCardAnimationHandler,
    required this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: foodCardAnimationHandler.textOpacityAnimationOutput,
        initialData: 0,
        builder: (context, snapshot) {
          final bool startAnim = index == snapshot.data;

          return ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: (1.sw >= 600) ? 0.20.sw : 0.25.sw,
                maxWidth: (1.sw >= 600) ? 0.26.sw : 0.45.sw,
                minHeight: (1.sw >= 600) ? 0.65.sh:0.54.sh,
                maxHeight: (1.sw >= 600) ? 0.75.sh:0.54.sh
            ),
            child: LayoutBuilder(
              builder: (_, size) {
                final double width;
                final double height;

                if(startAnim){
                  width = size.maxWidth;
                  height = size.maxHeight;
                }else{
                  width = size.maxWidth-size.maxWidth*0.13;
                  height = size.maxHeight-size.maxHeight*0.12;
                }

                foodCardAnimationHandler.foodCardWidth = width;

                return Stack(
                  alignment: Alignment.center,

                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      top: startAnim?height*0.14:height*0.2,
                      width: width,
                      height: height*0.7,
                      child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 6.h),
                            decoration: getRoundedDecoration(
                                bgColor: foodModel.bgColor,
                                borderRadius: 25
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 350),
                                  child: SizedBox(
                                    height: startAnim?height*0.16:height*0.21,
                                  ),
                                ),

                                _BuildFoodName(
                                  width:width,
                                  height:height,
                                  foodName:foodModel.name
                                ),

                                AnimatedSize(
                                  duration: const Duration(milliseconds: 350),
                                  child: SizedBox(
                                    height: startAnim?height*0.02:height*0.02,
                                  ),
                                ),
                               // SizedBox(height: 16.h,),

                                _BuildFoodDescription(
                                    width:width,
                                    height:height,
                                    foodDescription:foodModel.description,
                                    startAnim:startAnim
                                ),

                                SizedBox(height: 2.h,),

                                _BuildFoodPrice(
                                    width:width,
                                    height:height,
                                    foodPrice:foodModel.price,
                                    startAnim:startAnim
                                ),

                                Spacer(flex: 1,),

                              ],
                            ),

                          )
                    ),

                    _BuildPlate(
                        height: height,
                        width: width,
                        foodCardAnimationHandler:foodCardAnimationHandler,
                        isStartAnim : startAnim,
                        foodModel: foodModel,
                    ),

                    _AddToBagButton(
                      height: height,
                      width: width,
                      startAnim: startAnim,
                      foodCardAnimationHandler:foodCardAnimationHandler
                    ),

                  ],
                );
              },

            ),
          );
        }
    );
  }
}

class _BuildFoodPrice extends StatelessWidget {
  final double width;
  final double height;
  final double foodPrice;
  final bool startAnim;
  const _BuildFoodPrice({Key? key, required this.width, required this.height, required this.foodPrice,required this.startAnim}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 450),
        alignment: Alignment.topLeft,
        curve: Curves.decelerate,

        child: SizedBox(
          width: width,
          height: startAnim ?height*0.075:0,
          child: FittedBox(
            child: SizedBox(
              width: width,

              child: Text(
                "\$${foodPrice.toStringAsFixed(2)}",
                style: getBoldTextStyle(
                  color: AppColors.backgroundColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _BuildFoodDescription extends StatelessWidget {
  final double width;
  final double height;
  final String foodDescription;
  final bool startAnim;
  const _BuildFoodDescription({Key? key, required this.width, required this.height, required this.foodDescription,required this.startAnim}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedOpacity(
        opacity: startAnim ? 1 : 0,
        duration: const Duration(milliseconds: 450),

        child: AnimatedSize(
          duration: const Duration(milliseconds: 450),
          alignment: Alignment.topLeft,
          curve: Curves.decelerate,

          child: SizedBox(
            width: width,
            height: startAnim ?height*0.11:0,

            child: FittedBox(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: width,

                child: Text(
                  foodDescription,
                  style: getRegularTextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 12
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  //minFontSize: 0,

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildFoodName extends StatelessWidget {
  final double width;
  final double height;
  final String foodName;
  const _BuildFoodName({Key? key, required this.width, required this.height, required this.foodName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height*0.11,
      child: FittedBox(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: width,
          child: Text(
            foodName,
            style: getBoldTextStyle(
                color: AppColors.backgroundColor,
                fontSize: 20
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            // minFontSize: 0,
          ),
        ),
      ),
    );
  }
}


class _BuildPlate extends StatelessWidget {
  final double width;
  final double height;
  final FoodCardAnimationHandler foodCardAnimationHandler ;
  final bool isStartAnim;
  final FoodModel foodModel;
  const _BuildPlate({Key? key, required this.width, required this.height, required this.foodCardAnimationHandler, required this.isStartAnim, required this.foodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 200),
        top: isStartAnim?0:height*0.06,
        height: height * 0.32,
        width: width*0.82,
        child:AnimatedSlide(
          duration: const Duration(milliseconds: 350),
          curve: Curves.decelerate,
          offset: Offset(0,isStartAnim?-height*0.0002:height*0.0001),
          child: StreamBuilder<double>(
            stream: foodCardAnimationHandler.plateAnimationOutput,
            initialData: 0,
            builder: (context, snapshot) {
              return AnimatedRotation(
                curve: Curves.decelerate,
                duration: const Duration(milliseconds: 400),
                turns:snapshot.data ?? 0,
                child: Image.asset(
                  foodModel.image,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              );
            },

          ),
        )
    );
  }
}

class _AddToBagButton extends StatelessWidget {
  final double width;
  final double height;
  final bool startAnim;
  final FoodCardAnimationHandler foodCardAnimationHandler ;
  const _AddToBagButton({Key? key, required this.width, required this.height, required this.foodCardAnimationHandler, required this.startAnim}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 350),
      curve: Curves.decelerate,
      bottom: startAnim?height*0.18:height*0.26,
      right:startAnim? width*0.05:width*0.12,
      width: width*0.55,
      height: height*0.1,
      child: ElevatedButton(
        onPressed: (){
         //todo: add to bag
        },
        style: getBorderedButtonStyle(
            maxSize: Size(width*0.55,height*0.12),
            minSize: Size(width*0.1,height*0.12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 2.w,),

            const Expanded(
              child: FittedBox(
                  child: Icon(
                    AppIcons.cart,
                    color: AppColors.black,
                  )
              ),
            ),

            SizedBox(width: 5.w,),

            Expanded(
              flex: 3,
              child: FittedBox(
                child: Text(
                  "Add To Bag",
                  style: getBoldTextStyle(color: AppColors.semiBlack),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(
              width: 4.w,
            )
          ],
        ),
      ),
    );
  }
}
