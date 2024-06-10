import '../presentation/resources/strings_manager.dart';

String convertSaffToNum(String saff) {
  switch(saff) {
    case AppStrings.secondaryMarhala:
      return '1';
    case AppStrings.universityMarhala:
      return '2';
    default:
      return '';
  }
}