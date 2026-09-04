import 'package:flutter/material.dart';
import 'package:pistol_game/components/exit_button.dart';
import 'package:pistol_game/components/start_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/home-background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.45),
        body: Padding(
          padding: EdgeInsetsGeometry.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ExitButton(), Spacer(), StartButton()],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    style: TextStyle(
                      fontSize: 72.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.right,
                    "A GUN\nSHOOTING\nGAME",
                  ),
                  Spacer(),
                  Text(
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                    textAlign: TextAlign.right,
                    "BY THY BRETHREN",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
