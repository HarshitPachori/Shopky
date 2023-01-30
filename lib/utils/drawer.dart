import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopky/screens/my_order_screen/my_order_screen.dart';

import '../screens/authentication/auth_controller.dart';
import '../screens/cart_screen/cart_screen.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user.displayName.toString(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            accountEmail: Text(user.email.toString(),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            currentAccountPicture: const Icon(
              Icons.account_circle,
              size: 75,
              color: Colors.white,
            ),
            decoration: BoxDecoration(color: Colors.teal[800]),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text("Home Page"),
              leading: Icon(
                Icons.home,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text("My Account"),
              leading: Icon(
                Icons.person,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const MyOrderScreen());
            },
            child: ListTile(
              title: const Text("My Orders"),
              leading: Icon(
                Icons.shopping_basket,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => CartScreen());
            },
            child: ListTile(
              title: const Text("Shopping Cart"),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text("Favourites"),
              leading: Icon(
                Icons.favorite,
                color: Colors.teal.shade700,
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text("Settings"),
              leading: Icon(
                Icons.settings,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              AuthController.instance.signOut();
            },
            child: const ListTile(
              title: Text("Logout"),
              leading: Icon(
                Icons.person_remove,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              title: Text("About"),
              leading: Icon(
                Icons.info,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
