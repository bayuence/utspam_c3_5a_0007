class User {
  String nama;
  String nik;
  String email;
  String telepon;
  String alamat;
  String username;
  String password;

  User({
    required this.nama,
    required this.nik,
    required this.email,
    required this.telepon,
    required this.alamat,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "nama": nama,
      "nik": nik,
      "email": email,
      "telepon": telepon,
      "alamat": alamat,
      "username": username,
      "password": password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nama: map["nama"],
      nik: map["nik"],
      email: map["email"],
      telepon: map["telepon"],
      alamat: map["alamat"],
      username: map["username"],
      password: map["password"],
    );
  }
}
