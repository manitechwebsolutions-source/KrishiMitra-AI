import 'package:flutter/material.dart';
import 'package:krishimitra_ai/core/theme.dart';
import 'package:krishimitra_ai/main.dart'; // ✅ IMPORTANT

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = '';

  /// ✅ Only English + Telugu
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

    /// ✅ THIS is the correct way (triggers rebuild)
    await KrishiMitraApp.setLocale(context, code);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name selected'),
        backgroundColor: FarmColors.leafGreen,
        duration: const Duration(seconds: 1),
      ),
    );

    /// Navigate after small delay
    Future.delayed(const Duration(milliseconds: 700), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language / భాషను ఎంచుకోండి'),
        backgroundColor: FarmColors.leafGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              FarmColors.lightGreen,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Choose Your Language",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "మీ భాషను ఎంచుకోండి",
              style: TextStyle(color: Colors.black54),
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
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: isSelected ? 4 : 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: isSelected
                          ? BorderSide(
                          color: FarmColors.leafGreen, width: 2)
                          : BorderSide.none,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isSelected
                            ? FarmColors.leafGreen
                            : FarmColors.lightGreen,
                        child: Icon(
                          language['icon'],
                          color: isSelected
                              ? Colors.white
                              : FarmColors.darkGreen,
                        ),
                      ),
                      title: Text(
                        language['name'],
                        style: TextStyle(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? FarmColors.darkGreen
                              : Colors.black87,
                        ),
                      ),
                      subtitle: Text(language['native']),
                      trailing: isSelected
                          ? Icon(Icons.check_circle,
                          color: FarmColors.leafGreen)
                          : null,
                      onTap: () =>
                          _selectLanguage(language['code'], language['name']),
                    ),
                  );
                },
              ),
            ),

            /// CONTINUE BUTTON
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedLanguage.isNotEmpty
                      ? () {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FarmColors.leafGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continue / కొనసాగించండి',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}