class ProductsModel {
  final String id;
  final String name;
  final String slug;
  final String createdAt;
  final String updatedAt;
  final double price;
  final String description;
  final int quantity;
  final List<String> images;
  final String subCategoryId;
  final String brandId;
  final bool active;
  final double averageStars;
  final int totalReviews;

  ProductsModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.description,
    required this.quantity,
    required this.images,
    required this.subCategoryId,
    required this.brandId,
    required this.active,
    required this.averageStars,
    required this.totalReviews,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      price: json['price'].toDouble(),
      description: json['description'],
      quantity: json['quantity'],
      images: List<String>.from(json['images']),
      subCategoryId: json['subCategoryId'],
      brandId: json['brandId'],
      active: json['active'],
      averageStars: (json['averageStars'] ?? 0.0).toDouble(),
      totalReviews: json['totalReviews'] ?? 0,
    );
  }
}
