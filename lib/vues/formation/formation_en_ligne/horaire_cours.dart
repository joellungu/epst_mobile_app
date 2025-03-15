import 'package:flutter/material.dart';

class HoraireCours extends StatelessWidget {
  //
  int nbJours;
  //

  //
  HoraireCours(this.nbJours);

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      child: DefaultTabController(
        length: nbJours,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: ExactAssetImage("assets/LOGO-MINEPST-BON.png"),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      //color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    labelStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    tabs: List.generate(
                      nbJours,
                      (j) {
                        return Tab(
                          text: "Jr ${j + 1}",
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: List.generate(
                      nbJours,
                      (j) {
                        return Container();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
