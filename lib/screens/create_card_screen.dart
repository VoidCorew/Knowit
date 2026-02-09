import 'package:flutter/material.dart';
import 'package:knowit/models/card_item.dart';
import 'package:knowit/widgets/custom_button.dart';

class CreateCardScreen extends StatefulWidget {
  final String collectionId;
  final void Function(CardItem) onCreate;

  const CreateCardScreen({
    super.key,
    required this.collectionId,
    required this.onCreate,
  });

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final frontController = TextEditingController();
  final backController = TextEditingController();
  String emoji = "";

  @override
  void dispose() {
    frontController.dispose();
    backController.dispose();
    super.dispose();
  }

  bool get canSave => frontController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Card")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: frontController,
              decoration: const InputDecoration(
                labelText: "Front",
                hintText: "Enter question or term",
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: backController,
              decoration: const InputDecoration(
                labelText: "Back",
                hintText: "Enter answer",
              ),
            ),

            const SizedBox(height: 16),

            CustomButton(
              text: "Create Card",
              onPressed: () {
                final frontText = frontController.text.trim();
                final backText = backController.text.trim();

                if (frontText.isEmpty || backText.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You did not fill all fields!'),
                    ),
                  );
                  return;
                }

                final newCard = CardItem(
                  frontText: frontText,
                  backText: backText,
                  collectionId: widget.collectionId,
                );

                widget.onCreate(newCard);
                Navigator.pop(context, newCard);
              },
            ),
          ],
        ),
      ),
    );
  }
}
