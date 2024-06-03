import 'package:elbahaa/domain/models/notes/note.dart';
import 'package:elbahaa/domain/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../domain/models/city.dart';
import '../../../../../domain/models/package.dart';

class PrintedNotesController extends GetxController {

  final RxList<Note> notes = RxList.empty();
  final RxList<Note> cartNotes = RxList.empty();
  final RxList<Package> packages = RxList.empty();
  final RxList<Package> cartPackages = RxList.empty();
  final RxList<int> count = RxList.empty();
  final RxList<int> countPackages = RxList.empty();
  final RxInt sum = 0.obs;
  final RxInt totalSum = 0.obs;
  final RxInt discount = 0.obs;
  final RxInt cartNumber = 0.obs;

  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final RxList<String> areas = [
    'المحافظة...',
  ].obs;
  RxString selectedArea = 'المحافظة...'.obs;
  RxList<City> cities = RxList.empty();
  final RxInt selectedCityId = (-1).obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;

  PrintedNotesController(this._repository);


  @override
  Future<void> onInit() async {
    super.onInit();
    _getCities();
    getAllNotes();
  }

  void _getCities() {
    _repository.getCities().then((remoteCities) {
      cities.value = remoteCities;
      for (var element in remoteCities) {
        areas.add(element.name ?? '');
      }
    });
  }

  getNotes(String saff) async {
    print('---------------------------- $saff');
    _status.value = RxStatus.loading();
    try {
      _repository.getNotes(saff).then((remoteNotes) {
        _status.value = RxStatus.success();
        notes.value = remoteNotes.key;
        packages.value = remoteNotes.value;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      notes.value = [];
      packages.value = [];
    }
  }

  getAllNotes() async {
    _status.value = RxStatus.loading();
    try {
      totalSum.value = 0;
      sum.value = 0;
      discount.value = 0;
      count.value = [];
      _repository.getAllCart().then((remoteNotesAndPackages) {
        _status.value = RxStatus.success();
        cartNotes.value = remoteNotesAndPackages.key;
        cartPackages.value = remoteNotesAndPackages.value;
        cartNumber.value = 0;
        cartNumber.value += cartNotes.length;
        cartNumber.value += cartPackages.length;
        for (var element in remoteNotesAndPackages.key) {
          sum.value += element.bookPrice ?? 0;
          totalSum.value = sum.value - discount.value;
          count.add(1);
        }
        for (var element in remoteNotesAndPackages.value) {
          sum.value += int.parse(element.price ?? '0') * 2;
          discount.value += int.parse(element.price ?? '0');
          totalSum.value = sum.value - discount.value;
          countPackages.add(1);
        }
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      notes.value = [];
      packages.value = [];
    }
  }

  addNoteToCart(String noteId) {
    try {
      _repository.addNoteToCart(noteId).then((remoteNotes) {
        _status.value = RxStatus.success();
        cartNumber.value++;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      cartNotes.value = [];
      packages.value = [];
    }
  }

  addPackageToCart(String packageId) {
    try {
      _repository.addPackageToCart(packageId).then((remoteNotes) {
        _status.value = RxStatus.success();
        cartNumber.value++;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      cartNotes.value = [];
      cartPackages.value = [];
    }
  }

  removeNoteFromCart(Note note, int index) {
    try {
      _repository.removeNoteFromCart(note.id.toString()).then((remoteNotes) {
        _status.value = RxStatus.success();
        cartNotes.remove(note);
        count.removeAt(index);
        sum.value -= note.bookPrice ?? 0;
        totalSum.value = sum.value - discount.value;
        discount.value -= 0;
        cartNumber.value--;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      cartNotes.value = [];
    }
  }

  removePackageFromCart(Package package, bool remove, int index) {
    try {
      _repository.removePackageFromCart(package.id.toString()).then((remotePackage) {
        _status.value = RxStatus.success();
        if (remove) {
          cartPackages.remove(package);
          countPackages.removeAt(index);
          sum.value -= int.parse(package.price ?? '0') * 2;
          discount.value -= int.parse(package.price ?? '0');
          totalSum.value = sum.value - discount.value;
          cartNumber.value--;
        }
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
      cartPackages.value = [];
    }
  }

  bool isNoteInCart(String noteId) {
    return _repository.isNoteInCart(noteId);
  }

  bool isPackageInCart(String packageId) {
    return _repository.isPackageInCart(packageId);
  }

  void incrementCount(int index) {
    count[index]++;
    cartNotes[index].quantity = (cartNotes[index].quantity ?? 0) + 1;
    sum.value += cartNotes[index].bookPrice ?? 0;
    totalSum.value = sum.value - discount.value;
    discount.value += 0;
  }

  void decrementCount(int index) {
    if (count[index] != 1) {
      count[index]--;
      cartNotes[index].quantity = (cartNotes[index].quantity ?? 0) - 1;
      sum.value -= cartNotes[index].bookPrice ?? 0;
      totalSum.value = sum.value - discount.value;
      discount.value -= 0;
    }
  }

  void incrementCountPackage(int index) {
    countPackages[index]++;
    sum.value += int.parse(cartPackages[index].price ?? '0') * 2;
    discount.value += int.parse(cartPackages[index].price ?? '0');
    totalSum.value = sum.value - discount.value;
  }

  void decrementCountPackage(int index) {
    if (countPackages[index] != 1) {
      countPackages[index]--;
      sum.value -= int.parse(cartPackages[index].price ?? '0') * 2;
      discount.value -= int.parse(cartPackages[index].price ?? '0');
      totalSum.value = sum.value - discount.value;
    }
  }

  Future<void> order() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.order(
        userName.text,
        phone.text,
        selectedCityId.value,
        address.text,
        cartNotes,
        count,
        cartPackages,
        countPackages,
      ).then((value) {
        _status.value = RxStatus.success();
        cartNotes.value = [];
        cartPackages.value = [];
        cartNumber.value = 0;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void chooseArea(String newArea) {
    selectedArea.value = newArea;
    City city = cities.firstWhere((element) => element.name == newArea);
    selectedCityId.value = city.id ?? -1;
  }

  String getNotesString(Package package) {
    String returnedNotes = '';
    int count = 0;
    for (Note element in package.book ?? []) {
      if (count == ((package.book?.length ?? 0) - 1)) {
        returnedNotes += '${element.name}';
      } else {
        returnedNotes += '${element.name} - ';
      }
      count++;
    }
    return returnedNotes;
  }
}