import 'package:flutter/material.dart';
import 'package:user_manager/models/user.dart';
import '../db/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final dbHelper = DatabaseHelper();
  List<User> users = [];

  Future<void> _loadUsers() async {
    final data = await dbHelper.getUsers();
    setState(() {
      users = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Manager'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];

            // return one Card per user
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(child: Text(user.name[0].toUpperCase())),
                title: Text(user.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await dbHelper.deleteUser(users[index].id);
                        await _loadUsers();
                        if (!mounted) return;
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: Center(
                              child: Text('User Deleted Successfully'),
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final updatedName = await Navigator.pushNamed(
                          context,
                          '/edit',
                          arguments: user,
                        );
                        if (updatedName != null && updatedName is String) {
                          final updatedUser = User(
                            id: users[index].id,
                            name: updatedName,
                          );
                          await dbHelper.updateUser(updatedUser);
                          await _loadUsers();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/profile',
                          arguments: user,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newUser = await Navigator.pushNamed(context, '/add');
          if (newUser != null && newUser is User) {
            await dbHelper.insertUser(newUser);
            await _loadUsers();
            if (!mounted) return;
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Center(child: Text('User Added Successfully')),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
