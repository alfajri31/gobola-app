# gobola_app

A Flutter project for learning and practicing UI layout concepts.

## Getting Started

Catatan pembelajaran selama latihan Flutter:

1. Kalau ingin punya jarak seperti m-auto, gunakan `Spacer()`.
2. Kalau ingin tampilan bersifat absolut (bertumpuk), gunakan `Stack`.
3. Jika ingin mengatur posisi bebas di dalam Stack, gunakan `Positioned()` (bukan Stack-nya, tapi isi widget-nya).
4. Jika menggunakan `setState`, maka gunakan `StatefulWidget`.
5. Jika tidak menggunakan `setState`, maka gunakan `StatelessWidget`.
6. Jika ingin ukuran maksimal mengikuti parent, gunakan `double.infinity`.
7. Jika ingin efek transform/translate, gunakan `TweenAnimationBuilder`.
8. Jika ingin susunan dari atas ke bawah, gunakan `Column` (vertical).
9. Jika ingin susunan ke samping, gunakan `Row` (horizontal).
10. Jika ingin child berada di posisi center, left, dll, gunakan `Align()`, dengan catatan `Align` tidak efektif di dalam `Row`.
11. Jika ingin mengatur posisi tanpa `Align()`, bisa menggunakan `Padding` secara manual.
12. Jika ingin cepat mengganti asset, gunakan `Text` sebagai placeholder sebelum diganti dengan asset asli.
13. Jika ingin child memiliki lebar dan tinggi sama dengan parent, gunakan `Positioned.fill()`.
14. Jika ingin membungkus widget secara otomatis di Android Studio, tekan `Alt + Enter`, lalu pilih parent/wrapper yang diinginkan.
15. Jika menggunakan DTO, maka cara mengakses datanya menggunakan property, contoh: `widget.data?.league` (jika field tersebut bernama `league` di dalam object `data`).
16. Jika menggunakan response API tanpa DTO (masih berupa `Map<String, dynamic>`), maka cara mengaksesnya menggunakan key, contoh: `widget.data['league']` (jika `league` berada di dalam property `data`).
---

## 💡 Notes
Belajar Flutter itu tentang memahami **constraint dan layout system**.  
Jika layout terlihat tidak sesuai, biasanya karena parent tidak memberikan ukuran (constraint) yang jelas.