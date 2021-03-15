import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
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
  int activeMenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: 'School',
          )
        ],
        currentIndex: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.green,
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return ListView(
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
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: 160,
                          child: Image.network(
                            links[0],
                            fit: BoxFit.cover,
                            width: 20,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(producto[0],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: 160,
                          child: Image.network(
                            links[1],
                            fit: BoxFit.cover,
                            width: 20,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(producto[1],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: 160,
                          child: Image.network(
                            links[2],
                            fit: BoxFit.cover,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(producto[2],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
