import 'package:photo_album/domain/exceptions/app_externo_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class EnviarEmail {
  static void enviaremail(String emailDestino) async {
    final assunto = ('');
    final mensagem = ('');

    final Uri link = Uri.parse(
      'mailto:$emailDestino?subject=$assunto&body=$mensagem',
    );

    try {
      if (await canLaunchUrl(link)) {
        await launchUrl(link, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      throw AppExternoException(e.toString());
    }
  }
}
