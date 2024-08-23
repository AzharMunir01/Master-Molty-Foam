class FileStatus {
  bool status;
  String path;

  FileStatus({
    required this.status,
    required this.path,
  });

  // You can also include methods like fromJson and toJson if you're working with JSON

  factory FileStatus.fromJson(Map<String, dynamic> json) {
    return FileStatus(
      status: json['status'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'path': path,
    };
  }
}
