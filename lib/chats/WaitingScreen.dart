import 'dart:async';
import 'package:flutter/material.dart';
import 'package:epst_app/chats/ApiService.dart';
import 'package:epst_app/chats/ChatScreen.dart';
import 'package:epst_app/chats/Conversation.dart';

class WaitingScreen extends StatefulWidget {
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  Conversation? _conversation;
  bool _isWaiting = false;
  int index = 0;
  Timer? tt;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    tt?.cancel();
    super.dispose();
  }

  void _startConversation() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer votre nom.")),
      );
      return;
    }

    setState(() {
      _isWaiting = true;
      index++;
    });

    try {
      final conversation =
          await ApiService().startConversation(_nameController.text);
      setState(() => _conversation = conversation);
      _checkConversationStatus();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erreur: $e')));
      setState(() => _isWaiting = false);
    }
  }

  void _checkConversationStatus() async {
    tt = Timer.periodic(const Duration(seconds: 5), (t) async {
      index++;
      _conversation =
          await ApiService().checkConversation(_conversation?.id ?? 0);

      if (_conversation?.status == ConversationStatus.ACTIVE) {
        t.cancel();
        tt?.cancel();
        setState(() => _isWaiting = false);
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(conversation: _conversation!),
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'Support Client',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child:
              !_isWaiting ? _buildStartView(theme) : _buildWaitingView(theme),
        ),
      ),
    );
  }

  Widget _buildStartView(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.support_agent_rounded, size: 80, color: Colors.blueAccent),
          const SizedBox(height: 24),
          Text(
            'Bienvenue au support client',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Veuillez entrer votre nom pour démarrer une conversation.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Votre nom',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _startConversation,
              child: const Text(
                'Démarrer la conversation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingView(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: _controller,
          child: const Icon(Icons.hourglass_empty_rounded,
              size: 80, color: Colors.blueAccent),
        ),
        const SizedBox(height: 24),
        Text(
          "En attente d’un agent...",
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          "Votre position dans la file : 1",
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: 24),
        CircularProgressIndicator(
          color: Colors.blueAccent,
          strokeWidth: 3,
        ),
        const SizedBox(height: 16),
        Text(
          "Tentative #$index",
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
