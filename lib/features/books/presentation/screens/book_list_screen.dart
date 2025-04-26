import 'package:book_store/features/books/presentation/cubit/books_cubit.dart';
import 'package:book_store/features/books/presentation/cubit/home_states.dart';
import 'package:book_store/features/books/presentation/widgets/book_item.dart';
import 'package:book_store/features/books/presentation/widgets/welcome_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late BooksCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BooksCubit.get(context);
    _cubit.fetchInitialBooks();

    _scrollController.addListener(_onScroll);
  }

  // make minus 300 to make it more responsive and load earlier
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _cubit.fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BooksCubit, BooksState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(),
              _buildSearchBar(),
              if (state is BooksSearchLoadingState) _buildLinearProgress(),
              SizedBox(height: 16),
              _buildBookList(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 32.0, end: 32, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          welcomeMessage('Tricia'),
          SizedBox(height: 4),
          Text(
            'What do you want to read today?',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search books...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        ),
        onSubmitted: (value) => _cubit.searchBooks(value.trim()),
      ),
    );
  }

  Widget _buildLinearProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
      child: LinearProgressIndicator(),
    );
  }

  Widget _buildBookList(BooksState state) {
    if (state is BooksLoadingState && _cubit.books.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (_cubit.books.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No matched books to your search input',
            style: TextStyle(
              fontSize: 16,
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        itemCount: _cubit.books.length + (_cubit.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index < _cubit.books.length) {
            final book = _cubit.books[index];
            return BookItem(
              title: _formatBookTitle(book.title),
              author: book.authors?.isNotEmpty == true
                  ? book.authors!.first.name.toString()
                  : "Unknown",
              summary: book.summaries?.isNotEmpty == true
                  ? book.summaries!.first
                  : "No Summary available.",
              imageUrl: book.formats?.imagejpeg ??
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/495px-No-Image-Placeholder.svg.png?20200912122019',
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }

  String _formatBookTitle(String? title) {
    if (title == null || title.isEmpty) return "Untitled";
    if (title.contains(':')) {
      return title.split(':').first.trim();
    }
    return title.trim();
  }
}
