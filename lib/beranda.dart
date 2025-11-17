import 'package:flutter/material.dart';

class Halaman_Utama extends StatefulWidget {
  const Halaman_Utama({super.key});

  @override
  State<Halaman_Utama> createState() => _Halaman_UtamaState();
}

class _Halaman_UtamaState extends State<Halaman_Utama> {
  final TextEditingController _namaController = TextEditingController();
   final TextEditingController _alamatController = TextEditingController();
  final List<String> _prodiList = ['Informatika', 'Mesin', 'Sipil', 'Arsitek'];
  String? _selectedProdi;
  String _jenisKelamin = 'Pria';

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  void _showModal() {
    final nama = _namaController.text.trim();
    final alamat = _alamatController.text.trim();
    final prodi = _selectedProdi ?? '-';
    final jk = _jenisKelamin;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Data'),
        content: Text('Nama: $nama\nALamat: $alamat\n $prodi\nJenis Kelamin: $jk'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
             TextField(
              controller: _alamatController,
              decoration: const InputDecoration(labelText: 'Alamat', border: OutlineInputBorder()),
            ),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('Pilih Prodi'),
              value: _selectedProdi,
              items: _prodiList.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => _selectedProdi = v),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Jenis Kelamin:'),
                const SizedBox(width: 12),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Pria',
                      groupValue: _jenisKelamin,
                      onChanged: (v) => setState(() => _jenisKelamin = v!),
                    ),
                    const Text('Pria'),
                  ],
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Perempuan',
                      groupValue: _jenisKelamin,
                      onChanged: (v) => setState(() => _jenisKelamin = v!),
                    ),
                    const Text('Perempuan'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showModal,
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
