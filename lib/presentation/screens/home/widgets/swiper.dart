import 'package:elbahaa/core/launch_site.dart';
import 'package:elbahaa/domain/models/slider.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';
import 'package:elbahaa/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';

class SwiperWidget extends StatelessWidget {

  final List<SliderModel> sliders;
  final bool isTeacher;
  const SwiperWidget({super.key, required this.sliders, required this.isTeacher});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Swiper(
        autoplay: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Get.to(() => ProductScreen(productId: sliders[index].id.toString() ?? '',));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sliders[index].name,
                      style: getLargeStyle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        sliders[index].description,
                        style: getSmallStyle(),
                      ),
                    ),
                    isTeacher ? Container() : FilledButton(
                      style: getFilledButtonStyle(
                        color: ColorManager.secondary
                      ),
                      onPressed: () {
                        launchSite(Constants.siteUrl);
                      },
                      child: Text(
                        AppStrings.buyBaqa,
                        style: getSmallStyle(
                            color: ColorManager.white
                        ),
                      ),
                    ),
                  ],
                ),
                isTeacher ? (sliders[index].image == '' ?
                Image.asset(
                  ImageAssets.teacher2,
                  width: 150,
                )
                    :
                Image.network(
                    sliders[index].image,
                    width: 150,
                )
                )
                    : // Packages
                Image.asset(
                  sliders[index].image,
                  width: 150,
                ),
              ],
            ),
          );
        },
        indicatorLayout: PageIndicatorLayout.COLOR,
        itemCount: sliders.length,
        control: null,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 160.0),
            builder: SwiperCustomPagination(builder:
                (BuildContext context, SwiperPluginConfig config) {
              return ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 50.0),
                child: Container(
                  color: ColorManager.white,
                  child: Center(
                    child: isTeacher ? Container() : AnimatedSmoothIndicator(
                      activeIndex: config.activeIndex,
                      count: sliders.length,
                      effect:  const SlideEffect(
                          spacing:  8.0,
                          dotWidth:  12.0,
                          dotHeight:  12.0,
                          paintStyle:  PaintingStyle.fill,
                          dotColor:  ColorManager.grey,
                          activeDotColor:  ColorManager.secondary
                      ),
                    ),
                  ),
                ),
              );
            })
        ),
      ),
    );
  }
}
