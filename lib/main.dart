import 'package:clothing/config/routes/routes.dart';
import 'package:clothing/config/themes/theme.dart';
import 'package:clothing/data/repositories/user_repository_impl.dart';
import 'package:clothing/domain/repositories/user_repository.dart';
import 'package:clothing/firebase_options.dart';
import 'package:clothing/presentation/bloc/auth/auth_bloc.dart';
import 'package:clothing/presentation/bloc/bloc/favourites_bloc.dart';
import 'package:clothing/presentation/bloc/bloc/size_bloc.dart';
import 'package:clothing/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:clothing/presentation/bloc/checkbox/checkbox_bloc.dart';
import 'package:clothing/presentation/bloc/password/password_bloc.dart';
import 'package:clothing/presentation/bloc/onBoarding/on_boarding_bloc.dart';
import 'package:clothing/presentation/bloc/product_gallery/product_gallery_bloc.dart';
import 'package:clothing/presentation/bloc/user_details/user_bloc.dart';
import 'package:clothing/presentation/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (context) => UserRepositoryImplementation()),
      ],
      
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(create: (context) => OnBoardingBloc()),
          BlocProvider(create: (context) => PasswordBloc()),
          BlocProvider(create: (context) => CheckboxBloc()),         
          BlocProvider(create: (context) => BottomNavBloc()),
          BlocProvider(create: (context) => UserBloc(RepositoryProvider.of<UserRepository>(context))),
          BlocProvider(create: (context) => ProductGalleryBloc()),
          BlocProvider(create: (context) => SizeBloc()),
          BlocProvider(create: (context) => FavouritesBloc())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: '/',
            routes: Routes.routes,
            home: const SplashWrapper()),
      ),
    );
  }
}
