class DetailFaqModel {
    int code;
    String message;
    Data data;

    DetailFaqModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory DetailFaqModel.fromJson(Map<String, dynamic> json) => DetailFaqModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String pertanyaan;
    String jawaban;
    int statusPublish;
    DateTime createdAt;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.pertanyaan,
        required this.jawaban,
        required this.statusPublish,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        pertanyaan: json["pertanyaan"],
        jawaban: json["jawaban"],
        statusPublish: json["status_publish"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pertanyaan": pertanyaan,
        "jawaban": jawaban,
        "status_publish": statusPublish,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
