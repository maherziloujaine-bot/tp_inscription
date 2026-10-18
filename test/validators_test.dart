import 'package:flutter_test/flutter_test.dart';
import 'package:tp_inscription/utils/validators.dart';

void main() {
  group('Nom et prénom', () {
    test('refuse les espaces seuls', () {
      expect(Validators.nom('   '), isNotNull);
    });

    test('refuse un nom trop court', () {
      expect(Validators.nom('A'), isNotNull);
    });

    test('refuse les chiffres', () {
      expect(Validators.nom('Ben 3li'), isNotNull);
    });

    test('accepte les accents, tirets et apostrophes', () {
      expect(Validators.nom("Élodie-Anne D'Or"), isNull);
    });
  });

  group('E-mail', () {
    test('refuse une valeur vide', () {
      expect(Validators.email(''), isNotNull);
    });

    test('refuse une adresse sans extension', () {
      expect(Validators.email('ali@gmail'), isNotNull);
    });

    test('accepte une adresse valide', () {
      expect(Validators.email('ali.ben@gmail.com'), isNull);
    });
  });

  group('Mot de passe', () {
    test('refuse un mot de passe trop court', () {
      expect(Validators.motDePasse('Ab1'), 'Au moins 8 caractères');
    });

    test('exige une majuscule', () {
      expect(
        Validators.motDePasse('bonjour12'),
        'Au moins une lettre majuscule',
      );
    });

    test('exige un chiffre', () {
      expect(
        Validators.motDePasse('Bonjourrr'),
        'Au moins un chiffre',
      );
    });

    test('accepte un mot de passe valide', () {
      expect(Validators.motDePasse('Bonjour12'), isNull);
    });
  });

  group('Confirmation', () {
    test('refuse une confirmation vide', () {
      expect(Validators.confirmation('', 'Bonjour12'), isNotNull);
    });

    test('refuse des mots de passe différents', () {
      expect(
        Validators.confirmation('Bonjour12', 'Bonjour13'),
        isNotNull,
      );
    });

    test('accepte des mots de passe identiques', () {
      expect(
        Validators.confirmation('Bonjour12', 'Bonjour12'),
        isNull,
      );
    });
  });

  group('Profession', () {
    test('refuse une profession vide', () {
      expect(Validators.profession(''), isNotNull);
    });

    test('accepte une profession valide', () {
      expect(Validators.profession('Développeur'), isNull);
    });
  });

  group('Expérience', () {
    test('accepte les limites 0 et 50', () {
      expect(Validators.experience('0'), isNull);
      expect(Validators.experience('50'), isNull);
    });

    test('refuse une valeur hors limites', () {
      expect(Validators.experience('-1'), isNotNull);
      expect(Validators.experience('51'), isNotNull);
    });

    test('refuse un nombre décimal', () {
      expect(Validators.experience('2.5'), isNotNull);
    });
  });

  group('TJM', () {
    test('accepte une virgule', () {
      expect(Validators.tjm('350,50'), isNull);
    });

    test('accepte les limites 50 et 3000', () {
      expect(Validators.tjm('50'), isNull);
      expect(Validators.tjm('3000'), isNull);
    });

    test('refuse les montants hors limites', () {
      expect(Validators.tjm('25'), isNotNull);
      expect(Validators.tjm('3001'), isNotNull);
    });

    test('refuse un montant invalide', () {
      expect(Validators.tjm('abc'), isNotNull);
      expect(Validators.tjm('NaN'), isNotNull);
    });
  });

  group('Biographie', () {
    test('accepte une biographie vide', () {
      expect(Validators.biographie(''), isNull);
    });

    test('refuse une biographie trop courte', () {
      expect(Validators.biographie('Je code.'), isNotNull);
    });

    test('accepte une biographie valide', () {
      expect(
        Validators.biographie(
          'Je suis développeur Flutter et je crée des applications.',
        ),
        isNull,
      );
    });

    test('refuse plus de 300 caractères', () {
      expect(
        Validators.biographie(List.filled(301, 'a').join()),
        isNotNull,
      );
    });
  });
}