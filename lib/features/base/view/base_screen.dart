import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qafeel/core/constants/app_colors.dart';
import 'package:qafeel/core/cubit/global_cubit.dart';
import 'package:qafeel/core/cubit/global_state.dart';
import 'package:qafeel/core/locale/app_loacl.dart';
import 'package:qafeel/features/home/view/home_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    Container(color: Colors.blue),
    Container(color: Colors.green),
    Container(color: Colors.yellow),
  ];

  @override
  void initState() {
    super.initState();
    context.read<GlobalCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        final cubit = context.read<GlobalCubit>();
        return Scaffold(
          body: Stack(
            children: [
              screens[cubit.currentNavIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                          0,
                          'assets/images/svg/nav/home.svg',
                          'assets/images/svg/nav/hom-active.svg',
                          "home".tr(context)),
                      _buildNavItem(
                          1,
                          'assets/images/svg/nav/add-car.svg',
                          'assets/images/svg/nav/add-car-active.svg',
                          "add_car".tr(context)),
                      _buildNavItem(
                          2,
                          'assets/images/svg/nav/cars.svg',
                          'assets/images/svg/nav/cars-active.svg',
                          "cars".tr(context)),
                      _buildNavItem(
                          3,
                          'assets/images/svg/nav/profile.svg',
                          'assets/images/svg/nav/profile-active.svg',
                          "profile".tr(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      int index, String inactiveSvg, String activeSvg, String label) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        final cubit = context.read<GlobalCubit>();
        final isActive = cubit.currentNavIndex == index;

        return GestureDetector(
          onTap: () => cubit.changeBottomNavIndex(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isActive ? activeSvg : inactiveSvg,
                height: 24.h,
                color: isActive ? AppColors.primary : AppColors.grey,
              ),
              SizedBox(height: 4.h),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: isActive ? 18.h : 0,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: isActive ? 1 : 0,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isActive ? AppColors.primary : AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
