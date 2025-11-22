class CarModel {
  final String nama;
  final String gambarUrl;
  final int hargaPerHari;

  CarModel({
    required this.nama,
    required this.gambarUrl,
    required this.hargaPerHari,
  });
}

// daftar mobil default
List<CarModel> daftarMobil = [
  CarModel(
    nama: "Toyota Avanza",
    gambarUrl: "https://i.ibb.co/9nXk7Jq/avanza.jpg",
    hargaPerHari: 350000,
  ),
  CarModel(
    nama: "Honda Brio",
    gambarUrl: "https://i.ibb.co/qN5RbKp/brio.jpg",
    hargaPerHari: 300000,
  ),
  CarModel(
    nama: "Mitsubishi Pajero",
    gambarUrl: "https://i.ibb.co/8xnDkc6/pajero.jpg",
    hargaPerHari: 850000,
  ),
];
