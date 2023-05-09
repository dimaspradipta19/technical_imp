class LogoutModel {
    int code;
    String message;
    dynamic data;

    LogoutModel({
        required this.code,
        required this.message,
        this.data,
    });

    factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
        code: json["code"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
    };
}
