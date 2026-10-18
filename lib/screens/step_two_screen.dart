import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user_profile.dart';
import '../utils/validators.dart';
import 'summary_screen.dart';

// Accepte les chiffres et un seul séparateur décimal.
class TjmInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final valide = RegExp(r'^\d*([.,]\d*)?$').hasMatch(newValue.text);
    return valide ? newValue : oldValue;
  }
}

class StepTwoScreen extends StatefulWidget {
  final UserProfile profil;

  const StepTwoScreen({
    super.key,
    required this.profil,
  });

  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _professionCtrl = TextEditingController();
  final _experienceCtrl = TextEditingController();
  final _tjmCtrl = TextEditingController();
  final _biographieCtrl = TextEditingController();

  @override
  void dispose() {
    _professionCtrl.dispose();
    _experienceCtrl.dispose();
    _tjmCtrl.dispose();
    _biographieCtrl.dispose();
    super.dispose();
  }

  void _suivant() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez corriger les champs en rouge'),
        ),
      );
      return;
    }

    final profilComplet = widget.profil.copyWith(
      profession: _professionCtrl.text.trim(),
      experience: int.parse(_experienceCtrl.text.trim()),
      tjm: double.parse(
        _tjmCtrl.text.trim().replaceAll(',', '.'),
      ),
      biographie: _biographieCtrl.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SummaryScreen(profil: profilComplet),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Retour',
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profil professionnel – Étape 2/3'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 2 / 3),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _professionCtrl,
                decoration: const InputDecoration(
                  labelText: 'Profession',
                  prefixIcon: Icon(Icons.work_outline),
                ),
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                validator: Validators.profession,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _experienceCtrl,
                decoration: const InputDecoration(
                  labelText: "Années d'expérience",
                  helperText: 'Entre 0 et 50 ans',
                  prefixIcon: Icon(Icons.timeline),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputAction: TextInputAction.next,
                validator: Validators.experience,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tjmCtrl,
                decoration: const InputDecoration(
                  labelText: 'Tarif journalier moyen',
                  helperText: 'Entre 50 et 3000 €',
                  prefixIcon: Icon(Icons.euro),
                  suffixText: '€',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [TjmInputFormatter()],
                textInputAction: TextInputAction.next,
                validator: Validators.tjm,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _biographieCtrl,
                decoration: const InputDecoration(
                  labelText: 'Biographie',
                  helperText: 'Facultative, au moins 20 caractères si remplie',
                  helperMaxLines: 2,
                  prefixIcon: Icon(Icons.notes),
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 5,
                maxLength: 300,
                validator: Validators.biographie,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _suivant,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Suivant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}