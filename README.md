# FEAST — Food Ecosystem Alliance & Smart Technology

FEAST adalah platform SaaS manajemen restoran multi-tenant yang mencakup sistem kasir (POS), kitchen display, analitik penjualan, manajemen menu dan staf, hingga self-order oleh pelanggan melalui aplikasi mobile. Platform ini dibangun untuk skala bisnis F&B dari satu outlet hingga jaringan multi-brand.

---

## Repositori

| Komponen | Repository | Teknologi |
|---|---|---|
| Backend API | [feast-backend](https://github.com/FEAST-IF-4709/feast-backend) | Django 6, PostgreSQL, Redis, WebSocket |
| Dashboard Web | [feast-frontend](https://github.com/FEAST-IF-4709/feast-frontend) | React 19, Vite, Tailwind CSS |
| Aplikasi Mobile | [feast-mobile](https://github.com/FEAST-IF-4709/feast-mobile) | Flutter, Firebase FCM |

---

## Arsitektur Sistem

```
┌─────────────────────┐     ┌─────────────────────┐
│   Dashboard Web     │     │   Aplikasi Flutter  │
│   React 19 + Vite   │     │   (Customer Mobile) │
└────────┬────────────┘     └──────────┬──────────┘
         │  REST API + WebSocket       │  REST API + WebSocket
         ▼                             ▼
┌──────────────────────────────────────────────────┐
│              Backend Django 6 (ASGI)             │
│   DRF · JWT · django-channels · drf-spectacular  │
└──────────┬──────────────────┬────────────────────┘
           │                  │
    ┌──────▼──────┐    ┌──────▼──────┐
    │  PostgreSQL │    │    Redis    │
    │  (data)     │    │  (realtime/ │
    └─────────────┘    │   cache)    │
                       └─────────────┘
```

---

## Fitur Utama

### Dashboard Web (untuk pemilik dan staf restoran)

- **Dashboard Analytics** — total revenue, jumlah order, dan tren penjualan harian secara realtime
- **POS Kasir** — buat order, pilih produk dari katalog, proses pembayaran tunai atau QRIS
- **Kitchen Display System** — tampilan dapur realtime; staf update status masakan tanpa refresh
- **Manajemen Menu** — kelola produk, kategori, harga, dan ketersediaan
- **Manajemen Meja & QR** — buat meja, generate QR code unik per meja, rotate token QR
- **Manajemen Staf** — tambah/edit karyawan, set role dan outlet
- **RBAC (Role & Permission)** — buat role custom dari 45 permission yang tersedia
- **Manajemen Outlet** — kelola cabang, alamat, dan koordinat geolokasi
- **Marketing & Promosi** — buat promosi diskon persentase atau nominal
- **Riwayat Order** — lihat semua transaksi dengan filter status dan timeline fulfillment

### Aplikasi Mobile Flutter (untuk pelanggan)

- **Self-order via QR** — scan QR meja, lihat menu, tambah ke keranjang, checkout mandiri
- **QRIS Payment** — bayar dengan QRIS yang di-generate dari Midtrans Sandbox
- **Order Tracking** — pantau status pesanan secara realtime lewat WebSocket
- **Riwayat Pesanan** — lihat semua pesanan sebelumnya beserta detailnya
- **Profil Pelanggan** — edit nama, foto, dan informasi akun
- **Loyalty & Voucher** — lihat poin loyalitas dan katalog voucher per brand
- **Receipt PDF** — generate dan simpan struk pembayaran dalam format PDF
- **Push Notification** — terima notifikasi saat status pesanan berubah (via Firebase FCM)
- **Rekomendasi Produk** — produk populer dari brand yang pernah dikunjungi

---

## Cara Cepat Memulai

Clone masing-masing repositori secara terpisah sesuai kebutuhan. Panduan instalasi lengkap tersedia di [docs/PANDUAN_INSTALASI.md](docs/PANDUAN_INSTALASI.md).

### Backend

```bash
git clone https://github.com/FEAST-IF-4709/feast-backend.git
cd feast-backend
python3 -m venv venv && source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
psql -U postgres -c "CREATE DATABASE feast_db;"
export DJANGO_SETTINGS_MODULE=core.settings.dev
python manage.py migrate
python manage.py seed_permissions && python manage.py seed
daphne -b 127.0.0.1 -p 8000 core.asgi:application
```

### Frontend

```bash
git clone https://github.com/FEAST-IF-4709/feast-frontend.git
cd feast-frontend
npm install
cp .env.example .env
npm run dev
```

### Flutter

```bash
git clone https://github.com/FEAST-IF-4709/feast-mobile.git
cd feast-mobile
flutter pub get

# Android Emulator
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000

# iOS Simulator / Web
flutter run
```

---

## Akun Demo

Setelah menjalankan seed atau mengimport database, gunakan akun berikut.

**Dashboard Web** — buka `http://localhost:5173/login`

```
Email    : owner@makjay.com
Password : password123
```

**Aplikasi Flutter** — login di halaman awal aplikasi

```
Nomor HP : 08123456789
Password : password123
```

---

## API Documentation

Backend menyediakan dokumentasi API interaktif yang bisa langsung dicoba:

| URL | Keterangan |
|---|---|
| `http://localhost:8000/api/v1/docs/` | Swagger UI |
| `http://localhost:8000/api/v1/redoc/` | ReDoc |
| `http://localhost:8000/api/v1/health/` | Health check (DB + Redis) |

---

## Tech Stack

**Backend**

| Teknologi | Versi | Fungsi |
|---|---|---|
| Python | 3.12 | Runtime |
| Django | 6.0 | Web framework |
| Django REST Framework | 3.17 | REST API |
| Django Channels | 4.2 | WebSocket / ASGI |
| PostgreSQL | 15 | Database utama |
| Redis | 7 | Pub/sub & caching |
| Daphne | 4.1 | ASGI server |
| SimpleJWT | 5.5 | Autentikasi JWT |
| drf-spectacular | 0.29 | OpenAPI schema |
| firebase-admin | 6.8 | Kirim push notification |

**Frontend**

| Teknologi | Versi | Fungsi |
|---|---|---|
| React | 19 | UI Library |
| Vite | 8 | Build tool & dev server |
| Tailwind CSS | 3 | Styling |
| Axios | 1.16 | HTTP client |
| React Router | 7 | Routing |
| Framer Motion | 12 | Animasi |

**Mobile**

| Teknologi | Versi | Fungsi |
|---|---|---|
| Flutter | 3.11+ | Framework mobile |
| Riverpod | 2.6 | State management |
| Dio | 5.7 | HTTP client |
| go_router | 14 | Routing |
| firebase_messaging | 15 | Push notification |
| flutter_secure_storage | 9.2 | Penyimpanan token |
| Freezed | 2.5 | Immutable model |

---

## Prasyarat

| Software | Versi Minimum | Cek |
|---|---|---|
| Python | 3.12 | `python3 --version` |
| Node.js | 20.19.0 atau 22+ | `node --version` |
| PostgreSQL | 15 | `psql --version` |
| Redis | 7 | `redis-server --version` |
| Flutter SDK | 3.11 | `flutter --version` |

Jika tidak ingin menginstall PostgreSQL dan Redis secara manual, backend bisa dijalankan dengan Docker:

```bash
docker compose up --build
```

---

## Dokumentasi Lengkap

- [Panduan Instalasi Lengkap](docs/PANDUAN_INSTALASI.md) — setup backend, frontend, Flutter, Firebase, dan import database
- [Panduan Demo](DOKUMENTASI_DEMO.md) — tur fitur, alur POS, Kitchen Display, dan cara bypass pembayaran

---

*FEAST — Tugas Akhir IF-4709*
