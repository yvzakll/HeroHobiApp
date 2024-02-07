import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroapp/blocs/my_user_bloc/bloc/my_user_bloc.dart';
import 'package:heroapp/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:heroapp/screens/hobby_screen/hobby_screen.dart';
import 'package:user_repository/user_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<MyUserBloc>().add(GetMyUser(myUserId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: Icon(
                CupertinoIcons.square_arrow_right,
                color: Theme.of(context).colorScheme.onSecondary,
              ))
        ],
      ),
      body: BlocBuilder<MyUserBloc, MyUserState>(
        builder: (context, state) {
          if (state.status == MyUserStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == MyUserStatus.failure) {
            return const Center(child: Text('Failed to load user data'));
          } else if (state.status == MyUserStatus.success) {
            final user = state.user;
            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Name'),
                    subtitle: Text(user?.name ?? 'No name provided'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(user?.email ?? 'No email provided'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.cake),
                    title: const Text('Birthday'),
                    subtitle: Text(user?.birthday ?? 'No birthday provided'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Biography'),
                    subtitle: Text(user?.biography ?? 'No biography provided'),
                  ),
                ),
                Card(
                    child: Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HobiScreen(),
                        ));
                      },
                      child: Text("HOBİLER")),
                )),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
