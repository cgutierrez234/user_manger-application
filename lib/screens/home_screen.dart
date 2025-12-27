import 'package:flutter/material.dart';
import 'package:user_manager/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<User> users = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Manager'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];

            // return one widget per user
            return ListTile(
              title: Text(user.name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    users.removeAt(index);
                  });
                }
              ),
            );
          }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await Navigator.pushNamed(context, '/add');
          if(newUser != null && newUser is User) {
            setState(() {
              users.add(newUser);
            });
          }
        },
        child:const Icon(Icons.add),
      ),
    );
  }

}