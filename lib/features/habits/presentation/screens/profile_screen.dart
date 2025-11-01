import "package:flutter/material.dart";
import "package:prac7/features/habits/presentation/screens/auth_screen.dart";
import "package:prac7/features/habits/presentation/screens/favorites_screen.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.primary, colors.secondary],
              ),
            ),
            accountName: const Text("Гнитецкий Даниил"),
            accountEmail: const Text("dgnitetskiy@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: colors.onPrimary,
              child: Icon(Icons.person, size: 40, color: colors.primary),
            ),
          ),
          ListTile(
            leading: Icon(Icons.history_edu, color: colors.primary),
            title: const Text("Мои заметки по привычкам"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.push_pin, color: colors.primary),
            title: const Text("Напоминания"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: colors.primary),
            title: const Text("Избранное"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined, color: colors.primary),
            title: const Text("Настройки"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Выйти", style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AuthScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
