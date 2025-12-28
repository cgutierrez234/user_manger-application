import 'package:flutter/material.dart';
//import 'package:user_manager/models/user.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final TextEditingController _updatedUserController = TextEditingController();

  @override 
  void dispose() {
    _updatedUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final user = ModalRoute.of(context)!.settings.arguments as User; // <----- extracts the user data from the current instance of the route or screen we are on. Not needed right now

    return Scaffold(
      appBar: AppBar(
        title:const Text('Edit User'),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _updatedUserController,
              decoration: InputDecoration(
                labelText: 'Enter new user name',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(_updatedUserController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You must enter an updated name'))
                  );
                  return;
                } else {
                  final updatedUserName = _updatedUserController.text.trim();
                  Navigator.pop(
                    context, updatedUserName
                  );
                }
              },
            child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}