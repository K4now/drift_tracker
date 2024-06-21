import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/generated/l10n.dart';
import 'package:drift_tracker/routes/app_router.gr.dart';
import 'package:drift_tracker/src/core/bloc/language_bloc.dart';
import 'package:drift_tracker/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:drift_tracker/src/features/profile/presentation/widgets/car_info_card.dart';
import 'package:drift_tracker/src/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PortraitProfileLayout extends StatelessWidget {
  final User? user;
  final bool showCarDetails;
  final Car? car;
  final TextEditingController brandController;
  final TextEditingController horsepowerController;
  final TextEditingController configController;
  final Function(Car) onSaveCarData;
  final VoidCallback showEditCarDialog;
  final VoidCallback toggleShowCarDetails;

  const PortraitProfileLayout({
    Key? key,
    this.user,
    required this.showCarDetails,
    this.car,
    required this.brandController,
    required this.horsepowerController,
    required this.configController,
    required this.onSaveCarData,
    required this.showEditCarDialog,
    required this.toggleShowCarDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: user?.photoURL != null
              ? NetworkImage(user!.photoURL!)
              : AssetImage('assets/images/default_avatar.png') as ImageProvider,
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
                  value: context.read<LanguageBloc>().state.locale.languageCode == 'en'
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
          onPressed: toggleShowCarDetails,
          child: Text(
            showCarDetails
                ? S.of(context).hideDetails
                : S.of(context).showDetails,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        if (showCarDetails)
          Column(
            children: [
              CarInfoCard(
                car: car ?? Car(brand: "", horsepower: 0, config: ""),
                onSave: onSaveCarData,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: showEditCarDialog,
                child: Text(S.of(context).editCarDetails),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ],
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.router.push(LeaderboardRoute());
          },
          child: Text(S.of(context).leaderboard),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          ),
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
              context.read<AuthBloc>().add(AuthEvent.signOutRequested());
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
    );
  }
}
