import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text("Task Manager"),
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
        ],
      ), backgroundColor: Colors.blue,
      foregroundColor: Colors.white, titleTextStyle: TextStyle(fontWeight: .bold, fontSize: 20),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: ListTile(
                    leading:  CircleAvatar(child: Icon(Icons.task,color: Colors.grey,),),
                    title: Text('Task $index'),
                    subtitle: Text('Task $index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
