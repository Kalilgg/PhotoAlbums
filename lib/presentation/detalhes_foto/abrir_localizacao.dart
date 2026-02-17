import 'package:photo_album/domain/exceptions/app_externo_exception.dart';
import 'package:url_launcher/url_launcher.dart';

class AbrirLocalizacao {
  static void abrirLocalizacao(String latitude, String longitude) async {
    final Uri link = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
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
