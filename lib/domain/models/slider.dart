import 'package:elbahaa/core/constants.dart';
import 'package:elbahaa/domain/models/teacher.dart';
import 'package:elbahaa/presentation/resources/assets_manager.dart';
import 'package:elbahaa/presentation/resources/strings_manager.dart';

class SliderModel {
  String name;
  String description;
  String image;

  SliderModel(this.name, this.description, this.image);

  static List<SliderModel> getBaqat() {
    return [
      SliderModel(AppStrings.silverBaqa, AppStrings.baqatDesc, ImageAssets.baqaSilver),
      SliderModel(AppStrings.goldenBaqa, AppStrings.baqatDesc, ImageAssets.baqaGolden),
      SliderModel(AppStrings.diamondBaqa, AppStrings.baqatDesc, ImageAssets.baqaDiamond),
    ];
  }

  static List<SliderModel> getTeachers(List<Teacher> teachers) {
    List<SliderModel> sliders = [];
    for (var element in teachers) {
      sliders.add(
          SliderModel(
              element.name ?? '',
              element.teacherDescription ?? '',
              element.image == null ? '' : '${Constants.siteUrl}${element.image}'
          )
      );
    }
    return sliders;
  }
}