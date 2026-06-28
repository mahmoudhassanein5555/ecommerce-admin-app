import 'package:ecommerce_admin_app/features/products/domain/entites/products_entity.dart';

class ProductsDto extends ProductsEntity {
  ProductsDto({
    id,
    title,
    slug,
    price,
    description,
    category,
    images,
    creationAt,
    updatedAt,
  }) : super(
         id: id ?? 0,
         title: title ?? "",
         slug: slug ?? "",
         price: price ?? 0,
         description: description ?? "",
         category: category ?? const CategoryEntity(),
         images: images ?? [],
         creationAt: creationAt ?? "",
         updatedAt: updatedAt ?? "",
       );

  ProductsDto.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'] ?? 0,
        title: json['title'] ?? "",
        slug: json['slug'] ?? "",
        price: json['price'] ?? 0,
        description: json['description'] ?? "",
        category: json['category'] != null
            ? CategoryDto.fromJson(json['category'])
            : const CategoryEntity(),
        images: json['images'] != null
            ? List<String>.from(json['images'])
            : const [],
        creationAt: json['creationAt'] ?? "",
        updatedAt: json['updatedAt'] ?? "",
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'price': price,
      'description': description,
      'category': category is CategoryDto
          ? (category as CategoryDto).toJson()
          : null,
      'images': images,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }
}

class CategoryDto extends CategoryEntity {
  CategoryDto({id, name, slug, image, creationAt, updatedAt})
    : super(
        id: id ?? 0,
        name: name ?? "",
        slug: slug ?? "",
        image: image ?? "",
        creationAt: creationAt ?? "",
        updatedAt: updatedAt ?? "",
      );

  CategoryDto.fromJson(Map<String, dynamic> json)
    : super(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        slug: json['slug'] ?? "",
        image: json['image'] ?? "",
        creationAt: json['creationAt'] ?? "",
        updatedAt: json['updatedAt'] ?? "",
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }
}
