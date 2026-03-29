import 'package:flutter/material.dart';
import 'package:krishimitra_ai/main.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = '';

  final List<Map<String, dynamic>> languages = [
    {
      'name': 'English',
      'code': 'en',
      'native': 'English',
      'icon': Icons.language,
    },
    {
      'name': 'తెలుగు (Telugu)',
      'code': 'te',
      'native': 'Telugu',
      'icon': Icons.translate,
    },
  ];

  void _selectLanguage(String code, String name) async {
    setState(() {
      _selectedLanguage = code;
    });

    await KrishiMitraApp.setLocale(context, code);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name selected'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 1),
      ),
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language / భాషను ఎంచుకోండి'),
      ),

      /// 🌾 Background using theme instead of lightGreen
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.primary.withOpacity(0.2),
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              "Choose Your Language",
              style: theme.textTheme.titleLarge,
            ),

            const SizedBox(height: 10),

            Text(
              "మీ భాషను ఎంచుకోండి",
              style: theme.textTheme.bodyMedium,
            ),

            const SizedBox(height: 20),

            /// LANGUAGE LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected =
                      _selectedLanguage == language['code'];

                  return Card(
                    elevation: isSelected ? 4 : 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: isSelected
                          ? BorderSide(color: colors.primary, width: 2)
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isSelected
                            ? colors.primary
                            : colors.primary.withOpacity(0.2),
                        child: Icon(
                          language['icon'],
                          color: isSelected
                              ? colors.onPrimary
                              : colors.secondary,
                        ),
                      ),
                      title: Text(
                        language['name'],
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? colors.secondary
                              : colors.onSurface,
                        ),
                      ),
                      subtitle: Text(language['native']),
                      trailing: isSelected
                          ? Icon(Icons.check_circle,
                          color: colors.primary)
                          : null,
                      onTap: () =>
                          _selectLanguage(language['code'], language['name']),
                    ),
                  );
                },
              ),
            ),

            /// CONTINUE BUTTON (already themed globally ✅)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _selectedLanguage.isNotEmpty
                    ? () {
                  Navigator.pushReplacementNamed(context, '/home');
                }
                    : null,
                child: const Text('Continue / కొనసాగించండి'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}