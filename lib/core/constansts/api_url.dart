import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrl {
  ApiUrl._();
  static final String baseUrl = dotenv.env['SUPABSE_URL'] ?? '';
  static const apiV = 'rest/v1';

  // Products
  static const products = '$apiV/products';
  static const productsById = '$apiV/products/{id}';

  // Categories

  // Carts

  // Orders
}
