enum NetworkStatus{
  init,
  loading,
  success,
  internetError,
  error;
  bool get isSuccess => this == success;
  bool get isError => this == error;
  bool get isInternetError => this == internetError;
  bool get isLoading => this == loading;
}

class NetworkResponse<T> {
  final NetworkStatus status;
  final T? data;
  final String? message;

  NetworkResponse(
    this.status,
    this.data,
    this.message,
  );

  static NetworkResponse<T> success<T>(data) {
    return NetworkResponse(NetworkStatus.success, data, null);
  }

  static NetworkResponse<T> error<T>({required String? message}) {
    return NetworkResponse(NetworkStatus.error, null, message);
  }

  static NetworkResponse<T> init<T>() {
    return NetworkResponse(NetworkStatus.init, null, null);
  }

  static NetworkResponse<T> loading<T>() {
    return NetworkResponse(NetworkStatus.loading, null, null);
  }

  static NetworkResponse internetError() {
    return NetworkResponse(NetworkStatus.internetError, null, null);
  }
}
