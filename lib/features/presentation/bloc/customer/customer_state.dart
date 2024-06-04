import 'package:clean_architecture/features/domain/entities/customer_entity.dart';

abstract class CustomerState {
  const CustomerState();
}

class CustomerInitial extends CustomerState {
  const CustomerInitial();
}

class CustomerLoading extends CustomerState {}

class CustomerSuccess extends CustomerState {
  final CustomerEntity customerData;
  CustomerSuccess(this.customerData);
}

class CustomerFailure extends CustomerState {
  final String? errorMessage;
  CustomerFailure(this.errorMessage);
}