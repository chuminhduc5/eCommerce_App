import 'package:ecommerce_app/core/utils/logger_utile.dart';
import 'package:ecommerce_app/feature/category/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final SupabaseClient _supabaseClient;
  CategoryRemoteDataSourceImpl(this._supabaseClient);
  @override
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _supabaseClient.from('categories').select();
      logger.i("Response: $response");
      return (response as List)
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
