import 'package:flutter/material.dart';
import 'package:qafeel/features/intro/onboarding/view/widgets/slide.dart';

import '../../data/onboaring_model.dart';

class KeepAliveSlide extends StatelessWidget {
  final OnboardModel slide;
  const KeepAliveSlide({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return AutomaticKeepAliveClientMixinWrapper(child: Slide(slide: slide));
  }
}

class AutomaticKeepAliveClientMixinWrapper extends StatefulWidget {
  final Widget child;
  const AutomaticKeepAliveClientMixinWrapper({super.key, required this.child});
  @override
  State<AutomaticKeepAliveClientMixinWrapper> createState() =>
      _AutomaticKeepAliveClientMixinWrapperState();
}

class _AutomaticKeepAliveClientMixinWrapperState
    extends State<AutomaticKeepAliveClientMixinWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
