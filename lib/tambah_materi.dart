import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TambahMateri extends StatefulWidget {
  const TambahMateri({Key? key}) : super(key: key);

  @override
  _TambahMateriState createState() => _TambahMateriState();
}

class _TambahMateriState extends State<TambahMateri> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  void dispose() {
    kodeController.dispose();
    namaController.dispose();
    deskripsiController.dispose();
    urlController.dispose();
    super.dispose();
  }

  void _submitForm(){
    DocumentReference documentReference = FirebaseFirestore.instance.collection('materi').doc(kodeController.text);

      // Simpan ke Firestore
      Map <String, dynamic> mtr = ({
        'kode': kodeController,
        'nama': namaController,
        'deskripsi': deskripsiController,
        'url': urlController,
      });
          
        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                controller: kodeController,
                decoration: const InputDecoration(labelText: 'Kode'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: urlController,
                decoration: const InputDecoration(labelText: 'URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'URL tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}