import 'package:flutter/material.dart';
import 'package:fluttersociallogin/Screens/homePage.dart';
import 'package:fluttersociallogin/theme/theme_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

ThemeManager _themeManager = ThemeManager();

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        actions: [
          Switch(
              value: _themeManager.themeMode == ThemeMode.dark,
              onChanged: (newValue) {
                _themeManager.toggleTheme(newValue);
              })
        ],
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Language Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          ListTile(
            title: Text('Language: $_selectedLanguage'),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () {
              _showLanguageDialog();
            },
          ),
          // Add more settings widgets here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 226, 123, 20),
        currentIndex: 2, // Index 2 corresponds to SettingsPage
        onTap: (int index) {
          if (index == 0) {
            // Navigate to the HomePage if index is 0 (Home)
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage(email: '')));
          } else {
            // Handle navigation for other pages (if needed)
            print("Tapped index: $index");
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageItem('English'),
              _buildLanguageItem('Spanish'),
              _buildLanguageItem('French'),
              _buildLanguageItem('German'),
              // Add more languages as needed
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageItem(String language) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(language),
      ),
    );
  }
}
