import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { isLogin, email, password, name }

class SharedPrefController {
  // Obtain shared preferences.
  late SharedPreferences prefs;

  static SharedPrefController? _instance;

  SharedPrefController._();

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  getInit() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveUser({user}) {
    setData(key: PrefKeys.name.name, value: user.name);
    setData(key: PrefKeys.email.name, value: user.email);
    setData(key: PrefKeys.password.name, value: user.password);
  }

  Future<bool> setData({key, value}) async {
    if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is String) {
      return await prefs.setString(key, value);
    } else {
      return await prefs.setBool(key, value);
    }
  }

  // Future<bool> setInt({key, value}) async {
  //   return await prefs.setInt(key, value);
  // }

  // Future<bool> setDouble({key, value}) async {
  //   return await prefs.setDouble(key, value);
  // }
  // Future<bool> setString({key, value}) async {
  //   return await prefs.setString(key, value);
  // }
  // Future<bool> setBool({key, value}) async {
  //   return await prefs.setBool(key, value);
  // }

  // int getInt({key}){
  //   return prefs.getInt(key)??0;
  // }
  //
  // double getDouble({key}){
  //   return prefs.getDouble(key)??0.0;
  // }
  //
  // String getString({key}){
  //   return prefs.getString(key)??'';
  // }
  //
  // bool getBool({key}){
  //   return prefs.getBool(key)??false;
  // }

  T? getData<T>({key}) {
    return prefs.get(key) as T?;
  }

  Future<bool> clear() async {
    return await prefs.clear();
  }

  Future<bool> remove({key}) async {
    return await prefs.remove(key);
  }
}
