import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileApprenant extends StatelessWidget {
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
            leading: Container(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                "assets/UiwUser.svg",
                semanticsLabel: 'Acme Logo',
                color: Colors.black,
              ),
            ),
            title: Text(
              "Pierre Lungu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Enseignant",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          ListTile(
            onTap: () {
              //
            },
            leading: Container(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                "assets/UiwUser.svg",
                semanticsLabel: 'Acme Logo',
                color: Colors.black,
              ),
            ),
            title: Text(
              "Joel Lungu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
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
        child: Icon(Icons.add),
      ),
    );
  }
}
