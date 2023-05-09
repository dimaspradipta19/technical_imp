class ListFaqModel {
  int code;
  String message;
  List<Datum> data;
  Pagination pagination;

  ListFaqModel({
    required this.code,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory ListFaqModel.fromJson(Map<String, dynamic> json) => ListFaqModel(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
      };
}

class Datum {
  int id;
  String pertanyaan;
  String jawaban;
  int statusPublish;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.pertanyaan,
    required this.jawaban,
    required this.statusPublish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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

class Pagination {
  int currentPage;
  int totalRows;

  Pagination({
    required this.currentPage,
    required this.totalRows,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        totalRows: json["total_rows"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "total_rows": totalRows,
      };
}
