import 'package:ecommerce_admin_app/features/categories/domain/entites/category_entity.dart';

class CategoriesDto extends CategoryEntity {
  const CategoriesDto({super.id, super.name, super.image, super.slug});

  factory CategoriesDto.fromJson(Map<String, dynamic> json) {
    return CategoriesDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'slug': slug};
  }
}
