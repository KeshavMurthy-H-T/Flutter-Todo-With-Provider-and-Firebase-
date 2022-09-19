import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/AddNewTask.dart';
import 'package:todo/pages/AllTodoTask.dart';
import 'package:todo/pages/CompletedTask.dart';
import 'package:todo/service/auth.dart';
import 'package:todo/utils/Constants.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Welcome',
                      style: Constants.sideMenuHeaderStyle(context),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      user.displayName.toString(),
                      style: Constants.sideMenuHeaderStyle(context),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      user.email.toString(),
                      style: Constants.sideMenuHeaderStyle(context),
                    ),
                  ],
                )
              ],
            ),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/background2.jpg'))),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.black54,
            ),
            title: Text(
              'Home',
              style: Constants.sideMenuTextStyle(context),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              Icons.add_task_outlined,
              color: Colors.black54,
            ),
            title: Text(
              'Add New Todo Task',
              style: Constants.sideMenuTextStyle(context),
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNewTask()))
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.task_outlined,
              color: Colors.black54,
            ),
            title: Text(
              'All Todo Task',
              style: Constants.sideMenuTextStyle(context),
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AllTodoTask()))
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.task_alt,
              color: Colors.black54,
            ),
            title: Text(
              'Completed Task',
              style: Constants.sideMenuTextStyle(context),
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompletedTask()))
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            title: Text(
              'Logout',
              style: Constants.sideMenuTextStyle(context),
            ),
            onTap: () => {
              context.read<AuthMethods>().signOut(context),
            },
          ),
        ],
      ),
    );
  }
}
