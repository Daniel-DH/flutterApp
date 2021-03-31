import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.white,
        barBackgroundColor: CupertinoColors.white,
        scaffoldBackgroundColor: CupertinoColors.white,
        textTheme: new CupertinoTextThemeData(
          primaryColor: CupertinoColors.black,
          textStyle: TextStyle(color: CupertinoColors.black),
          // ... here I actually utilised all possible parameters in the constructor
          // as you can see in the link underneath
        ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home '),
    );
  }
}

const List links = [
  'https://uberblogapi.10upcdn.com/1079x547/smart/filters:format(webp)/blogapi.uber.com/wp-content/uploads/2020/05/Tacos-Horizontal_blog-2-1024x479.jpg',
  'https://uberblogapi.10upcdn.com/1079x547/smart/filters:format(webp)/blogapi.uber.com/wp-content/uploads/2020/09/UberIM_010007-medium-1024x683.jpg',
  'https://sevilla.abc.es/gurme/wp-content/uploads/sites/24/2012/01/comida-rapida-casera.jpg'
];
const List items = [
  "Para llevar",
  "Ofertas",
  "Pizza",
  "Café y Té",
  "Americano"
];
const List menu = ["A domicilio", "Para llevar"];
const List fotos = [
  'assets/bolsa.jpg',
  'assets/cafe.jpg',
  'assets/cupon.jpg',
  'assets/hotdog.jpg',
  'assets/pizza.jpg'
];
const List producto = [
  'Fiesta de tacos',
  'Pide a domicilio con los mejores',
  'Las mejores hamburguesas'
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _pages = [
    FrontPage(),
    SettingsPage(),
    SettingsPage(), // see the FrontPage class
    SettingsPage() // see the SettingsPage class
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Colors.black,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Buscar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark), label: 'Pedidos'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cuenta')
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _pages[index];
          }),
    );
  }
}

class FrontPage extends StatefulWidget {
  _FrontPage createState() => _FrontPage();
}

class _FrontPage extends State<FrontPage> {
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("productos");

  @override
  void initState() {
    subscription = collectionReference.snapshots().listen((event) {
      setState(() {
        snapshot = event.docs;
      });
    });
    super.initState();
  }

  int activeMenu = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(menu.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeMenu = index;
                      });
                    },
                    child: activeMenu == index
                        ? GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 8, top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        menu[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                )),
                          )
                        : GestureDetector(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 8, top: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        menu[index],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 45,
                  width: size.width - 70,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.black,
                              size: 24.0,
                              semanticLabel: 'location',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Calle Venencia...",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.black,
                                  size: 24.0,
                                  semanticLabel: 'time',
                                ),
                                SizedBox(width: 4),
                                Text("Ahora",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Icon(
                      Icons.tune_sharp,
                      color: Colors.black,
                      size: 24.0,
                      semanticLabel: 'time',
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: new Image(image: AssetImage("assets/image.jpg"))),
                ),
              ),
            ),
//Banner

            Container(
              width: size.width,
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Row(
                          children: List.generate(items.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Column(
                                children: [
                                  Image.asset(fotos[index],
                                      fit: BoxFit.fill, width: 40),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(items[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                width: size.width,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: size.width,
                                height: 160,
                                child: Image.network(
                                  snapshot[index].data()["imagen"],
                                  fit: BoxFit.cover,
                                  width: 20,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(snapshot[index].data()["nombre"],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          Text(snapshot[index].data()["descripcion"],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          Text(snapshot[index].data()["precio"],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          Text(snapshot[index].data()["tiempo"],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        ],
                      );
                    })),
          ],
        )
      ],
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }
}
