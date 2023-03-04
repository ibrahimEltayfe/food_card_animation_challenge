import 'dart:async';
import 'dart:developer' as d;
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FoodCardAnimationHandler{
  final ScrollController scrollController = ScrollController();

  double rotateTurns = 0.3;
  int currentIndex = 0;
  bool isReverse = true;

  double foodCardWidth = 1;
  StreamController<double> plateAnimationController = StreamController<double>.broadcast();
  StreamController<int> textOpacityAnimationController = StreamController<int>.broadcast();


  //inputs
  Sink<double> get plateAnimationInput => plateAnimationController.sink;
  Sink<int> get textOpacityAnimationInput => textOpacityAnimationController.sink;

  //outputs
  Stream<double> get plateAnimationOutput => plateAnimationController.stream;
  Stream<int> get textOpacityAnimationOutput => textOpacityAnimationController.stream;

  //functions
  void init(){

    scrollController.addListener(() {
      final scrollPosition = scrollController.position.pixels;

      if(scrollPosition > 0){
        animateTextOpacity(scrollPosition);
      }

    });

  }

  void dispose(){
    plateAnimationController.close();
  }

  animateThePlate() async {
    d.log('animate');

    if (scrollController.position.userScrollDirection == ScrollDirection.forward) {

        if (rotateTurns == 0.3 || rotateTurns == 0) {
          rotateTurns = -0.3;
        } else if (rotateTurns == -0.3) {
          rotateTurns = 0;
        }

    } else if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (rotateTurns == 0.3) {
          rotateTurns = 0;
        } else {
          rotateTurns = 0.3;
        }
    }

    plateAnimationInput.add(rotateTurns);

  }

  animateTextOpacity(double scrollPosition){
    if(scrollController.position.userScrollDirection == ScrollDirection.reverse){
      if(!isReverse){
        currentIndex+=2;
        isReverse = true;
        return;
      }
      if(currentIndex* foodCardWidth < scrollPosition+0.25.sw){
        animateThePlate();

        textOpacityAnimationInput.add(currentIndex);
        currentIndex++;
      }

    }else if(scrollController.position.userScrollDirection == ScrollDirection.forward){
      if(isReverse){
        currentIndex-=2;
        isReverse = false;
        return;
      }

      if((currentIndex* foodCardWidth) > scrollPosition-0.2.sw && currentIndex >= 0){
        animateThePlate();

        textOpacityAnimationInput.add(currentIndex);
        currentIndex--;
      }
    }

  }

}