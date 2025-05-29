import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../viewmodels/product_view_model.dart';

class ProductScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: productState.when(
        data: (state) {
          return Column(
            children: [
              // Hiển thị danh sách sản phẩm
              state.products.when(
                data: (products) => Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: product.imageUrl.isNotEmpty
                            ? Image.network(product.imageUrl.first,
                                width: 50, height: 50, fit: BoxFit.cover)
                            : const Icon(Icons.image_not_supported, size: 50),
                        title: Text(product.name),
                        subtitle: Text(
                            '\$${product.price} - ${product.categoryName}'),
                        onTap: () => ref
                            .read(productViewModelProvider.notifier)
                            .fetchProductById(product.id),
                      );
                    },
                  ),
                ),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
              // Hiển thị sản phẩm được chọn
              state.selectedProduct.when(
                data: (product) => product != null
                    ? Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('Selected: ${product.name}'),
                            Text('Price: \$${product.price}'),
                            Text('Category: ${product.categoryName}'),
                            // Image.network(product.imageUrl,
                            //     width: 100, height: 100),
                          ],
                        ),
                      )
                    : SizedBox(),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(productViewModelProvider.notifier).fetchProducts(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
