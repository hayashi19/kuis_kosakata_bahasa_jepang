# [Kuis Kosakata Bahasa Jepang Versi Bahasa Indonesia 🇮🇩-🇯🇵 (New 4.0)](https://play.google.com/store/apps/details?id=com.japanesequiz.user0412)

![Logo](https://play-lh.googleusercontent.com/qtyUENi0_iNQJZ_MR40m4n1oDglRh6Li3diRyVoATPHkDIT8Hk6Q4sot06maHIZr4sU=w240-h480-rw)

### Dokumentasi ini dibuat dimulai dari versi 4.0 (untuk versi dibawahnya tidak ada).

---
---

## Daftar Isi

### [📝 Daftar Isi](#daftar-isi) • [📇 Deskripsi](#deskripsi) • [📖 Sumber Kosakata](#sumber-kosakata) • [📁 Asset Grafis](#asset-grafis) • [🔮 Fitur Aplikasi](#fitur-aplikasi) • [👍 Fiture Baru Versi 4](#fiture-baru-versi-4) • [🗓️ Roadmap Aplikasi](#roadmap-aplikasi)

---
---

## Deskripsi

❓ **Apa itu Kuis Kosakata Bahasa Jepang VBI?**

> **Kuis Kosakata Bahasa Jepang VBI merupakan aplikasi kuis dengan model flashcard**. Pengguna harus menjawab setiap kata yang akan di buat secara acak berdasarkan pengaturan yang telah ditentukan oleh pengguna itu sendiri.

<br>

🎯 **Tujuan pembuatan aplikasi?**

> Tujuan awal saya membuat aplikasi ini hanya untuk sebatas kebutuhan pribadi dalam belajar bahasa Jepang. Tapi saya putuskan untuk mempublikasikan aplikasi ini untuk yang lain dapat menggunakannya **untuk belajar menghafal kosakata-kosakata bahasa Jepang dan artinya dalam bahasa Indonesia**.

<br>

🔤 **Dapat dari mana kata-kata yang ada dalam aplikasi ini?**

> Aplikasi ini menggunakan beberapa sumber dalam pengambilan kata-kata. Tapi paling banyak diambil dari **sumber [Tagaini Jisho](https://www.tagaini.net/)**. Tagiani Jisho sendiri juga mengambil kata-kata dari beberapa sumber yang juga menjadi referensi untuk sumber-sumber kata dalam aplikasi ini. Untuk terjemahan bahasa Indonesia diambil dari **transalsi [Google Translate](https://translate.google.com/)**. Aplikasi ini menggunakan dua cara dalam pengambilan terjemahan arti bahasa Indonesianya. [1] Menggunakan terjemahan bahasa Inggris dari sumber-sumber di Tagaini Jisho, lalu mentranslasikannya ke dalam bahasa Indonesia. [2] Langsung mentranslasikan dari bahasa Jepang ke bahasa Indonesia.

<br>

🧑‍🦲 **Siapa yang buat aplikasi ini?**

> Saya sendiri merupakan **orang yang tertarik dalam mempelajari bahasa Jepang juga dan bukan sebagai pengajar bahasa Jepang atau orang yang ahli dibidangnya**.

<br>

Secara umum saya rasa penjelasan di atas dapat menjelaskan mengenai aplikasi ini. Jika ada **pertanyaa, saran, atau kesalahan mengenai aplikasi ini** (_error_, _bug_, atau kesalahan dalam arti dan tulisan kosakata-kosakata dalam aplikasi) **dapat memberikan komentar di [Google Play Store](https://play.google.com/store/apps/details?id=com.japanesequiz.user0412) atau email ke <hayashi19t@gmail.com>**. Saya akan usahakan untuk memperbaiki kesalahan secepatnya.

Terima Kasih

---

## Sumber Kosakata

📖 Berikut daftar sumber-sumber pangambilan kata-kata untuk aplikasi ini.

- [Tagaini Jisho](https://www.tagaini.net/)
- [jisho](https://jisho.org/)

---

## Asset Grafis

🌐 Berikut beberapa sumber online yang digunakan untuk assets grafis dalam aplikasi ini.

- Initial loading screen <https://lottiefiles.com/93884-typing>
- Correct sound effect <https://pixabay.com/sound-effects/id-124464/>
- Correct emoji <https://lottiefiles.com/91876-success-animation>
- Incorrect sound effect <https://pixabay.com/sound-effects/id-88735/>
- Incorrect emoji <https://lottiefiles.com/91878-bouncy-fail>
- Word not found <https://lottiefiles.com/86967-shiba-sad>

---

## Fitur Aplikasi

🔮 Berikut daftar aplikasi yang ada dalam aplikasi yang ada atau yang pernah ada.

- Terdapat 10.000 kata lebih yang dapat dipelajari.
- Bebagai jenis kata, mulai dari kata kerja, kata sifat, kata benda, kanji, kana, dll.
- Papan skor untuk melihat seberapa banyak yang benar atau salah.
- Menampilkan soal secara acak dan berbeda.
- Menampilkan soal berdsarkan pengaturan kuis yang telah di tentukan oleh pengguna itu sendiri.
- Dapat memilih bebagai macam jenis kata dan level pada pengaturan lebih dari satu.
- Dapat menjawab soal dalam tiga bentuk kanji/kana, romaji, dan bahasa.
- Terdapat kamus yang berisi banyak kata-kata.
- Dapat mencari dalam kolom pencarian di halaman kamus.
- Terdapat penjelasan lengkap setiap kata-katanya.

---
---

## Fiture Baru Versi 4
👍 Berikut merupakan daftar **perubahan-perubahan atau tambahan fitur aplikasi pada versi 4.0**.

- Tambahan kosakata yang lebih banyak. Sekitar **10.000 kata tersedia** dalam aplikasi ini. Mulai dari kosakata kata kerja, kata sifat, kata benda, kana, kanji, dll.
- Tambahan beberapa jenis kata-kata.
- Tambahan kata-kata hiragana dan katakana.
- Penggunaan sqlite dalam database penyimpanan kosakata.
- Pembaharuan tampilan UI.
- Dapat memilih lebih dari satu level.
- Dapat memilih lebih dari satu jenis kata.

---
---

## Roadmap Aplikasi

📅 Berikut adalah daftar tahapan pembuatan aplikasi dari hari ke hari untuk versi 4.0.

<br>

> ### ✍️ Hari-hari Sebelumnya (yang tidak terdokumentasi)
1. Design tampilan baru aplikasi
2. Mencari sumber-sumber kosakata.
3. Membuat database kosakata.
4. Membuat tampilan untuk mobile dan mobile web.
5. Membuat halaman home.
6. Membuat tampilan quiz.

<br>

> ### ✍️ Sabtu, December 31, 2022

1. Fungsi untuk mendapatkan kata-kata kuis. Fungsi ini juga dipanggil saat dropdown button (pada pengaturan kuis) berubah : [QuizConroller()]().
2. Fungsi untuk memeriksa hasil jawaban.
3. Fungsi untuk replace dan delete menggunakan regex untuk menghilangkan kata-kata yang tidak perlu.
4. Fungsi untuk memainkan sound effect pada penilaian.
5. Animasi pada tampilan quiz page : [QuizPage()](lib\Quiz\quiz_page.dart)

❗**ERROR**
- Pengguna mendapatkan hasil salah, walaupun menjawab dengan jawaban yang benar. ❓***Penyebab*** pengguna menjawab dengan jawaban yang berada pada list index bukan pertama. 💯***Solusi*** belum ada (Dec 31, 22) Setiap value string pada list di trim dan di hapus double space (Jan 1, 23).

✅**TODO**
- [x] Selesaikan error. 🆙
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [x] Buat fitur sembunyikan kata. 🆙
- [ ] Buat perpusatakaan buku serta penjelasannya. 🆙
- [ ] Buat fitur cari di perpustakaan. 🆙
- [ ] Buat fitur ganti tema.
- [ ] Buat fitur tentang aplikasi

<br>

> ### ✍️ Minggu, Januari 1, 2023

1. Menyelesaikan error fungsi memeriksa jawaban.
2. Buat fitur sembunyikan kata.
3. Membuat fitur bantuan di kuis

❗**ERROR**
- Tampilan kepotong pada bagian quiz. ❓***Penyebab*** belum tahu (Jan 1, 23) Widget padding yang wrap listview (Jan 2, 23). 💯***Solusi*** Belum ada (Jan 1, 23). Memindahkan padding langsung ke dalam widget listviewnya (Jan 2, 23).

✅**TODO**
- [x] Fix error. 🆙
- [x] Check jika ada "-" di dalam kata dan jawaban cara menjawabnya gimana.
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [ ] Buat perpusatakaan buku serta penjelasannya.
- [x] Buat fitur cari di perpustakaan. 🆙
- [ ] Buat fitur ganti tema.
- [ ] Buat fitur tentang aplikasi

<br>

> ### ✍️ Senin, Januari 2, 2023

- Memperbaiki error tampilan layar sebelah kanan tepotong.
- Mempermudah menjawab kata yang ada "-".
- Membuat tampilan untuk dictionary.
- Membuat daftar kata untuk bagian dictionary.
- Membuat fungsi dictionary.

❗**ERROR**
- Fungsi pencarian di bagian dictionary lama atau lag atau freeze. ❓***Penyebab*** Bagian romaji yang mengharuskan untuk mengubah kana ke romaji (Jan 2, 23). 💯***Solusi*** Belum ada (Jan 2, 23) Pakai search di sql nya (Jan 3, 22).

✅**TODO**
- [x] Perbaiki error. 🆙
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [x] Buat perpusatakaan serta penjelasannya. 🆙
- [ ] Buat fitur ganti tema.
- [ ] Buat fitur tentang aplikasi

<br>

> ### ✍️ Selasa, Januari 3, 2023

- Membuat kolom romaji di database.
- Memperbaiki fitur pencaharian dalam kamus.
- Memperbaiki tampilan layout kamus.
- Membuat halaman penjelasan untuk setiap kata di kamus.

❗**ERROR**
- Fungsi pencarian di bagian dictionary lama atau lag atau freeze. ❓***Penyebab*** Fungsi yang dipanggil berulang (Jan 3, 23). 💯***Solusi*** Belum ada (Jan 3, 23). Gunakan debouncer pada fungsi pencarian dalam kamus (Jan 4, 23)

✅**TODO**
- [ ] Fix error 🆙
- [x] Ketika user salah menjawab tunjukan selama durasi koreksi kata yang benarnya 🆙
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [ ] Buat fitur ganti tema.
- [ ] Buat fitur tentang aplikasi.

<br>

> ### ✍️ Rabu, Januari 4, 2023

- Memperbaiki error.
- Menambah tampilan teks koreksi dengan emoji.
- Membuat beberapa menu pada halaman menu.
- Membuat funsgi ubah tema

❗**ERROR / FIX / PENGEMBANGAN**
- Menjawab kata dengan tipe jawaban romaji saat ada "-" jadi susah. ❓***Penyebab*** Tanda "-" (Jan 4, 23). 💯***Solusi*** Hapus "-" (Jan 4, 23).
- Saat tipe kata kana, kata tidak bisa di query atau tidak ada katanya. ❓***Penyebab*** Penggunaan level yang ada pada query. (Jan 4, 23). 💯***Solusi*** Hilangkan query dengan level saat tipe kata adalah kana. (Jan 4, 23) Nambahkan character unik di huruf kana nya sebagai tanda (Jan 5, 23).

✅**TODO**
- [ ] Fix error 🆙
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [x] Buat fitur ganti tema.
- [ ] Buat fitur tentang aplikasi.
- [ ] Buat iklan.
- [ ] Buat tampilan untuk versi desktop 🆙
- [ ] Buat tema untuk tema gelap. 🆙
- [ ] Rapikan tampilan halaman menu.

<br>

> ### ✍️ Kamis, Januari 5, 2023

- Membuat fungsi ubah tema dan menyimpannya
- Memperbaiki error.
- Membuat beberapa fungsi menu.
- Menambah fungsi untuk sembunyikan ejaan, saat kata yang menjadi soal adalah kana maka akan otomatis ejaan disembunyikan.
- Membuat tema gelap.
- Memperindah beberapa tampilan warna.
- Memperbaiki error sebelumnya, dimana saat kata yang dipilih adalah kana.
- Menambahkan kata hiragana dan katakana.
- Membernarkan error pada huruf kana di halaman kamus penjelasan.
- Menambahkan tampilan pada kata quiz level dan tipe kata

❗**ERROR / FIX / PENGEMBANGAN**
- Tipe kata di halaman penajalasan kamus tidak muncul untuk huruf kana. ❓***Penyebab*** tidak ada huruf yang match saat di query (Jan 5, 23). 💯***Solusi*** Menambahkan karakter uniknya kana "//" (Jan 5, 23).

✅**TODO**
- [x] Fix error 🆙
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [x] Buat fitur tentang aplikasi.
- [ ] Buat iklan.
- [ ] Buat tampilan untuk versi desktop 🆙
- [x] Buat tema untuk tema gelap. 🆙
- [ ] Rapikan tampilan halaman menu.

<br>

> ### ✍️ Jumat, Januari 6, 2023

- Memperbaiki error pada halaman kamus penjelasan saat tidak dapat menemukan data yang sesuai dengan kata. 

❗**ERROR / FIX / PENGEMBANGAN**

✅**TODO**
- [x] Fix error 🆙
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [ ] Buat iklan.
- [ ] Buat tampilan untuk versi desktop 🆙
- [x] Buat tema untuk tema gelap. 🆙
- [ ] Rapikan tampilan halaman menu.

<br>

> ### ✍️ Sabtu, Januari 7, 2023

- Membuat banner iklan

❗**ERROR / FIX / PENGEMBANGAN**
- Saat searching kosakata dan keyboardnya ditutup malah mengarah ke loading. ❓***Penyebab*** Keyboard yang ditutup saat seaching (Jan 7, 23). 💯***Solusi*** belum tau (Jan 7, 23).

✅**TODO**
- [ ] Fix Error
- [ ] Animasi kata-kata kuis setiap kali kuis berganti.
- [x] Buat iklan.
- [ ] Buat tampilan untuk versi desktop 🆙
- [ ] Rapikan tampilan halaman menu.

<br>

> ### ✍️ Minggu, Januari 8, 2023

❗**ERROR / FIX / PENGEMBANGAN**

✅**TODO**
- [x] Fix Error
- [x] Animasi kata-kata kuis setiap kali kuis berganti. ❌ (Tidak jadi)
- [ ] Buat tampilan untuk versi desktop 🆙
- [x] Rapikan tampilan halaman menu.

<br>

> ### ✍️ Senin, Januari 9, 2023

- Membuat tamplan untuk destop.
- Test demo.
- Release untuk android, windows, dan web.

❗**ERROR / FIX / PENGEMBANGAN**
- Saat jenis kata yang dipilih kana dan levelnya lebih dari n5 blank. ❓***Penyebab*** return list nya == 0 (Jan 9, 23). 💯***Solusi*** belum tau (Jan 9, 23).

✅**TODO**
- [x] Buat tampilan untuk versi desktop 🆙

<br>


🦊 **hayashi19**