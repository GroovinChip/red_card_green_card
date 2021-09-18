import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:red_card_green_card/widgets/green_card.dart';
import 'package:red_card_green_card/widgets/red_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red Card Green Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isFlipped = false;
  late SharedPreferences prefs;
  final cardFlipController = FlipCardController();

  @override
  void initState() {
    super.initState();
    getCardState();
  }

  /// This is incredibly hacky and bad but it works ¯\_(ツ)_/¯
  Future<void> getCardState() async {
    prefs = await SharedPreferences.getInstance();
    final _cardFlipState = prefs.getBool('isFlipped') ?? false;
    setState(() => _isFlipped = _cardFlipState);

    cardFlipController.state!.controller!.duration =
        const Duration(milliseconds: 0);
    if (_isFlipped) {
      cardFlipController.state!.controller!.forward();
    } else {
      cardFlipController.state!.controller!.reverse();
    }

    setState(() {
      cardFlipController.state!.isFront = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
        systemStatusBarContrastEnforced: true,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isFlipped ? 'Green Card!' : 'Red Card!',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 16),
              FlipCard(
                controller: cardFlipController,
                flipOnTouch: true,
                onFlip: () {
                  setState(() {
                    _isFlipped = !_isFlipped;
                    prefs.setBool('isFlipped', _isFlipped);
                  });
                },
                direction: FlipDirection.HORIZONTAL, // default
                front: const RedCard(),
                back: const GreenCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
