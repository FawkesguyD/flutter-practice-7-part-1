import "package:flutter/material.dart";
import "package:prac7/features/habits/presentation/screens/habits_screen.dart";

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4C6EF5), Color(0xFF55DDE0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: const Color(0x26FFFFFF),
                    child: Icon(Icons.track_changes, size: 56, color: colors.onPrimary),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Habit Tracker",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Создавайте устойчивые привычки, закрепляйте рутину и отслеживайте прогресс ежедневно.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xD9FFFFFF)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colors.surface,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email_outlined, color: colors.primary),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colors.surface,
                      hintText: "Пароль",
                      prefixIcon: Icon(Icons.lock_outline, color: colors.primary),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HabitsScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.surface,
                        foregroundColor: colors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Войти",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
