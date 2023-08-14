import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double long = 0;
  double lat = 0;
  bool loading = false;

  Future<Position> obtainPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    loading = true;
    Position position = await obtainPosition();
    lat = position.latitude;
    long = position.longitude;
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                const Text(
                  'Location App',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff00F0C7),
                  ),
                ),
                const SizedBox(height: 20),
                Icon(
                  MdiIcons.mapMarkerRadius,
                  size: 120,
                  color: const Color(0xff00F0C7),
                ),
              ],
            ),
            const Divider(
              height: 35,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: (loading)
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: 60,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                            color: Color(0xff907CFF),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Longitud:',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff907CFF),
                          ),
                        ),
                        Text(
                          '$long',
                          style: const TextStyle(fontSize: 30),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Latitud:',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff907CFF),
                          ),
                        ),
                        Text(
                          '$lat',
                          style: const TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Color(0xff00F0C7),
                ),
              ),
              onPressed: () {
                setState(
                  () {
                    getCurrentLocation();
                  },
                );
              },
              child: const Text(
                'Obtener Localización',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Quinteros Cristina'),
          ],
        ),
      ),
    );
  }
}
