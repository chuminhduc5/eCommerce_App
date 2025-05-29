import 'package:ecommerce_app/core/service/dio_client.dart';
import 'package:ecommerce_app/feature/product/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/feature/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/feature/product/domain/usecases/get_product_by_id_use_case.dart';
import 'package:ecommerce_app/feature/product/domain/usecases/get_product_use_case.dart';
import 'package:ecommerce_app/feature/product/presentation/viewmodels/product_view_model.dart';
import 'package:ecommerce_app/feature/product/presentation/viewmodels/product_view_model_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Provider cho SupabaseClient
final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

// Provider cho ProductRemoteDataSource
final productRemoteDataSourceProvider = Provider((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return ProductRemoteDataSourceImpl();
});

// Provider cho ProductRepository
final productRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource);
});

// Provider cho GetProductUseCase
final getProductUseCaseProvider = Provider((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductUseCase(repository);
});

// Provider cho GetProductByIdUseCase
final getProductByIdUseCaseProvider = Provider((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductByIdUseCase(repository);
});

// Provider cho ProductViewModel
final productViewModelProvider =
    AsyncNotifierProvider<ProductViewModel, ProductViewModelState>(
        () => ProductViewModel());
