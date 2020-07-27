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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CartWidget();
  }
}

class CartProvider extends InheritedWidget {
  final int count;

  const CartProvider({
    Key key,
    this.count,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CartProvider oldWidget) => false;

  static CartProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }
}

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      count: count,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const AWidgetThatUsesCart(),
              const SizedBox(height: 16,),
              AnotherWidgetThatUsesCart(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Add"),
                    onPressed: () => setState(() => count++),
                  ),
                  FlatButton(
                    child: Text("Remove"),
                    onPressed: () => setState(() => count--),
                  ),
                ],
              ),
              FlatButton(
                child: Text("Next page"),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CartProvider(
                      count: count,
                      child: AnotherPage(),
                    )
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class AWidgetThatUsesCart extends StatelessWidget {
  const AWidgetThatUsesCart();

  @override
  Widget build(BuildContext context) {
    final cartProvider = CartProvider.of(context);

    return Center(
      child: Text(
        "AWidgetThatUsesCart: ${cartProvider.count.toString()}"
      ),
    );
  }
}

class AnotherWidgetThatUsesCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = CartProvider.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "AnotherWidgetThatUsesCart: ${cartProvider.count.toString()}"
        ),
        const SizedBox(height: 16,),
        WidgetInsideAnotherWidget()
      ],
    );
  }
}

class WidgetInsideAnotherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = CartProvider.of(context);

    return Center(
      child: Text(
        "WidgetInsideAnotherWidget: ${cartProvider.count.toString()}"
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = CartProvider.of(context);

    return Scaffold(
      body: Center(
        child: Text(
          "AnotherPage: ${cartProvider.count.toString()}"
        ),
      ),
    );
  }
}