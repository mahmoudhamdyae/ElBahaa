import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/courses/course.dart';

abstract class LocalDataSource {
  Future<bool> isFirstTime();
  Future<void> setUserLoggedIn();
  bool isUserLoggedIn();
  Future<void> signOut();
  Future<void> setUserId(int id);
  int getUserId();
  Future<void> setUserName(String name);
  String getUserName();
  Future<void> setGrade(String grade);
  String getGrade();
  Future<void> setPhoneNumber(String number);
  String getPhoneNumber();
  Future<void> setFav(Course course);
  Future<List<Course>> getFav();
  Future<void> removeFav(int courseId);

  Future<void> addNoteToCart(String noteId);
  Future<void> removeNoteFromCart(String noteId);
  List<String> getAllNotesCart();
  bool isNoteInCart(String noteId);

  Future<void> addPackageToCart(String packageId);
  Future<void> removePackageFromCart(String packageId);
  List<String> getAllPackagesCart();
  bool isPackageInCart(String packageId);

  Future<void> removeAllFromCart();

  bool isSubscribed();
  void saveIsSubscribed(bool isSubscribed);
}

const String keyIsFirstTime = "KEY_IS_FIRST_TIME";
const String keyIsUserLoggedIn = "KEY_IS_USER_LOGGED_IN";
const String keyUserId = "KEY_USER_ID";
const String keyUserName = "KEY_USER_NAME";
const String keyGrade = "KEY_GRADE";
const String keyPhoneNumber = "KEY_PHONE_NUMBER";
const String keyNotesCart = "KEY_NOTES_CART";
const String keyPackagesCart = "KEY_PACKAGES_CART";
const String keyIsSubscribed = "KEY_IS_SUBSCRIBED";

class LocalDataSourceImpl extends LocalDataSource {

  final Box _box;
  final SharedPreferences _sharedPreferences;
  LocalDataSourceImpl(this._box, this._sharedPreferences);

  @override
  Future<bool> isFirstTime() async {
    bool isFirstTime = await _box.get(keyIsFirstTime, defaultValue: true);
    if (isFirstTime) {
      await _box.put(keyIsFirstTime, false);
    }
    return isFirstTime;
  }

  @override
  Future<void> setUserLoggedIn() async {
    return await _box.put(keyIsUserLoggedIn, true);
  }

  @override
  bool isUserLoggedIn() {
    return _box.get(keyIsUserLoggedIn, defaultValue: false);
  }

  @override
  Future<void> signOut() async {
    await _box.put(keyIsUserLoggedIn, false);
    setUserId(0);
    setPhoneNumber('');
    setGrade('');
    setUserName('');
    _delSaved();
  }

  @override
  Future<void> setUserId(int id) async {
    return await _box.put(keyUserId, id);
  }

  @override
  int getUserId() {
    return _box.get(keyUserId, defaultValue: 0);
  }

  @override
  Future<void> setUserName(String name) async {
    return await _box.put(keyUserName, name);
  }

  @override
  String getUserName() {
    return _box.get(keyUserName, defaultValue: '');
  }

  @override
  Future<void> setGrade(String grade) async {
    return await _box.put(keyGrade, grade);
  }

  @override
  String getGrade() {
    return _box.get(keyGrade, defaultValue: '');
  }

  @override
  Future<void> setPhoneNumber(String number) async {
    return await _box.put(keyPhoneNumber, number);
  }

  @override
  String getPhoneNumber() {
    return _box.get(keyPhoneNumber, defaultValue: '');
  }

  @override
  Future<void> setFav(Course course) async {
    var favBox = await Hive.openBox<Course>('course');

    final Map<dynamic, Course> courseMap = favBox.toMap();
    dynamic desiredKey;
    courseMap.forEach((key, value){
      if (value.id == course.id) {
        desiredKey = key;
      }
    });
    if (desiredKey == null) {
      // Add
      await favBox.add(course);
    } else {
      // Update
    }
  }

  @override
  Future<List<Course>> getFav() async {
    var favBox = await Hive.openBox<Course>('course');
    return favBox.values.toList();
  }

  @override
  Future<void> removeFav(int courseId) async {
    var favBox = await Hive.openBox<Course>('course');
    final Map<dynamic, Course> courseMap = favBox.toMap();
    dynamic desiredKey;
    courseMap.forEach((key, value){
      if (value.id == courseId) {
        desiredKey = key;
      }
    });
    favBox.delete(desiredKey);
  }
  
  void _delSaved() async {
    var favBox = await Hive.openBox<Course>('course');
    var videosBox = await Hive.openBox<Course>('videos');
    var lessonBox = await Hive.openBox<Course>('lesson');
    favBox.deleteFromDisk();
    videosBox.deleteFromDisk();
    lessonBox.deleteFromDisk();
  }

  @override
  Future<void> addNoteToCart(String noteId) async {
    print('----------- ADDED $noteId');
    List<String> notes = getAllNotesCart();
    notes.add(noteId);
    await _sharedPreferences.setStringList(keyNotesCart, notes);
  }

  @override
  List<String> getAllNotesCart() {
    List<String> notes = _sharedPreferences.getStringList(keyNotesCart) ?? [];
    print('----------- GET ALL ${notes.length}');
    return notes;
  }

  @override
  bool isNoteInCart(String noteId) {
    List<String> notes = getAllNotesCart();
    return notes.contains(noteId);
  }

  @override
  Future<void> removeNoteFromCart(String noteId) async {
    print('----------- REMOVED $noteId');
    List<String> notes = getAllNotesCart();
    notes.remove(noteId);
    await _sharedPreferences.setStringList(keyNotesCart, notes);
  }

  @override
  Future<void> addPackageToCart(String packageId) async {
    print('----------- ADDED P $packageId');
    List<String> packages = getAllPackagesCart();
    packages.add(packageId);
    await _sharedPreferences.setStringList(keyPackagesCart, packages);
  }

  @override
  Future<void> removePackageFromCart(String packageId) async {
    print('----------- REMOVED P $packageId');
    List<String> packages = getAllPackagesCart();
    packages.remove(packageId);
    await _sharedPreferences.setStringList(keyPackagesCart, packages);
  }

  @override
  List<String> getAllPackagesCart() {
    List<String> packages = _sharedPreferences.getStringList(keyPackagesCart) ?? [];
    print('----------- GET ALL P ${packages.length}');
    return packages;
  }

  @override
  bool isPackageInCart(String packageId) {
    List<String> packages = getAllPackagesCart();
    return packages.contains(packageId);
  }

  @override
  Future<void> removeAllFromCart() async {
    await _sharedPreferences.setStringList(keyNotesCart, []);
    await _sharedPreferences.setStringList(keyPackagesCart, []);
  }

  @override
  void saveIsSubscribed(bool isSubscribed) {
    _sharedPreferences.setBool(keyIsSubscribed, isSubscribed);
  }

  @override
  bool isSubscribed() {
    return _sharedPreferences.getBool(keyIsSubscribed) ?? false;
  }
}