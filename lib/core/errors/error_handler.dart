import 'package:ecommerce_admin_app/core/errors/error.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';
import 'package:ecommerce_admin_app/core/failure/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is RemoteException) {
      return _handleRemoteError(exception.errormessage);
    } else if (exception is LocalException) {
      return Failure(exception.errormessage);
    } else {
      return Failure("Something went wrong, please try again later.");
    }
  }

  static Failure _handleRemoteError(String message) {
    if (message.contains("401") ||
        message.contains("Unauthorized") ||
        message.contains("Unauthenticated")) {
      return Failure("Your session has expired. Please login again.");
    } else if (message.contains("403") || message.contains("Forbidden")) {
      return Failure("You don't have permission to perform this action.");
    } else if (message.contains("404") || message.contains("Not Found")) {
      return Failure("The requested resource was not found.");
    } else if (message.contains("500") ||
        message.contains("Internal Server Error")) {
      return Failure(
        "Our server is having trouble. Please try again in a few minutes.",
      );
    } else if (message.isNotEmpty &&
        !message.contains("400") &&
        !message.contains("Exception")) {
      return Failure(message);
    } else if (message.contains("422") ||
        message.contains("Unprocessable Content")) {
      return Failure("Invalid information provided. Please check your inputs.");
    } else if (message.contains("SocketException") ||
        message.contains("Connection failed") ||
        message.contains("HandshakeException")) {
      return Failure("No internet connection. Please check your network.");
    } else if (message.contains("Timeout") || message.contains("Deadline")) {
      return Failure("Connection timed out. The server is not responding.");
    } else if (message.contains("TypeError") ||
        message.contains("FormatException")) {
      return Failure("We encountered a technical issue while processing data.");
    } else {
      return Failure(message);
    }
  }
}
