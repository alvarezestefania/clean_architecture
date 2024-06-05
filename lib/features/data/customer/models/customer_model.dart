import 'package:clean_architecture/features/domain/customer/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity{
  CustomerModel({
    required super.id,
    super.name,
    required super.userId
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map["id"] ?? "",
      name: map["name"],
      userId: map["userId"] ?? "",
    );
  }

  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      name: name,
      userId: userId
    );
  }
}