abstract class BooksState {}

class BooksInitialState extends BooksState {}

class BooksLoadingState extends BooksState {}

class BooksSearchLoadingState extends BooksState {}

class BooksSuccessState extends BooksState {}

class BooksErrorState extends BooksState {

  final String error;

  BooksErrorState(this.error);
}
