import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class LettuceTypesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text("Types of Lettuce"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Image.asset("assets/romaine1.png"),
              title: Text("Romaine"),
              subtitle: Text("Also known as cos lettuce, this variety has long, crisp leaves and a slightly bitter taste."),
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/Butterhead1.png"),
              title: Text("Butterhead"),
              subtitle: Text("This variety has soft, tender leaves and a mild, buttery flavor. It is often used in salads and sandwiches."),
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/GreenLeaf1 .png"),
              title: Text("Iceberg"),
              subtitle: Text("This variety is known for its crunchy texture and mild flavor. It is often used in salads and as a topping for burgers."),
            ),
          ),
          Card(
            child: ListTile(
              leading: Image.asset("assets/oakleaf1.png"),
              title: Text("Red Leaf"),
              subtitle: Text("This variety has red-tinged leaves and a slightly bitter taste. It is often used in salads and sandwiches."),
            ),
          ),
        ],
      ),
    );
  }
}
