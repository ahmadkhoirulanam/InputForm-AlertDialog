import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Halaman_Utama extends StatefulWidget {
  const Halaman_Utama({super.key});

  @override
  State<Halaman_Utama> createState() => _Halaman_UtamaState();
}

class _Halaman_UtamaState extends State<Halaman_Utama> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _npmController = TextEditingController();
  final List<String> _prodiList = ['Informatika', 'Mesin', 'Sipil', 'Arsitek'];
  final List<String> _kelasList = ['A', 'B', 'C', 'D', 'E'];
  String? _selectedKelas;
  String? _selectedProdi;
  String _jenisKelamin = 'Pria';

  // Ini variabel tempat menyimpan data entri-form yang sedang ditampilkan di layar (ListView).
  List<Map<String, dynamic>> _items = [];
  static const String _prefsKey = 'submissions';

 
  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  // membersihkan (release) resource yang tidak otomatis dibuang oleh Dart/Flutter agar tidak terjadi memory leak.
  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _npmController.dispose();
    super.dispose();
  }

  // memuat (read) data yang sebelumnya disimpan supaya ListView di UI bisa menampilkan data itu.
  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? raw = prefs.getStringList(_prefsKey);
    if (raw != null) {
      setState(() {
        _items = raw.map((s) => jsonDecode(s) as Map<String, dynamic>).toList();
      });
    }
  }

  // bertugas menyimpan semua entri _items ke penyimpanan lokal (SharedPreferences)
  Future<void> _saveAll() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> raw = _items.map((m) => jsonEncode(m)).toList();
    await prefs.setStringList(_prefsKey, raw);
  }


  void _addItem() {
    final nama = _namaController.text.trim();
    final alamat = _alamatController.text.trim();
    final npm = _npmController.text.trim();

    if (nama.isEmpty || npm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan NPM wajib diisi')),
      );
      return;
    }

    final item = {
      'nama': nama,
      'alamat': alamat,
      'npm': npm,
      'kelas': _selectedKelas ?? '-',
      'prodi': _selectedProdi ?? '-',
      'jk': _jenisKelamin,
      'createdAt': DateTime.now().toIso8601String(),
    };

    setState(() {
      _items.insert(0, item);
    });

    _saveAll();

    _namaController.clear();
    _alamatController.clear();
    _npmController.clear();
    setState(() {
      _selectedKelas = null;
      _selectedProdi = null;
      _jenisKelamin = 'Pria';
    });
  }

  Future<void> _removeItem(int index) async {
    setState(() {
      _items.removeAt(index);
    });
    await _saveAll();
  }

  void _showDetail(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Detail'),
        content: Text(
          'Nama: ${item['nama']}\n'
          'Alamat: ${item['alamat']}\n'
          'NPM: ${item['npm']}\n'
          'Kelas: ${item['kelas']}\n'
          'Prodi: ${item['prodi']}\n'
          'Jenis Kelamin: ${item['jk']}\n'
          'Waktu: ${item['createdAt']}',
        ),
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
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _alamatController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _npmController,
              decoration: const InputDecoration(
                labelText: 'NPM',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              isExpanded: true,
              hint: const Text('Pilih Kelas'),
              decoration: const InputDecoration(
                labelText: 'Kelas',
                border: OutlineInputBorder(),
              ),
              value: _selectedKelas,

              items: _kelasList
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedKelas = v),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              isExpanded: true,
              hint: const Text('Pilih Prodi'),
              decoration: const InputDecoration(
                labelText: 'Prodi',
                border: OutlineInputBorder(),
              ),
              value: _selectedProdi,
              items: _prodiList
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
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
                // mengirim ke _addItem
                onPressed: _addItem,
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            // List area
            Expanded(
              child: _items.isEmpty
                  ? const Center(child: Text('Belum ada data'))
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return Dismissible(
                          key: Key(item['createdAt'] ?? index.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete),
                          ),
                          onDismissed: (_) => _removeItem(index),
                          child: ListTile(
                            title: Text(item['nama'] ?? '-'),
                            subtitle:
                                Text('${item['npm'] ?? '-'} • ${item['prodi'] ?? '-'}'),
                            trailing: Text(item['kelas'] ?? '-'),
                            onTap: () => _showDetail(item),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
