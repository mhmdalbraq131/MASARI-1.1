/// Network Connectivity Interface
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // Basic connectivity check abstraction
    return true;
  }
}
