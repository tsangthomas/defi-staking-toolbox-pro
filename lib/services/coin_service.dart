import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinService {
  final String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<String?> getCoinImageUrl(String coinId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/coins/$coinId'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['image']?['large'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}