class DeeplinkModel {
  final String? id;
  final String route;

  const DeeplinkModel({required this.id, required this.route});

  factory DeeplinkModel.fromJson(Map<String, dynamic> json) {
    return DeeplinkModel(id: json['id'], route: json['route'] ?? '');
  }

  String toQuery() {
    //TODO: implement this method to convert the model to a query string
    return '';
  }
}
