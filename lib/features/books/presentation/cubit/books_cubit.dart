
import 'package:book_store/features/books/presentation/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/models/Book.dart';

class BooksCubit extends Cubit<BooksState> {

  BooksCubit() : super(BooksInitialState());

  static BooksCubit get(context) => BlocProvider.of(context);

  List<Book> books = [];
  String? nextPageUrl;
  int totalCount = 0;
  bool hasReachedMax = false;
  String? searchQuery;
  bool isLoadingMore = false;

  Future<void> fetchInitialBooks({String? query}) async {

    final booksBox = Hive.box<List>('booksCache');

    try {
      searchQuery = query;
      nextPageUrl = null;
      hasReachedMax = false;

      if (searchQuery != null && searchQuery!.isNotEmpty) {
        emit(BooksSearchLoadingState());
      } else {
        emit(BooksLoadingState());
      }

      final result = await DioHelper.getPaginatedBooks(
        page: 1,
        searchQuery: searchQuery,
      );

      books = result.books.map((book) => Book.fromJson(book)).toList();
      nextPageUrl = result.nextPageUrl;
      hasReachedMax = nextPageUrl == null;

      final cacheKey = searchQuery != null && searchQuery!.isNotEmpty
          ? 'search_${searchQuery!.toLowerCase()}'
          : 'allBooks';

      await booksBox.put(cacheKey, books);

      emit(BooksSuccessState());

    } catch (error) {
      final cacheKey = searchQuery != null && searchQuery!.isNotEmpty
          ? 'search_${searchQuery!.toLowerCase()}'
          : 'allBooks';

      final cachedData = booksBox.get(cacheKey);

      if (cachedData != null && cachedData.isNotEmpty) {
        books = List<Book>.from(cachedData);
        hasReachedMax = true;
        emit(BooksSuccessState());
      } else {
        emit(BooksErrorState(error.toString()));
      }
    }
  }

  Future<void> fetchNextPage() async {

    if (hasReachedMax || isLoadingMore || nextPageUrl == null) return;

    try {
      isLoadingMore = true;
      emit(BooksLoadingState());
      final result = await DioHelper.getPaginatedBooks(
        nextPageUrl: nextPageUrl,
      );

      final newBooks = result.books.map((book) => Book.fromJson(book)).toList();
      nextPageUrl = result.nextPageUrl;
      hasReachedMax = nextPageUrl == null;
      books.addAll(newBooks);

      emit(BooksSuccessState());
    } catch (error) {
      emit(BooksErrorState(error.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> searchBooks(String query) async {
    if (query != searchQuery) emit(BooksSearchLoadingState());
    await fetchInitialBooks(query: query);
  }
}


