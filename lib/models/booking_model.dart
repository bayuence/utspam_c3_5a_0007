class BookingModel {
  final int bookingId;
  final int carId;
  final String username;
  final int durasiSewa;
  final int totalHarga;
  final String tanggal;
  final bool selesai;

  BookingModel({
    required this.bookingId,
    required this.carId,
    required this.username,
    required this.durasiSewa,
    required this.totalHarga,
    required this.tanggal,
    required this.selesai,
  });

  //ubah booking ke map
  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'carId': carId,
      'username': username,
      'durasiSewa': durasiSewa,
      'totalHarga': totalHarga,
      'tanggal': tanggal,
      'selesai': selesai,
    };
  }

  //ubah json ke booking model
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'],
      carId: json['carId'],
      username: json['username'],
      durasiSewa: json['durasiSewa'],
      totalHarga: json['totalHarga'],
      tanggal: json['tanggal'],
      selesai: json['selesai'],
    );
  }
}