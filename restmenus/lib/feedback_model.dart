class FeedbackModel {
  final String name;
  final int id;
  final String ingredients;
  final String video;
  final String photo;
  final int price;

  FeedbackModel({
    required this.name,
    required this.id,
    required this.ingredients,
    required this.video,
    required this.photo,
    required this.price,
  });

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel(
      name: "${json['name']}",
      id: json['id'],
      ingredients: "${json['ingredients']}",
      video: "${json['video']}",
      photo: "${json['photo']}",
      price: json['price'],
    );
  }
  Map tojson() => {
        "name": name,
        "id": id,
        "ingredients": ingredients,
        "video": video,
        "photo": photo,
        "price": price,
      };
}
