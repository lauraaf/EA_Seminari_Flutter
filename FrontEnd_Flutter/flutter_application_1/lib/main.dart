import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/experiencies.dart';
import 'package:flutter_application_1/pages/logIn.dart';
import 'package:flutter_application_1/pages/user.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  

  final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LogInPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => HomePage(),
          ),
          GoRoute(
            path: '/usuarios',
            builder: (context, state) => UserPage(),
          ),
          GoRoute(
            path: '/experiencies',
            builder: (context, state) => ExperienciesPage(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}

class BottomNavScaffold extends StatefulWidget {
  final Widget child;

  const BottomNavScaffold({required this.child});

  @override
  _BottomNavScaffoldState createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      context.go('/home'); // Navega a HomePage
    } else if (index == 1) {
      context.go('/usuarios'); // Navega a UsersPage
    } else if (index == 2) {
      context.go('/experiencies'); // Navega a UsersPage
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Experiencias',
          ),
        ],
      ),
    );
  }
}