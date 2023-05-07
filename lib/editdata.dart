import 'package:flutter/material.dart';
import 'package:flutter_crud/homepage.dart';
import 'package:http/http.dart' as http;

class EditDataPage extends StatefulWidget {
  final Map ListData;
  EditDataPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nim = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController tgl_lahir = TextEditingController();
  TextEditingController no_telp = TextEditingController();
  TextEditingController alamat = TextEditingController();

  Future _update() async {
    final respone = await http.post(
        Uri.parse('http://192.168.18.194/flutterapi/crudflutter/edit.php'),
        body: {
          "id": id.text,
          "nim": nim.text,
          "nama": nama.text,
          "tgl_lahir": tgl_lahir.text,
          "no_telp": no_telp.text,
          "alamat": alamat.text,
        });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData['id'];
    nim.text = widget.ListData['nim'];
    nama.text = widget.ListData['nama'];
    tgl_lahir.text = widget.ListData['tgl_lahir'];
    no_telp.text = widget.ListData['no_telp'];
    alamat.text = widget.ListData['alamat'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
      ),
      body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: nim,
                  decoration: InputDecoration(
                    hintText: "NIM",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "NIM Tidak Boleh Kosong";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nama,
                  decoration: InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama Tidak Boleh Kosong";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: tgl_lahir,
                  decoration: InputDecoration(
                    hintText: "Tgl Lahir",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Tgl Lahir Tidak Boleh Kosong";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: no_telp,
                  decoration: InputDecoration(
                    hintText: "No Telphone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "No Telph Tidak Boleh Kosong";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: alamat,
                  decoration: InputDecoration(
                    hintText: "Alamat",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat Tidak Boleh Kosong";
                    }
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _update().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data berhasil di update'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data gagal di update'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())),
                            (route) => false);
                      }
                    },
                    child: Text("Update"))
              ],
            ),
          )),
    );
  }
}
