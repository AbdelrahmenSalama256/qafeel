import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/onboaring_model.dart';
import 'onboaring_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial()) {
    pageController = PageController(viewportFraction: 1);
    currentPage = 0;
  }

  late final PageController pageController;
  int currentPage = 0;

  void onPageChanged(int page) {
    currentPage = page;
    emit(OnboardingPageChanged(page));
  }

  void disposeControllers() {
    pageController.dispose();
  }

  Future<void> precacheImages(BuildContext context) async {
    final slides = [
      OnboardModel(
        image: 'assets/images/png/onbb-1.png',
        title: 'onboarding_title1',
        subtitle: 'onboarding_subtitle1',
      ),
      OnboardModel(
        image: 'assets/images/png/onbb-2.png',
        title: 'onboarding_title2',
        subtitle: 'onboarding_subtitle2',
      ),
      OnboardModel(
        image: 'assets/images/png/shape.png',
        title: 'onboarding_title3',
        subtitle: 'onboarding_subtitle3',
        isLast: true,
      ),
    ];
    for (final s in slides) {
      final img = s.image;
      if (img != null && img.toLowerCase().endsWith('.png')) {
        final image = AssetImage(img);
        await precacheImage(image, context);
      }
    }
  }
}
