
import 'package:flutter/material.dart';

import 'package:futurebuilder_example/api/users_api.dart';
import 'package:futurebuilder_example/model/user.dart';
import 'package:futurebuilder_example/page/user_page.dart';

class UserLocalPage extends StatelessWidget {
  const UserLocalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: UsersApi.getUsersLocally(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Unable to load local JSON data.\n\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final List<User> users = snapshot.data ?? <User>[];

        if (users.isEmpty) {
          return const Center(
            child: Text('No users found in the local JSON file.'),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.urlAvatar.isNotEmpty
                    ? NetworkImage(user.urlAvatar)
                    : null,
                child: user.urlAvatar.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(user.username),
              subtitle: Text(user.email),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UserPage(user: user),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
