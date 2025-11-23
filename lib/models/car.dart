class Car {
  String nama;
  String jenis;
  int harga;
  String gambar;

  Car({
    required this.nama,
    required this.jenis,
    required this.harga,
    required this.gambar,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "jenis": jenis,
      "harga": harga,
      "gambar": gambar,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      nama: map["nama"],
      jenis: map["jenis"],
      harga: map["harga"],
      gambar: map["gambar"],
    );
  }
}
