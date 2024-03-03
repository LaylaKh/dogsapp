class ErrorModel {
  String? status;
  String? message;
  int? code;

  ErrorModel({this.status, this.message, this.code});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}