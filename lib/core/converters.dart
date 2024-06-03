import '../presentation/resources/strings_manager.dart';

String convertSaff(String saff, String data) {
  switch(saff) {
    case AppStrings.saff4:
      return '${data}four';
    case AppStrings.saff5:
      return '${data}five';
    case AppStrings.saff6:
      return '${data}six';
    case AppStrings.saff7:
      return '${data}seven';
    case AppStrings.saff8:
      return '${data}eight';
    case AppStrings.saff9:
      return '${data}nine';
    case AppStrings.saff10:
      return '${data}ten';
    case AppStrings.saff11:
      return '${data}eleven';
    case AppStrings.saff12:
      return '${data}twelve';
    default:
      return '';
  }
}

String convertSaffToNum(String saff) {
  switch(saff) {
    case AppStrings.saff4:
      return '4';
    case AppStrings.saff5:
      return '5';
    case AppStrings.saff6:
      return '6';
    case AppStrings.saff7:
      return '7';
    case AppStrings.saff8:
      return '8';
    case AppStrings.saff9:
      return '9';
    case AppStrings.saff10:
      return '10';
    case AppStrings.saff11:
      return '11';
    case AppStrings.saff12:
      return '12';
    case AppStrings.saff12_2:
      return '12';
    default:
      return '';
  }
}