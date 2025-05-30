import 'package:ecommerce_app/feature/category/data/datasources/category_remote_data_source.dart';
import 'package:ecommerce_app/feature/category/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/feature/category/domain/entities/category_entity.dart';
import 'package:ecommerce_app/feature/category/domain/usecases/get_category_use_case.dart';
import 'package:ecommerce_app/feature/category/presentation/viewmodels/category_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

final categoryRemoteDataSourceProvider = Provider((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return CategoryRemoteDataSourceImpl(supabase);
});

final categoryRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(categoryRemoteDataSourceProvider);
  return CategoryRepositoryImpl(remoteDataSource);
});

final getCategoryUseCaseProvider = Provider((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return GetCategoryUseCase(repository);
});

final categoryViewModelProvider = StateNotifierProvider<CategoryViewModel, AsyncValue<List<CategoryEntity>>>((ref) {
  final categoryUseCase = ref.watch(getCategoryUseCaseProvider);
  return CategoryViewModel(categoryUseCase);
});