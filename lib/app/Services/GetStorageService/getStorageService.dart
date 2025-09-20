import 'package:get_storage/get_storage.dart';

class StorageService {
  final _box = GetStorage();

  // 🔹 Keys ek jagah define karo (avoid typo)
  static const String userTokenKey = "token";
  static const String darkModeKey = "dark_mode";
  static const String userId = "userId";
  static const String uid = "uid";
  static const String warehouseId = "warehouseId";
  static const String userName = "userName";
  static const String agentId = "agentId";
  static const String agentLatitude = "AgentLatitude";
  static const String agentLongitude = "AgentLongitude";

  // ✅ Write
  Future<void> saveUserToken(String token) async {
    await _box.write(userTokenKey, token);
  }

  Future<void> saveUserId(String token) async {
    await _box.write(userId, token);
  }

  Future<void> saveUId(String token) async {
    await _box.write(uid, token);
  }

  Future<void> saveWarehouseId(String token) async {
    await _box.write(warehouseId, token);
  }

  Future<void> saveUserName(String token) async {
    await _box.write(userName, token);
  }

  Future<void> saveAgentId(String token) async {
    await _box.write(agentId, token);
  }

  Future<void> saveAgentLatitude(String token) async {
    await _box.write(agentLatitude, token);
  }

  Future<void> saveAgentLongitude(String token) async {
    await _box.write(agentLongitude, token);
  }

  Future<void> saveDarkMode(bool isDark) async {
    await _box.write(darkModeKey, isDark);
  }

  // ✅ Read
  String? getUserToken() => _box.read(userTokenKey);
  bool getDarkMode() => _box.read(darkModeKey) ?? false;
  String? getUserId() => _box.read(userId);
  String? getUid() => _box.read(uid);
  String? getWarehouseId() => _box.read(warehouseId);
  String? getUserName() => _box.read(userName);
  String? getAgentId() => _box.read(agentId);
  String? getAgentLatitude() => _box.read(agentLatitude);
  String? getAgentLongitude() => _box.read(agentLongitude);

  // ✅ Remove / Clear
  Future<void> clearUserToken() async {
    await _box.remove(userTokenKey);
  }

  Future<void> clearUserId() async {
    await _box.remove(userId);
  }

  Future<void> clearUId() async {
    await _box.remove(uid);
  }

  Future<void> clearWarehouseId() async {
    await _box.remove(warehouseId);
  }

  Future<void> clearUserName() async {
    await _box.remove(userName);
  }

  Future<void> clearAgentId() async {
    await _box.remove(agentId);
  }

  Future<void> clearAgentLatitude() async {
    await _box.remove(agentLatitude);
  }

  Future<void> clearAgentLongitude() async {
    await _box.remove(agentLongitude);
  }

  Future<void> clearAll() async {
    await _box.erase();
  }
}
