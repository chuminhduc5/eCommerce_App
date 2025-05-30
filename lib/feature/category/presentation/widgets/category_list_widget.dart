import 'package:ecommerce_app/feature/category/presentation/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListWidget extends ConsumerStatefulWidget {
  const CategoryListWidget({super.key});

  @override
  ConsumerState<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends ConsumerState<CategoryListWidget> {
  @override
  void initState() {
    super.initState();
    // Gọi hàm fetchCategory() một lần khi khởi tạo
    Future.microtask(() {
      ref.read(categoryViewModelProvider.notifier).fetchCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryViewModelProvider);

    return SizedBox(
      height: 100,
      child: state.when(
        loading: () => const CircularProgressIndicator(),
        error: (e, _) => Text("Lỗi: $e"),
        data: (categories) => ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              Container(child: Text(categories[index].name)),
        ),
      ),
    );
  }
}
