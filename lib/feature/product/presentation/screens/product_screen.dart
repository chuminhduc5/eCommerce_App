import 'package:ecommerce_app/core/utils/logger_utile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../viewmodels/product_view_model.dart';

// class ProductScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final productState = ref.watch(productViewModelProvider);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Products')),
//       body: productState.when(
//         data: (state) {
//           return Column(
//             children: [
//               // Hiển thị danh sách sản phẩm
//               state.products.when(
//                 data: (products) => Expanded(
//                   child: ListView.builder(
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return ListTile(
//                         leading: product.imageUrl.isNotEmpty
//                             ? Image.network(product.imageUrl.first,
//                                 width: 50, height: 50, fit: BoxFit.cover)
//                             : const Icon(Icons.image_not_supported, size: 50),
//                         title: Text(product.name),
//                         subtitle: Text(
//                             '\$${product.price} - ${product.categoryName}'),
//                         onTap: () => ref
//                             .read(productViewModelProvider.notifier)
//                             .fetchProductById(product.id),
//                       );
//                     },
//                   ),
//                 ),
//                 loading: () => Center(child: CircularProgressIndicator()),
//                 error: (error, _) => Center(child: Text('Error: $error', style: TextStyle(color: Colors.red),)),
//               ),
//             ],
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, _) => Center(child: Text('Error: $error', style: TextStyle(color: Colors.green),)),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () =>
//             ref.read(productViewModelProvider.notifier).fetchProducts(),
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: productState.when(
        data: (state) {
          return Column(
            children: [
              // Hiển thị danh sách sản phẩm
              state.products.when(
                data: (products) {
                  logger.i("Rendering ${products.length} products");
                  return Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          leading: product.imageUrl.isNotEmpty
                              ? Image.network(
                            product.imageUrl.first,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              logger.e("Image error: $error");
                              return const Icon(Icons.image_not_supported, size: 50);
                            },
                          )
                              : const Icon(Icons.image_not_supported, size: 50),
                          title: Text(product.name),
                          subtitle: Text('\$${product.price} - ${product.categoryName}'),
                          onTap: () {
                            logger.i("Fetching product with id: ${product.id}");
                            //ref.read(productViewModelProvider.notifier).fetchProductById(product.id);
                          },
                        );
                      },
                    ),
                  );
                },
                loading: () {
                  logger.i("Products loading");
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  logger.e("Products error: $error");
                  return Center(
                    child: Text(
                      'Error loading products: $error',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
              // Hiển thị sản phẩm được chọn
              state.selectedProduct.when(
                data: (product) => product != null
                    ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Selected: ${product.name}'),
                      Text('Price: \$${product.price}'),
                      Text('Category: ${product.categoryName}'),
                      product.imageUrl.isNotEmpty
                          ? Image.network(
                        product.imageUrl.first,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          logger.e("Image error: $error");
                          return const Icon(Icons.image_not_supported, size: 100);
                        },
                      )
                          : const Icon(Icons.image_not_supported, size: 100),
                    ],
                  ),
                )
                    : const SizedBox(),
                loading: () {
                  logger.i("Selected product loading");
                  return const Center(child: CircularProgressIndicator());
                },
                error: (error, stackTrace) {
                  logger.e("Selected product error: $error");
                  return Center(
                    child: Text(
                      'Error loading product: $error',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ],
          );
        },
        loading: () {
          logger.i("ProductViewModel loading");
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          logger.e("ProductViewModel error: $error");
          return Center(
            child: Text(
              'Error: $error',
              style: const TextStyle(color: Colors.red),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.i("Refreshing products");
          ref.read(productViewModelProvider.notifier).fetchProducts();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}