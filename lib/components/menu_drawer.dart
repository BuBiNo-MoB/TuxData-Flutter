import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tux_data_f/pages/distributions_page.dart';
import 'package:tux_data_f/pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../usecase/current_user_get_usecase.dart';
import '../usecase/logout_usecase.dart';

class MainMenuDrawer extends ConsumerWidget {
  const MainMenuDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: currentUser.when(
              data: (user) {
                if (user == null) {
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.account_circle, size: 64, color: Colors.white),
                      SizedBox(height: 8),
                      Text(
                        'LogIn to see your data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (user.avatar != null && user.avatar!.isNotEmpty)
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(user.avatar!),
                      )
                    else
                      const Icon(
                        Icons.account_circle,
                        size: 64,
                        color: Colors.white,
                      ),
                    const SizedBox(height: 8),
                    Text(
                      user.username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              error: (error, _) => const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.account_circle, size: 64, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Distributions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DistributionPage()),
              );
            },
          ),
          const Divider(),
          ...currentUser.when(
            data: (user) {
              if (user == null) {
                return [
                  ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text('Login'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Register'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },
                  ),
                ];
              } else {
                return <Widget>[];
              }
            },
            loading: () => <Widget>[],
            error: (error, _) => <Widget>[
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Register'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                  );
                },
              ),
            ],
          ),
          ...currentUser.when(
            data: (user) {
              if (user != null) {
                return [
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      final logoutUseCase = ref.read(logoutUseCaseProvider);
                      await logoutUseCase.call(ref);

                      if (!context.mounted) return;

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logout effettuato')),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                  ),
                ];
              } else {
                return <Widget>[];
              }
            },
            loading: () => <Widget>[],
            error: (error, _) => <Widget>[],
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings coming soon'),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'TuxDataB',
                applicationVersion: '0.5.0_alpha',
                applicationIcon: const Icon(Icons.apps),
                children: [
                  const Text('App for managing distributions'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
