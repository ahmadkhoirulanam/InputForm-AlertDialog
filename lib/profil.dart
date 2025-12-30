import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Halaman_Profil extends StatelessWidget {
  const Halaman_Profil({super.key});

  Future<void> _launchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Tidak dapat membuka ${uri.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Profil"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // TELEPON
            ElevatedButton.icon(
              icon: const Icon(Icons.phone),
              label: const Text("Hubungi Kami"),
              onPressed: () {
                _launchUrl(Uri.parse("tel:081234567890"));
              },
            ),

            const SizedBox(height: 12),

            // WHATSAPP
            ElevatedButton.icon(
              icon: const Icon(Icons.chat),
              label: const Text("Chat via WhatsApp"),
              onPressed: () {
                _launchUrl(Uri.parse("https://wa.me/6281234567890"));
              },
            ),

            const SizedBox(height: 12),

            // EMAIL
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text("Kirim Email"),
              onPressed: () {
                _launchUrl(
                  Uri(
                    scheme: 'mailto',
                    path: 'contoh@email.com',
                    queryParameters: {
                      'subject': 'Halo',
                      'body': 'Ini pesan dari aplikasi Flutter',
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
