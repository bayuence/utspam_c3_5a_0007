class CarModel {
  final int id;
  final String namaMobil;
  final int hargaSewa;
  final String imageUrl;
  final String deskripsi;
  final bool tersedia;

  CarModel({
    required this.id,
    required this.namaMobil,
    required this.hargaSewa,
    required this.imageUrl,
    required this.deskripsi,
    required this.tersedia,
  });

  //ubah car ke map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namaMobil': namaMobil,
      'hargaSewa': hargaSewa,
      'imageUrl': imageUrl,
      'deskripsi': deskripsi,
      'tersedia': tersedia,
    };
  }

  //ubah json ke car model
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      namaMobil: json['namaMobil'],
      hargaSewa: json['hargaSewa'],
      imageUrl: json['imageUrl'],
      deskripsi: json['deskripsi'],
      tersedia: json['tersedia'],
    );
  }
}