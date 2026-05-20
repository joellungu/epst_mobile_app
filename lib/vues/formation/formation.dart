import 'package:enseignement_en_ligne/pages/cours/classes.dart';
import 'package:enseignement_en_ligne/pages/login/forgot.dart';
import 'package:enseignement_en_ligne/pages/login/signup.dart';
import 'package:epst_app/vues/bibliotheques/bibliotheque.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_keslassi_parent/pages/accueil.dart';

// ignore: must_be_immutable
class Formation extends StatefulWidget {
  String? titre;
  Formation({Key? key, this.titre}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Formation();
  }
}

class _Formation extends State<Formation> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              dividerColor: Colors.white,
              indicatorColor: Colors.black,
              labelStyle: const TextStyle(color: Colors.black),
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: const [
                Tab(text: 'Parcours scolaire'),
                Tab(text: 'Ma classe en ligne'),
                Tab(text: 'Bibliothèque'),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  Accueil(),
                  const _OnlineClassLogin(),
                  Bibliotheque(propriete: 'Eleve'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnlineClassLogin extends StatefulWidget {
  const _OnlineClassLogin();

  @override
  State<_OnlineClassLogin> createState() => _OnlineClassLoginState();
}

class _OnlineClassLoginState extends State<_OnlineClassLogin> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_userNameController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      Get.to(Classes());
      Get.snackbar("Oups", "Veuillez saisir tous les champs.");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxHeight < 620;
            final logoSize = compact ? 92.0 : 136.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "assets/EPST APP.png",
                              height: logoSize,
                              width: logoSize,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: compact ? 16 : 24),
                        const Text(
                          "Connexion",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(height: compact ? 18 : 26),
                        _LoginField(
                          controller: _userNameController,
                          hintText: "Email ID",
                          iconAsset: "assets/HugeiconsAt.svg",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        _LoginField(
                          controller: _passwordController,
                          hintText: "Mot de passe",
                          iconAsset: "assets/HugeiconsCircleLock02.svg",
                          obscureText: _obscurePassword,
                          suffix: IconButton(
                            tooltip: _obscurePassword
                                ? "Afficher le mot de passe"
                                : "Masquer le mot de passe",
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: SvgPicture.asset(
                              _obscurePassword
                                  ? "assets/HugeiconsView.svg"
                                  : "assets/HugeiconsViewOff.svg",
                              colorFilter: const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Get.to(Forgot()),
                            child: const Text(
                              "Mot de passe oublié ?",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Connexion",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              "Pas de compte ?",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.to(Signup()),
                              child: const Text(
                                "Créer un compte",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String iconAsset;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;

  const _LoginField({
    required this.controller,
    required this.hintText,
    required this.iconAsset,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconAsset,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          height: 25,
          width: 25,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffix,
            ),
          ),
        ),
      ],
    );
  }
}
