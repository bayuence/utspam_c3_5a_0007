import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // simpan data user
  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonUser = jsonEncode(user);
    await prefs.setString('user', jsonUser);
  }

  // ambil data user
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonUser = prefs.getString('user');

    if (jsonUser == null) return null;
    return jsonDecode(jsonUser);
  }

  // hapus data user (logout)
  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  // simpan riwayat sewa
  Future<void> saveRiwayat(List<Map<String, dynamic>> listTransaksi) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonList = jsonEncode(listTransaksi);
    await prefs.setString('riwayat', jsonList);
  }

  // ambil riwayat sewa
  Future<List<Map<String, dynamic>>> getRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonList = prefs.getString('riwayat');

    if (jsonList == null) return [];

    List decoded = jsonDecode(jsonList);
    return decoded.map((e) => e as Map<String, dynamic>).toList();
  }

  // TAMBAH TRANSAKSI BARU

  Future<void> addTransaksi(Map<String, dynamic> transaksiBaru) async {
    List<Map<String, dynamic>> riwayat = await getRiwayat();
    riwayat.add(transaksiBaru);
    await saveRiwayat(riwayat);
  }

  // UPDATE TRANSAKSI
  Future<void> updateTransaksi(int index, Map<String, dynamic> newData) async {
    List<Map<String, dynamic>> riwayat = await getRiwayat();

    if (index < riwayat.length) {
      riwayat[index] = newData;
      await saveRiwayat(riwayat);
    }
  }

  // HAPUS TRANSAKSI
  Future<void> deleteTransaksi(int index) async {
    List<Map<String, dynamic>> riwayat = await getRiwayat();

    if (index < riwayat.length) {
      riwayat.removeAt(index);
      await saveRiwayat(riwayat);
    }
  }

  // HAPUS SEMUA DATA
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // simpansewalist
  Future<void> saveRiwayatList(List data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('riwayat', jsonEncode(data));
  }
}
