// import 'package:flutter/material.dart';
// import 'package:fluttersociallogin/api_constants.dart';
// import 'package:fluttersociallogin/main.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key, required this.email});

//   final String email;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Home Page'),
//           centerTitle: true,
//           backgroundColor: Color.fromARGB(255, 226, 123, 20),
//         ),
//         body: Column(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Image.asset(
//                 api_constants.motivityLogo,
//                 height: 75,
//                 width: 200,
//               ),
//             ),
//             Text(email),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // GoogleSignInProvider().googleSignOut();
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Login(title: ''),
//                       ));
//                   // Navigator.pop(context);
//                 },
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(
//                         Color.fromARGB(255, 226, 123, 20)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ))),
//                 child: const Text("Go Back!"),
//               ),
//             ),
//           ],
//         ));
//   }
// }

//basic bottom navigation bar:

// import 'package:flutter/material.dart';
// import 'package:fluttersociallogin/api_constants.dart';
// import 'package:fluttersociallogin/main.dart';

// class HomePage extends StatefulWidget {
//   final String email;

//   const HomePage({Key? key, required this.email}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 226, 123, 20),
//       ),
//       body: Column(
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: Image.asset(
//               api_constants.motivityLogo,
//               height: 75,
//               width: 200,
//             ),
//           ),
//           Text(widget.email),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Login(title: ''),
//                   ),
//                 );
//               },
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(
//                   Color.fromARGB(255, 226, 123, 20),
//                 ),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//               ),
//               child: const Text("Go Back!"),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Color.fromARGB(255, 226, 123, 20),
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_on),
//             label: 'Map',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

//home and settings button in the navigation bar and settingspage is cmng below the home page:

// import 'package:flutter/material.dart';
// import 'package:fluttersociallogin/api_constants.dart';
// import 'package:fluttersociallogin/main.dart';

// class HomePage extends StatefulWidget {
//   final String email;

//   const HomePage({Key? key, required this.email}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     HomePageContent(),
//     SettingsPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 226, 123, 20),
//       ),
//       body: _pages[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Color.fromARGB(255, 226, 123, 20),
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HomePageContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Align(
//           alignment: Alignment.topCenter,
//           child: Image.asset(
//             api_constants.motivityLogo,
//             height: 75,
//             width: 200,
//           ),
//         ),
//         Text('Content of Home Page'),
//       ],
//     );
//   }
// }

// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 226, 123, 20),
//       ),
//       body: Column(
//         children: [
//           Text('Basic Mobile Settings'),
//           // Add your settings widgets here
//         ],
//       ),
//     );
//   }
// }

//working according to req.

import 'package:flutter/material.dart';
import 'package:fluttersociallogin/bottomNavScreens/SettingsPage.dart';
import 'package:fluttersociallogin/api_constants.dart';
import 'package:fluttersociallogin/main.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: _getBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Color.fromARGB(255, 226, 123, 20),
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 0) {
            setState(() {
              _currentIndex = index;
            });
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(),
              ),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
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

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                api_constants.motivityLogo,
                height: 75,
                width: 200,
              ),
            ),
            Text(widget.email),
            Center(
              child: ElevatedButton(
                key: Key('goBackButton'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(title: ''),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 226, 123, 20),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                child: const Text("Go Back!"),
              ),
            ),
          ],
        );
      default:
        return Container(); // You can return default content here for other indexes
    }
  }
}



// working properly

// import 'package:flutter/material.dart';
// import 'package:fluttersociallogin/api_constants.dart';
// import 'package:fluttersociallogin/main.dart';

// class HomePage extends StatefulWidget {
//   final String email;

//   const HomePage({Key? key, required this.email}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 226, 123, 20),
//       ),
//       body: _getBody(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Color.fromARGB(255, 226, 123, 20),
//         currentIndex: _currentIndex,
//         onTap: (int index) {
//           if (index == 2) {
//             // Navigate to SettingsPage when index is 2 (Settings)
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => SettingsPage(),
//               ),
//             );
//           } else {
//             setState(() {
//               _currentIndex = index;
//             });
//           }
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_on),
//             label: 'Map',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getBody(int index) {
//     switch (index) {
//       case 0:
//         return Column(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Image.asset(
//                 api_constants.motivityLogo,
//                 height: 75,
//                 width: 200,
//               ),
//             ),
//             Text(widget.email),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Login(title: ''),
//                     ),
//                   );
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(
//                     Color.fromARGB(255, 226, 123, 20),
//                   ),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                 ),
//                 child: const Text("Go Back!"),
//               ),
//             ),
//           ],
//         );
//       default:
//         return Container(); // You can return default content here for other indexes
//     }
//   }
// }

// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//         centerTitle: true,
//         backgroundColor: Color.fromARGB(255, 226, 123, 20),
//       ),
//       body: Column(
//         children: [
//           Text('Basic Mobile Settings'),
//           // Add your settings widgets here
//         ],
//       ),
//     );
//   }
// }

