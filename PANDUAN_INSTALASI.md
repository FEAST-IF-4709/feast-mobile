# FEAST — Panduan Instalasi Lengkap

FEAST adalah platform manajemen restoran berbasis web dan mobile. Platform ini terdiri dari tiga bagian: backend Django, frontend React, dan aplikasi mobile Flutter. Panduan ini menjelaskan cara menginstall dan menjalankan ketiganya dari awal di komputer lokal.

---

## Daftar Isi

1. [Link Repository](#link-repository)
2. [Akun Demo](#akun-demo)
3. [Yang Perlu Diinstall Lebih Dulu](#yang-perlu-diinstall-lebih-dulu)
4. [Setup Backend Django](#setup-backend-django)
5. [Import Database](#import-database)
6. [Setup Frontend React](#setup-frontend-react)
7. [Setup Flutter Mobile](#setup-flutter-mobile)
8. [Setup Firebase (Push Notification)](#setup-firebase-push-notification)
9. [Cara Mencoba Fitur](#cara-mencoba-fitur)

---

## Link Repository

Berikut adalah link GitHub untuk masing-masing bagian:

**Backend:** https://github.com/FEAST-IF-4709/feast-backend

**Frontend:** https://github.com/FEAST-IF-4709/feast-frontend

**Mobile (Flutter):** https://github.com/FEAST-IF-4709/feast-mobile

---

## Akun Demo

Setelah semua berhasil dijalankan, gunakan akun berikut untuk mencoba aplikasi.

Untuk masuk ke dashboard web (login di halaman `/login`):

    Email    : owner@makjay.com
    Password : password123

Untuk masuk ke aplikasi Flutter:

    Nomor HP : 08123456789
    Password : password123

---

## Yang Perlu Diinstall Lebih Dulu

Sebelum memulai, pastikan semua software berikut sudah ada di komputer.

**Untuk backend:**

- Python versi 3.12 atau lebih baru. Cek dengan perintah `python3 --version`
- PostgreSQL versi 15. Cek dengan `psql --version`
- Redis versi 7. Cek dengan `redis-server --version`

**Untuk frontend:**

- Node.js versi 20.19.0 ke atas, atau versi 22 ke atas. Cek dengan `node --version`
- npm versi 10 ke atas sudah otomatis ikut saat install Node.js

**Untuk Flutter:**

- Flutter SDK versi 3.11 atau lebih baru. Cek dengan `flutter --version`
- Android Studio atau Xcode untuk menjalankan emulator
- Untuk Android: Android SDK dan satu emulator AVD sudah dibuat

Jika belum punya PostgreSQL dan Redis, cara paling mudah adalah menginstall Docker lalu menjalankan `docker compose up` di folder backend — keduanya sudah disiapkan otomatis.

---

## Setup Backend Django

### Langkah 1: Clone repository

```
git clone https://github.com/FEAST-IF-4709/feast-backend.git
cd feast-backend
```

### Langkah 2: Buat virtual environment dan install dependencies

```
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

Di Windows, perintah aktivasi virtualenv berbeda:

```
venv\Scripts\activate
```

### Langkah 3: Buat file konfigurasi

Salin file contoh konfigurasi:

```
cp .env.example .env
```

File `.env` yang baru dibuat sudah berisi nilai yang tepat untuk dijalankan secara lokal. Tidak perlu mengubah apapun kecuali jika password PostgreSQL kamu berbeda dari `postgres`.

Isi default dari `.env`:

```
SECRET_KEY=django-insecure-change-me-in-production
JWT_SIGNING_KEY=change-me-in-production-use-long-random-string
DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/feast_db
ALLOWED_HOSTS=localhost,127.0.0.1
CORS_ALLOWED_ORIGINS=http://localhost:5173
MIDTRANS_SERVER_KEY=
MIDTRANS_CLIENT_KEY=
MIDTRANS_IS_PRODUCTION=False
REDIS_URL=redis://127.0.0.1:6379/0
```

### Langkah 4: Buat database di PostgreSQL

Jalankan perintah berikut untuk membuat database bernama `feast_db`:

```
psql -U postgres -c "CREATE DATABASE feast_db;"
```

Jika password PostgreSQL kamu bukan `postgres`, sesuaikan bagian `DATABASE_URL` di file `.env`.

### Langkah 5: Jalankan migrasi

```
export DJANGO_SETTINGS_MODULE=core.settings.dev
python manage.py migrate
```

Di Windows, ganti perintah export dengan:

```
set DJANGO_SETTINGS_MODULE=core.settings.dev
```

### Langkah 6: Jalankan backend

Pastikan Redis sudah berjalan terlebih dahulu, kemudian jalankan server:

```
redis-server &
daphne -b 127.0.0.1 -p 8000 core.asgi:application
```

Backend berjalan di `http://localhost:8000`. Dokumentasi API tersedia di `http://localhost:8000/api/v1/docs/`.

Untuk mengecek apakah backend berjalan normal, buka `http://localhost:8000/api/v1/health/` — harus mengembalikan status `ok`.

### Cara Alternatif dengan Docker

Jika sudah menginstall Docker, tidak perlu install PostgreSQL dan Redis secara manual. Cukup jalankan satu perintah dari folder backend:

```
docker compose up --build
```

Docker akan otomatis membangun image, menjalankan PostgreSQL dan Redis, lalu menjalankan migrasi dan server backend sekaligus.

---

## Import Database

Ada dua cara untuk mengisi database: menggunakan file dump SQL yang sudah disiapkan (berisi data demo lengkap), atau menjalankan seed command dari Django.

### Cara 1: Import dari file SQL (direkomendasikan)

File dump database tersedia di dalam folder backend dengan nama `feast_db_export.sql`. File ini sudah berisi semua data demo termasuk akun-akun yang siap dipakai.

Jalankan perintah berikut untuk mengimport:

```
psql -U postgres -d feast_db -f feast_db_export.sql
```

Jika diminta password, masukkan password PostgreSQL kamu. Proses import mungkin memakan waktu beberapa menit tergantung ukuran data.

Setelah import selesai, jalankan migrasi untuk memastikan skema database sudah sinkron dengan versi kode terbaru:

```
python manage.py migrate
```

### Cara 2: Seed data dari awal

Jika ingin membuat data baru dari awal (bukan dari dump), jalankan dua perintah berikut setelah migrasi selesai:

```
python manage.py seed_permissions
python manage.py seed
```

Perintah pertama membuat 45 entri permission yang dibutuhkan sistem. Perintah kedua membuat brand, outlet, staff, produk, dan pelanggan contoh.

---

## Setup Frontend React

### Langkah 1: Clone repository

```
git clone https://github.com/FEAST-IF-4709/feast-frontend.git
cd feast-frontend
```

### Langkah 2: Install dependencies

```
npm install
```

Proses ini mengunduh semua library yang dibutuhkan ke folder `node_modules`. Butuh koneksi internet dan mungkin memakan waktu 1–2 menit.

### Langkah 3: Buat file konfigurasi

```
cp .env.example .env
```

Isi default sudah tepat untuk penggunaan lokal:

```
VITE_API_BASE_URL=http://localhost:8000/api/v1
VITE_WS_BASE_URL=ws://localhost:8000
VITE_MIDTRANS_CLIENT_KEY=
```

Tidak perlu mengubah apapun jika backend berjalan di port 8000. Jika nantinya menggunakan ngrok atau domain lain, ganti `localhost:8000` dengan URL yang sesuai.

### Langkah 4: Jalankan frontend

```
npm run dev
```

Frontend berjalan di `http://localhost:5173`. Buka alamat tersebut di browser.

Halaman login tersedia di `http://localhost:5173/login`. Tidak ada tombol login di halaman utama — akses langsung ke URL tersebut.

---

## Setup Flutter Mobile

### Langkah 1: Clone repository

```
git clone https://github.com/FEAST-IF-4709/feast-mobile.git
cd feast-mobile
```

### Langkah 2: Install dependencies Flutter

```
flutter pub get
```

### Langkah 3: Konfigurasi URL backend

Secara default, aplikasi Flutter akan mencoba terhubung ke `http://localhost:8000`. Ini berfungsi untuk web dan iOS Simulator. Untuk Android Emulator, alamat localhost harus diganti karena emulator Android punya jaringan tersendiri.

Saat menjalankan di Android Emulator, gunakan perintah berikut:

```
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

Untuk iOS Simulator atau Flutter Web, cukup jalankan biasa:

```
flutter run
```

Jika backend berjalan di komputer lain atau menggunakan ngrok, ganti URL-nya:

```
flutter run --dart-define=API_BASE_URL=https://abc123.ngrok-free.app
```

### Langkah 4: Jalankan di emulator atau perangkat fisik

Pastikan emulator sudah berjalan, lalu:

```
flutter run
```

Flutter akan otomatis mendeteksi perangkat yang tersedia. Jika ada lebih dari satu, sistem akan menanyakan mana yang ingin digunakan.

---

## Setup Firebase (Push Notification)

Firebase dipakai untuk mengirim notifikasi ke pelanggan saat status pesanan berubah — misalnya ketika dapur mulai memasak, atau saat makanan siap diambil. Fitur ini melibatkan dua sisi: backend yang mengirim notifikasi, dan Flutter yang menerimanya.

Tanpa Firebase, semua fitur lain tetap berjalan normal. Notifikasi push hanya tidak aktif.

### Gambaran Umum

Backend menggunakan Firebase Admin SDK untuk mengirim pesan ke perangkat pelanggan melalui FCM (Firebase Cloud Messaging). Flutter menggunakan library `firebase_messaging` untuk menerima pesan tersebut dan menampilkannya sebagai notifikasi di perangkat.

Project Firebase yang sudah terdaftar untuk FEAST bernama `feast-e5f5d`. File-file konfigurasi untuk project ini sudah tersedia di dalam repository.

---

### Bagian 1: Setup Firebase di Backend

Backend membutuhkan file Service Account JSON untuk bisa mengirim notifikasi atas nama project Firebase.

File tersebut sudah ada di dalam folder backend dengan nama `feast-e5f5d-firebase-adminsdk-fbsvc-ec8c43412f.json`. Kamu tidak perlu membuatnya dari awal.

Yang perlu dilakukan hanyalah memberitahu backend di mana letak file itu dengan menambahkan satu baris ke file `.env`:

```
FIREBASE_SERVICE_ACCOUNT_PATH=/path/lengkap/ke/feast-e5f5d-firebase-adminsdk-fbsvc-ec8c43412f.json
```

Ganti `/path/lengkap/ke/` dengan path absolut ke folder backend di komputermu. Contoh jika folder backend ada di `/home/user/feast-backend`:

```
FIREBASE_SERVICE_ACCOUNT_PATH=/home/user/feast-backend/feast-e5f5d-firebase-adminsdk-fbsvc-ec8c43412f.json
```

Di Windows, gunakan format path Windows:

```
FIREBASE_SERVICE_ACCOUNT_PATH=C:\Users\user\feast-backend\feast-e5f5d-firebase-adminsdk-fbsvc-ec8c43412f.json
```

Setelah menambahkan baris tersebut, restart backend. Jika path sudah benar, backend akan mengirim notifikasi FCM setiap kali status order berubah.

Jika variabel ini tidak diisi atau kosong, backend tetap berjalan normal — hanya notifikasi push yang tidak terkirim, dan sebuah pesan peringatan akan muncul di log.

---

### Bagian 2: Setup Firebase di Flutter (Android)

File konfigurasi untuk Android bernama `google-services.json` dan sudah ada di dalam repository di lokasi `android/app/google-services.json`. Tidak perlu mengunduh atau melakukan konfigurasi tambahan untuk Android.

Saat menjalankan `flutter pub get` dan `flutter run`, Flutter secara otomatis membaca file tersebut.

---

### Bagian 3: Setup Firebase di Flutter (iOS)

Untuk iOS, file konfigurasinya berbeda — bernama `GoogleService-Info.plist` dan perlu didownload secara manual dari Firebase Console karena file ini tidak disertakan di repository.

Langkah-langkahnya:

Pertama, buka Firebase Console di https://console.firebase.google.com dan masuk dengan akun Google yang punya akses ke project `feast-e5f5d`.

Kedua, pilih project `feast-e5f5d` dari daftar project.

Ketiga, klik ikon roda gigi di pojok kiri atas, lalu pilih `Project Settings`.

Keempat, scroll ke bawah ke bagian `Your apps`. Cari app dengan platform iOS, lalu klik `GoogleService-Info.plist` untuk mendownloadnya.

Kelima, taruh file yang sudah didownload ke dalam folder `ios/Runner/` di dalam project Flutter:

```
feast-mobile/
  ios/
    Runner/
      GoogleService-Info.plist   <-- taruh di sini
```

Keenam, buka project iOS di Xcode:

```
open ios/Runner.xcworkspace
```

Di Xcode, klik kanan pada folder `Runner` di panel kiri, pilih `Add Files to "Runner"`, lalu pilih file `GoogleService-Info.plist` yang baru ditambahkan. Pastikan centang `Copy items if needed` dan target `Runner` sudah dipilih, lalu klik `Add`.

Terakhir, jalankan ulang Flutter:

```
flutter run
```

---

### Bagian 4: Membuat Project Firebase Baru (jika diperlukan)

Jika kamu ingin membuat project Firebase sendiri dan tidak menggunakan project `feast-e5f5d` yang sudah ada, ikuti langkah berikut.

Buka https://console.firebase.google.com, klik `Add project`, beri nama project, lalu ikuti wizard pembuatan project.

Setelah project dibuat, aktifkan `Cloud Messaging`:

Masuk ke project, klik `Build` di sidebar kiri, lalu pilih `Cloud Messaging`. Aktifkan layanan ini.

Tambahkan aplikasi Android ke project:

Klik ikon `+` atau `Add app`, pilih platform Android. Isi package name dengan `com.example.feast` (atau sesuaikan dengan `applicationId` di `android/app/build.gradle`). Download `google-services.json` lalu taruh di `android/app/`.

Tambahkan aplikasi iOS ke project:

Klik `Add app` lagi, pilih platform iOS. Isi bundle ID sesuai yang ada di `ios/Runner.xcodeproj`. Download `GoogleService-Info.plist` lalu taruh di `ios/Runner/` dan tambahkan ke Xcode seperti langkah di atas.

Buat Service Account untuk backend:

Di `Project Settings`, klik tab `Service accounts`. Klik `Generate new private key`, lalu `Generate key`. File JSON akan terdownload otomatis. Taruh file ini di folder backend dan update path di `.env`:

```
FIREBASE_SERVICE_ACCOUNT_PATH=/path/ke/file-service-account-baru.json
```

---

## Cara Mencoba Fitur

### Urutan yang disarankan

Sebelum mencoba, pastikan urutan startup berikut sudah benar:

1. Redis berjalan
2. Backend berjalan di port 8000
3. Frontend berjalan di port 5173
4. Flutter berjalan di emulator atau perangkat

### Mencoba dashboard web

Buka `http://localhost:5173/login` dan masuk dengan:

    owner@makjay.com / password123

Setelah login, kamu akan diarahkan ke halaman dashboard. Di sini tersedia analitik penjualan, manajemen menu, manajemen meja, staf, dan fitur lainnya.

### Mencoba POS (Point of Sale)

Klik menu Order di sidebar. Dari sini kasir bisa memilih produk, memasukkannya ke keranjang, memilih metode pembayaran (tunai atau QRIS), lalu membuat order. Order yang dibuat akan langsung muncul di halaman Kitchen secara realtime.

Untuk demo tanpa koneksi Midtrans, pilih metode pembayaran Tunai saja. Order akan langsung selesai tanpa perlu scan QR.

### Mencoba Pembayaran QRIS dengan Simulator Midtrans

Jika ingin mencoba alur QRIS secara lengkap tanpa perangkat fisik, gunakan Midtrans Sandbox Simulator. Caranya memanfaatkan QR string yang tersimpan di database setelah order QRIS dibuat.

Pastikan terlebih dahulu bahwa Midtrans Sandbox Key sudah dikonfigurasi di file `.env` backend:

```
MIDTRANS_SERVER_KEY=SB-Mid-server-xxxxxxxxxxxxxx
MIDTRANS_CLIENT_KEY=SB-Mid-client-xxxxxxxxxxxxxx
MIDTRANS_IS_PRODUCTION=False
```

Key sandbox bisa didapat gratis dengan mendaftar di https://dashboard.sandbox.midtrans.com.

Setelah key sudah terpasang, ikuti langkah berikut:

**Langkah 1 — Buat order dengan metode QRIS**

Di halaman `/order`, pilih produk, lalu pilih metode pembayaran QRIS, kemudian klik Buat Order. Sistem akan membuat transaksi ke Midtrans Sandbox dan menyimpan data QR di database.

**Langkah 2 — Buka database dengan DBeaver**

Buka DBeaver dan sambungkan ke database PostgreSQL lokal dengan konfigurasi berikut:

    Host     : localhost
    Port     : 5432
    Database : feast_db
    Username : postgres
    Password : postgres

Setelah terhubung, buka tabel `payment_paymenttransaction`. Tabel ini menyimpan semua data transaksi pembayaran.

**Langkah 3 — Cari transaksi QRIS yang baru dibuat**

Di dalam tabel `payment_paymenttransaction`, cari baris dengan kolom `payment_method` bernilai `QRIS_MIDTRANS` dan `status` bernilai `PENDING`. Baris paling atas biasanya adalah transaksi yang paling baru.

Salin isi kolom `qr_image_url` dari baris tersebut. Nilainya berupa string panjang yang dimulai dengan `00020101...` — ini adalah data QRIS mentah (bukan URL gambar).

**Langkah 4 — Simulasikan pembayaran**

Buka browser dan pergi ke https://simulator.sandbox.midtrans.com/v2/qris/index.

Tempel string QRIS yang tadi disalin ke dalam kolom input yang tersedia, lalu klik tombol Pay atau Bayar.

**Langkah 5 — Cek hasilnya**

Midtrans Sandbox akan mengirim notifikasi ke backend bahwa pembayaran berhasil. Status order akan berubah otomatis dari `PENDING` menjadi `SETTLED`, dan order akan masuk ke Kitchen Display System secara realtime.

Kamu bisa memverifikasi perubahan status ini di halaman `/orders` pada frontend, atau langsung di tabel `payment_paymenttransaction` di DBeaver — kolom `status` akan berubah menjadi `SETTLED`.

### Mencoba Kitchen Display System

Buka dua tab browser. Tab pertama buka `/order` untuk membuat pesanan, tab kedua buka `/kitchen` untuk melihat pesanan masuk secara realtime. Setiap order baru yang dibuat di tab pertama akan langsung muncul di tab kedua tanpa perlu refresh.

### Mencoba aplikasi Flutter

Buka aplikasi Flutter di emulator. Masuk dengan:

    Nomor HP : 08123456789
    Password : password123

Dari aplikasi, pelanggan bisa melihat menu, melakukan self-order, memantau status pesanan, dan menerima notifikasi saat pesanan selesai diproses dapur.

---

## Catatan Penting

Jika mengubah URL backend (misalnya dari localhost ke ngrok), pastikan mengubah tiga tempat sekaligus:

Pertama, di file `.env` backend, ubah nilai `CORS_ALLOWED_ORIGINS` untuk mengizinkan domain frontend yang baru.

Kedua, di file `.env` frontend, ubah `VITE_API_BASE_URL` dan `VITE_WS_BASE_URL`.

Ketiga, untuk Flutter, jalankan ulang dengan flag `--dart-define=API_BASE_URL=` yang baru.

Setelah mengubah file `.env`, frontend harus direstart agar perubahan berlaku. Backend bisa langsung direstart tanpa perlu build ulang.
