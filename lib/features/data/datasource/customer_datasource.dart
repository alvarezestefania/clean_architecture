import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/customer_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerDataSourceService {
  final SupabaseClient client;
  CustomerDataSourceService(this.client);

  Future<bool> doesCustomerExists(String userId) async {
    try {
      final existingCustomer = await client
          .from('customers')
          .select()
          .eq('userId', userId)
          .maybeSingle();
      if (existingCustomer != null) {
        return true;
      }
      return false;
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
