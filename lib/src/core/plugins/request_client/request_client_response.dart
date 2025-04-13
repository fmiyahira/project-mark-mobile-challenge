class RequestResponse<T> {
  final T? data;
  final int? statusCode;
  final String? message;
  final bool isSuccess;

  RequestResponse({
    required this.isSuccess,
    this.data,
    this.statusCode,
    this.message,
  });

  factory RequestResponse.success(T data, {int? statusCode}) {
    return RequestResponse(isSuccess: true, data: data, statusCode: statusCode);
  }

  factory RequestResponse.error(String message, {int? statusCode}) {
    return RequestResponse(
      isSuccess: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
