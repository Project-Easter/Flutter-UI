import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static String authToken;
  // String get authToken { return _authToken; }
  static String urlTemplate =
      'https://api.mapbox.com/styles/v1/aivankum/ckrusiaw57nch17w9vkwnki1e/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWl2YW5rdW0iLCJhIjoiY2tyamJ3bzR5MDEwdzJ2cGNxaXNha3M0ZyJ9.Z9T5-SYG3_-hfv3LezwZEQ';

  static String mapboxToken =
      'pk.eyJ1IjoiYWl2YW5rdW0iLCJhIjoiY2tyamJ3bzR5MDEwdzJ2cGNxaXNha3M0ZyJ9.Z9T5-SYG3_-hfv3LezwZEQ';
  static String mapboxId = 'mapbox.mapbox-streets-v8';

  Future<void> loadAuthToken() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    authToken = await storage.read(key: 'global_token');
    print('$authToken is the quoteToken for FLutterStorage');
    // return authToken;
  }

//Same for FB authtoken
  Future<void> storeAuthToken(String authToken) async {
    const FlutterSecureStorage _globalToken = FlutterSecureStorage();
    await _globalToken.write(key: 'global_token', value: authToken);
  }
}
