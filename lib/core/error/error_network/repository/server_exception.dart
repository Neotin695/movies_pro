import 'package:movies_pro/core/error/error_network/models/error_message_model.dart';

class ServerExceptionRepository implements Exception {
  final ErrorMessageModel errorMessage;

  const ServerExceptionRepository({required this.errorMessage});
}
