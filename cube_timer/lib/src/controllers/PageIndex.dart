import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageIndex extends GetxController {
  late PageController pageController = PageController();
  final _currentIndex = 0.obs; 
  final _isTimerRunning =  false.obs;
  int get currentIndex => _currentIndex.value;

  set currentIndex(int value){
    if(value < 0 ) {
    _currentIndex.value = 0;
    return;
   }
    _currentIndex.value = value;

  }
  bool get isTimerRunning => _isTimerRunning.value;
  set isTimerRunning(bool value) => _isTimerRunning.value = value;
  



  void changePage(int value){
    print('page to animate');
    pageController.animateToPage(value, duration: Duration(milliseconds: 450), curve: Curves.easeInOut);
    currentIndex = value;
    print('page animated');
  }
}