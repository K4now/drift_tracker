import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/routes/app_router.gr.dart';
import 'package:drift_tracker/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drift_tracker/generated/l10n.dart';
import 'package:drift_tracker/src/core/global/theme_switcher.dart';
import 'package:drift_tracker/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/src/features/profile/presentation/bloc/profile_bloc.dart';
import '../widgets/profile_info_card.dart';
import '../widgets/car_info_card.dart';
import '../widgets/edit_car_dialog.dart';
import 'package:drift_tracker/src/core/bloc/language_bloc.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _brandController;
  late TextEditingController _horsepowerController;
  late TextEditingController _configController;
  bool _showCarDetails = false;
  Car? _car;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController();
    _horsepowerController = TextEditingController();
    _configController = TextEditingController();
    _loadCarData();
  }

  void _loadCarData() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<ProfileBloc>().add(LoadCarData(userId));
    }
  }

  void _saveCarData(Car car) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<ProfileBloc>().add(SaveCarDataEvent(userId, car));
      setState(() {
        _car = car;
      });
    }
  }

  @override
  void dispose() {
    _brandController.dispose();
    _horsepowerController.dispose();
    _configController.dispose();
    super.dispose();
  }

  void _showEditCarDialog() {
    if (_car != null) {
      showDialog(
        context: context,
        builder: (context) => EditCarDialog(
          car: _car!,
          onSave: _saveCarData,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
        actions: [
          IconButton(
            icon: Icon(
              ThemeSwitcher.of(context).themeData!.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              ThemeSwitcher.of(context).switchTheme(
                  ThemeSwitcher.of(context).themeData!.brightness ==
                          Brightness.dark
                      ? lightTheme
                      : darkTheme);
            },
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            setState(() {
              _car = state.car;
              _brandController.text = state.car.brand;
              _horsepowerController.text = state.car.horsepower.toString();
              _configController.text = state.car.config;
            });
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : AssetImage('assets/images/default_avatar.png')
                          as ImageProvider,
                ),
                SizedBox(height: 20),
                ProfileInfoCard(
                  title: S.of(context).name,
                  value: user?.displayName ?? 'User Name',
                ),
                ProfileInfoCard(
                  title: S.of(context).email,
                  value: user?.email ?? 'Email not available',
                ),
                SizedBox(height: 20),
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).language,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        DropdownButtonFormField<LanguageEvent>(
                          value: context
                                      .read<LanguageBloc>()
                                      .state
                                      .locale
                                      .languageCode ==
                                  'en'
                              ? LanguageEvent.changeToEnglish
                              : LanguageEvent.changeToRussian,
                          items: [
                            DropdownMenuItem(
                              value: LanguageEvent.changeToEnglish,
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: LanguageEvent.changeToRussian,
                              child: Text('Русский'),
                            ),
                          ],
                          onChanged: (LanguageEvent? event) {
                            if (event != null) {
                              context.read<LanguageBloc>().add(event);
                            }
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showCarDetails = !_showCarDetails;
                    });
                  },
                  child: Text(
                    _showCarDetails
                        ? S.of(context).hideDetails
                        : S.of(context).showDetails,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                if (_showCarDetails)
                  Column(
                    children: [
                      CarInfoCard(
                        car: _car ?? Car(brand: "", horsepower: 0, config: ""),
                        onSave: _saveCarData,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _showEditCarDialog,
                        child: Text(S.of(context).editCarDetails),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return CircularProgressIndicator();
                    } else if (state is ProfileError) {
                      return Text(state.message,
                          style: TextStyle(color: Colors.red));
                    } else if (state is ProfileSaved) {
                      return Text(S.of(context).carDataSaved,
                          style: TextStyle(color: Colors.green));
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      context
                          .read<AuthBloc>()
                          .add(AuthEvent.signOutRequested());
                      context.router.replaceAll([const LoginRoute()]);
                    });
                  },
                  child: Text(S.of(context).logout),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
