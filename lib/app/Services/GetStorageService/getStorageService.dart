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
  static const String storeId = "storeId";
  static const String agentData = "AgentData";
  static const String agentTown = "AgentTown";
  static const String vehicleId = "VehicleId";
  static const String totalDelivery = "TotalDelivery";
  static const String upiLink = "upiLink";
  static const String orderId = "orderId";
  static const String paid = "paid";
  static const String storeEmail = "storeEmail";

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

  Future<void> saveStoreId(String storeId) async {
    await _box.write(storeId, storeId);
  }

  Future<void> saveAgentData(Map<String, dynamic> agentDetail) async {
    await _box.write(agentData, agentDetail);
  }

  Future<void> saveAgentTown(String AgentTown) async {
    await _box.write(agentTown, AgentTown);
  }

  Future<void> saveVehicleId(String vehId) async {
    await _box.write(vehicleId, vehId);
  }

  Future<void> saveTotalDelivery(String totDelivery) async {
    await _box.write(totalDelivery, totDelivery);
  }

  Future<void> saveUpiLink(String upi) async {
    await _box.write(upiLink, upi);
  }

  Future<void> saveOrderId(String order) async {
    await _box.write(orderId, order);
  }

  Future<void> savePaid(bool status) async {
    await _box.write(paid, status);
  }

  Future<void> saveStoreEmail(String email) async {
    await _box.write(storeEmail, email);
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
  String? getStoreId() => _box.read(storeId);
  Map<String, dynamic>? getAgentData() => _box.read(agentData);
  String? getAgentTown() => _box.read(agentTown);
  String? getVehicleId() => _box.read(vehicleId);
  String? getTotalDelivery() => _box.read(totalDelivery);
  String? getUpiLink() => _box.read(upiLink);
  String? getOrderId() => _box.read(orderId);
  bool? getPaidStatus() => _box.read(paid);
  String? getStoreEmail() => _box.read(storeEmail);

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

  Future<void> clearStoreId() async {
    await _box.remove(storeId);
  }

  Future<void> clearAgentData() async {
    await _box.remove(agentData);
  }

  Future<void> clearAgentTown() async {
    await _box.remove(agentTown);
  }

  Future<void> clearVehicleId() async {
    await _box.remove(vehicleId);
  }

  Future<void> clearTotalDelivery() async {
    await _box.remove(totalDelivery);
  }

  Future<void> clearUpiLink() async {
    await _box.remove(upiLink);
  }

  Future<void> clearOrderId() async {
    await _box.remove(orderId);
  }

  Future<void> clearPaidStatus() async {
    await _box.remove(paid);
  }

  Future<void> clearStoreEmail() async {
    await _box.remove(storeEmail);
  }

  Future<void> clearAll() async {
    await _box.erase();
  }
}
