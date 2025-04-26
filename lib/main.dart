import 'package:book_store/features/books/presentation/screens/book_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'core/networking/dio_helper.dart';
import 'core/networking/models/Authors.dart';
import 'core/networking/models/Book.dart';
import 'core/networking/models/Formats.dart';
import 'features/books/presentation/cubit/books_cubit.dart';
import 'features/books/presentation/cubit/home_states.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initialize();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(AuthorsAdapter());
  Hive.registerAdapter(FormatsAdapter());
  await Hive.openBox<List>('booksCache');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => BooksCubit(),
      child: BlocConsumer<BooksCubit,BooksState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BookListScreen(),
          );
        },
      ),
    );
  }
}