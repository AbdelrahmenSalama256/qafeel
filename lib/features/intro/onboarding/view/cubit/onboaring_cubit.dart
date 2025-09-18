import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'onboaring_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial()) {
    positionController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: ticker,
    );
    dotController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: ticker,
    );
    positionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: positionController,
        curve: Curves.easeOut,
      ),
    );
    dotAnimation = Tween<double>(begin: 0.0, end: -10.0).animate(
      CurvedAnimation(
        parent: dotController,
        curve: Curves.easeOut,
      ),
    );

    positionController.forward();
    dotController.forward().then((_) => dotController.reverse());
  }

  static late TickerProvider ticker;

  late final PageController pageController =
      PageController(viewportFraction: 1);
  late final AnimationController positionController;
  late final AnimationController dotController;
  late final Animation<double> positionAnimation;
  late final Animation<double> dotAnimation;

  int currentPage = 0;

  void onPageChanged(int page) {
    currentPage = page;
    emit(OnboardingPageChanged(page));
    positionController
      ..reset()
      ..forward();
    dotController.forward().then((_) => dotController.reverse());
  }

  void disposeControllers() {
    pageController.dispose();
    positionController.dispose();
    dotController.dispose();
  }
}
