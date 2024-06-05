import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/data/customer/models/customer_model.dart';
import 'package:clean_architecture/features/domain/customer/entities/customer_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerDataSourceService {
  final SupabaseClient client;
  CustomerDataSourceService(this.client);

  Future<CustomerEntity?> getCustomerByUserId(String userId) async {
    try {
      final clientResponse = await client
          .from('customers')
          .select()
          .eq('userId', userId)
          .maybeSingle();
      if (clientResponse != null) {
       return CustomerModel.fromJson(clientResponse).toEntity();   
      }
      return null;
    } catch (e) {
      throw CustomException('Error al validar el cliente: ${e.toString()}');
    }
  }

  Future<void> createCustomer(CustomerEntity customerData) async {
     try {
      await client
        .from('customers')
        .insert({'name': customerData.name, 'userId': customerData.userId});
    } catch (e) {
      throw CustomException('Error al crear el cliente: ${e.toString()}');
    }
  }
}
