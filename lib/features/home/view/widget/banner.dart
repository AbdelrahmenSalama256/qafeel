import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerHome extends StatelessWidget {
  final List<String> imageUrls;
  final List<String> titles;
  final List<String> descriptions;
  final double height;

  const BannerHome({
    super.key,
    required this.imageUrls,
    required this.titles,
    required this.descriptions,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageUrls.length,
      options: CarouselOptions(
        height: height.h,
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 1,
        autoPlayInterval: Duration(seconds: 3),
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.grey[300],
          ),
          child: Stack(
            children: [
              Image.asset(
                imageUrls[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.centerStart,
                    end: AlignmentDirectional.centerEnd,
                    colors: [
                      const Color(0xFF5C4199),
                      const Color(0xFF5C4199).withOpacity(0.0),
                    ],
                    stops: [0.0014, 0.9349],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titles[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      descriptions[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
