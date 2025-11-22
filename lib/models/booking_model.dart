class BookingModel {
  final String namaPenyewa;
  final String mobil;
  final String tanggalSewa;
  final String tanggalKembali;
  final int totalHarga;

  BookingModel({
    required this.namaPenyewa,
    required this.mobil,
    required this.tanggalSewa,
    required this.tanggalKembali,
    required this.totalHarga,
  });

  // simpan ke SharedPref
  Map<String, dynamic> toJson() {
    return {
      "namaPenyewa": namaPenyewa,
      "mobil": mobil,
      "tanggalSewa": tanggalSewa,
      "tanggalKembali": tanggalKembali,
      "totalHarga": totalHarga,
    };
  }

  // ambil dari SharedPref
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      namaPenyewa: json["namaPenyewa"],
      mobil: json["mobil"],
      tanggalSewa: json["tanggalSewa"],
      tanggalKembali: json["tanggalKembali"],
      totalHarga: json["totalHarga"],
    );
  }
}
