class CreateFaqModel {
  int code;
  String message;
  Data data;

  CreateFaqModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CreateFaqModel.fromJson(Map<String, dynamic> json) => CreateFaqModel(
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
  String pertanyaan;
  String jawaban;
  bool statusPublish;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Data({
    required this.pertanyaan,
    required this.jawaban,
    required this.statusPublish,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pertanyaan: json["pertanyaan"],
        jawaban: json["jawaban"],
        statusPublish: json["status_publish"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "pertanyaan": pertanyaan,
        "jawaban": jawaban,
        "status_publish": statusPublish,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
