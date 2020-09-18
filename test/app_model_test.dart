import 'package:covid19_pesquisa/model/app_model.dart';
import 'package:covid19_pesquisa/util/conexao.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TESTA ENTRAR:VALIDATION', () {
    final AppModel estado = AppModel();

    test('Testa estado inicial email == null', () {
      //--- testa estado inicial == false
      expect(estado.entrarValidation.email.valor, null);
    });

    test('Testa email dever valido =>  erro == null', () {
      estado.entrarValidation.changeEmail("milton.vincenttis@gmail.com");
      expect(estado.entrarValidation.email.erro, null);
    });

    test(
        'Testa 1o: email válido, depois trocado para invalido:  email dever invalido =>  erro != null',
        () {
      estado.entrarValidation.changeEmail("milton.vincenttis@gmail.com");
      expect(estado.entrarValidation.email.erro, null);

      estado.entrarValidation.changeEmail("aaaa");
      expect(estado.entrarValidation.email.erro, isNotNull);
    });

    test( 'Testa a lib EmailValidator', () {
      expect(EmailValidator.validate("milton.vincenttis@gmail.com"), true);
      expect(EmailValidator.validate("milton.vincenttisgmailcom"), false);

    });
  });

  group('TESTA ESTADO DO APP', () {
    final AppModel estado = AppModel();

    test('Testa estado inicial == false', () {
      //--- testa estado inicial == false
      expect(estado.isLogado, false);
    });

    test('Testa alteracao de estado para Logado', () {
      estado.isLogado = true;
      expect(estado.isLogado, true);
    });

    test('Testa estado conexao ativa de internet', () async {
      await isConectado().then((value) => estado.hasConexao = value);
      expect(estado.hasConexao, true);
    });
  });
}
