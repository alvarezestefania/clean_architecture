import 'package:clean_architecture/features/domain/entities/customer_entity.dart';
import 'package:clean_architecture/features/domain/usecases/customer/createcustomer_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/customer/getcustomerassociateduser.dart';
import 'package:clean_architecture/features/presentation/bloc/customer/customer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CreateCustomerIfNotExistUsecase _createCustomerifNotExistUseCase;
  final GetCustomerByUserIdUseCase _byUserIdUseCase; 

  CustomerCubit(
    this._byUserIdUseCase,
    this._createCustomerifNotExistUseCase,
  ) : super(const CustomerInitial());

   Future<void> loadCustomer(String userId,String? email) async {
    emit(CustomerLoading());
    try {
      final customer = await _byUserIdUseCase(userId);
      if (customer != null) {
        emit(CustomerSuccess(customer));
      }else{
        final newCustomer = CustomerEntity(
          id: null,
          name: email ?? "",
          userId: userId,
        );
        await _createCustomerifNotExistUseCase(userId, newCustomer);
        loadCustomer(userId,email);
      }   
    } catch (e) {
      emit(CustomerFailure(e.toString()));
    }
  }
}
