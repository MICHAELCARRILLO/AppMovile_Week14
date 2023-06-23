import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week14_s1/ui/new_user.dart';

import '../database/database.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  late AppDatabase appDatabase;

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: appDatabase.getListUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> myUsers = snapshot.data!;
            return ListView.builder(
                itemCount: myUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(myUsers[index].nombre),
                    subtitle: Text(myUsers[index].correo),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addUser();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addUser() async {
    var res = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewUser()));

    if (res != null && res == true) {
      setState(() {});
    }
  }
}
