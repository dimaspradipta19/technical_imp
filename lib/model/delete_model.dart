class DeleteFaqModel {
    int code;
    String message;
    dynamic data;

    DeleteFaqModel({
        required this.code,
        required this.message,
        this.data,
    });

    factory DeleteFaqModel.fromJson(Map<String, dynamic> json) => DeleteFaqModel(
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
