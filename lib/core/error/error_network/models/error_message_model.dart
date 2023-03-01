import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ErrorMessageModel {
  final bool success;
  final int statusCode;
  final String statusMessage;

  ErrorMessageModel({
    required this.success,
    required this.statusCode,
    required this.statusMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'statusCode': statusCode,
      'StatusMessage': statusMessage,
    };
  }

  factory ErrorMessageModel.fromMap(Map<String, dynamic> map) {
    return ErrorMessageModel(
      success: map['success'] as bool,
      statusCode: map['statusCode'] as int,
      statusMessage: map['StatusMessage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorMessageModel.fromJson(String source) =>
      ErrorMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ErrorMessageModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode =>
      success.hashCode ^ statusCode.hashCode ^ statusMessage.hashCode;
}
