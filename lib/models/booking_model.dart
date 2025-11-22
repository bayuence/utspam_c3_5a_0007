class BookingModel {
  final String namaPenyewa;
  final String mobil;
  final String tanggalMulai;
  final String tanggalSelesai;

  BookingModel({
    required this.namaPenyewa,
    required this.mobil,
    required this.tanggalMulai,
    required this.tanggalSelesai,
  });

  // untuk SharedPreferences
  Map<String, dynamic> toJson() => {
    "namaPenyewa": namaPenyewa,
    "mobil": mobil,
    "tanggalMulai": tanggalMulai,
    "tanggalSelesai": tanggalSelesai,
  };
}
