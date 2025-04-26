import 'package:dio/dio.dart';

class DioHelper {

  static late Dio _dio;
  static const String _baseUrl = 'https://gutendex.com/';
  static const String _booksEndpoint = 'books';
  static const int _receiveTimeout = 10000; // 10 seconds
  static const int _connectTimeout = 10000; // 10 seconds

  static void initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(milliseconds: _connectTimeout),
        receiveTimeout: const Duration(milliseconds: _receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => status! < 500,
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  static Future<({List<dynamic> books, String? nextPageUrl})> getPaginatedBooks({
    int page = 1,
    String? searchQuery,
    String? nextPageUrl,
  }) async {

    try {

      final Response response;

      if (nextPageUrl != null) {
        response = await _dio.get(nextPageUrl);
      } else {
        response = await _dio.get(
          _booksEndpoint,
          queryParameters: {
            'page': page,
            if (searchQuery != null && searchQuery.isNotEmpty) 'search': searchQuery,
          },
        );
      }

      final data = response.data;
      final books = data['results'] as List<dynamic>;
      final nextPage = data['next'] as String?;

      return (books: books, nextPageUrl: nextPage);
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        throw Exception('Network Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected Error: $e');
    }
  }

  static Future<List<dynamic>> searchBooks(String query, {int page = 1}) async {
    final result = await getPaginatedBooks(searchQuery: query, page: page);
    return result.books;
  }
}