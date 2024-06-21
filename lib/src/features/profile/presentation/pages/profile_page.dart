import 'package:drift_tracker/src/features/profile/presentation/widgets/landscape_profile_layout.dart';
import 'package:drift_tracker/src/features/profile/presentation/widgets/portrait_profile_layout.dart';
import 'package:drift_tracker/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drift_tracker/generated/l10n.dart';
import 'package:drift_tracker/src/core/global/theme_switcher.dart';
import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/routes/app_router.gr.dart';
import '../widgets/edit_car_dialog.dart';

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
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {
              context.router.push(LeaderboardRoute());
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
            child: isPortrait
                ? PortraitProfileLayout(
                    user: user,
                    showCarDetails: _showCarDetails,
                    car: _car,
                    brandController: _brandController,
                    horsepowerController: _horsepowerController,
                    configController: _configController,
                    onSaveCarData: _saveCarData,
                    showEditCarDialog: _showEditCarDialog,
                    toggleShowCarDetails: () {
                      setState(() {
                        _showCarDetails = !_showCarDetails;
                      });
                    },
                  )
                : LandscapeProfileLayout(
                    user: user,
                    showCarDetails: _showCarDetails,
                    car: _car,
                    brandController: _brandController,
                    horsepowerController: _horsepowerController,
                    configController: _configController,
                    onSaveCarData: _saveCarData,
                    showEditCarDialog: _showEditCarDialog,
                    toggleShowCarDetails: () {
                      setState(() {
                        _showCarDetails = !_showCarDetails;
                      });
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
