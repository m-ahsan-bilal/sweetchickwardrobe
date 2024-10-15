import 'package:hive/hive.dart';

class HiveStorage {
  static final _hive = Hive.box("credential");
  static const key = "data";

  static Future<void> setHive(Map map,{String keys=key}) async {
    await _hive.put(keys, map);
  }

  static Future<void> update(Map map,{String keys=key}) async {
    await _hive.put(keys, map);
  }

  static Future<Map?> getHive({String keys=key}) async {
    return await _hive.get(keys);
  }
  static Future<void> deleteHive() async
  {
    await _hive.delete(key);
    await _hive.clear();
  }
}