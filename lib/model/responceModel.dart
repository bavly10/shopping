class ResponseModel{
final String msg;
  String? data;
final bool status;
 int? errorCode;
  ResponseModel({ required this.msg,required this.status,this.errorCode,this.data});

factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
  status: json["status"],
  msg: json["msg"],
  errorCode: json["error-code"]== null?null:json["error-code"],
);

}