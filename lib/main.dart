import 'package:drift_tracker/src/core/bloc/language_bloc.dart';
import 'package:drift_tracker/src/core/global/theme_switcher.dart';
import 'package:drift_tracker/src/features/authentication/data/implements/implements.dart';
import 'package:drift_tracker/src/features/drift_sessions/data/implements/implements.dart';
import 'package:drift_tracker/src/features/drift_sessions/domain/usecases/delete_session.dart';
import 'package:drift_tracker/src/features/drift_sessions/domain/usecases/get_session.dart';
import 'package:drift_tracker/src/features/measurement/data/implements/session_repository_impl.dart';
import 'package:drift_tracker/src/features/measurement/data/sources/remote_data_source.dart';
import 'package:drift_tracker/src/features/measurement/domain/repositories/session_repositories.dart';
import 'package:drift_tracker/src/features/measurement/domain/usecases/save_session.dart';
import 'package:drift_tracker/src/features/measurement/presentation/bloc/measurement_bloc.dart';
import 'package:drift_tracker/src/features/profile/data/implements/implements.dart';
import 'package:drift_tracker/src/features/profile/domain/usecases/get_car_data.dart';
import 'package:drift_tracker/src/features/profile/domain/usecases/save_car_data.dart';
import 'package:drift_tracker/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:drift_tracker/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'generated/l10n.dart';
import 'package:drift_tracker/routes/app_router.dart';
import 'package:drift_tracker/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drift_tracker/src/features/drift_sessions/domain/usecases/add_session.dart';
import 'package:drift_tracker/src/features/drift_sessions/presentation/bloc/session_bloc.dart';

final appRouter = AppRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authRepository =
      AuthRepositoryImpl(firebaseAuth: FirebaseAuth.instance);
  final sessionRepository = SessionRepositoryImpl(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
  final carRepository =
      CarRepositoryImpl(firestore: FirebaseFirestore.instance);
  final sessionOnMensure = SessionRepositoryOnMensureImpl(MensureDataSourceImpl(
    FirebaseFirestore.instance,
  ));

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                MeasurementBloc(SaveSessionUseCase(sessionOnMensure))),

        BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository)),
        BlocProvider(
          create: (context) => SessionBloc(
            addSessionUseCase: AddSessionUseCase(sessionRepository),
            getSessionsUseCase: GetSessionsUseCase(sessionRepository),
            deleteSessionUseCase: DeleteSessionUseCase(sessionRepository),
          ),
        ),
        BlocProvider(create: (context) => LanguageBloc()),
        BlocProvider(
          create: (context) => ProfileBloc(
            getCarData: GetCarData(carRepository),
            saveCarData: SaveCarData(carRepository),
          ),
        ), // Добавьте LanguageBloc
      ],
      child: ThemeSwitcherWidget(
        initialTheme: lightTheme,
        child: DriftTrackerApp(),
      ),
    ),
  );
}

class DriftTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: ThemeSwitcher.of(context).themeData,
          locale: state.locale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: appRouter.config(),
          title: 'DriftTracker',
        );
      },
    );
  }
}
