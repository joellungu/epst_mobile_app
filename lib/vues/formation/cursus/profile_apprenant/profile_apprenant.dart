import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileApprenant extends StatelessWidget {
  const ProfileApprenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              //
            },
            leading: SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                "assets/UiwUser.svg",
                semanticsLabel: 'Acme Logo',
                color: Colors.black,
              ),
            ),
            title: const Text(
              "Pierre Lungu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              "Enseignant",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                "assets/UiwUser.svg",
                semanticsLabel: 'Acme Logo',
                color: Colors.black,
              ),
            ),
            title: const Text(
              "Joel Lungu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              "Elève",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
