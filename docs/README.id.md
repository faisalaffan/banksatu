<p align="center">
  <a href="README.md">🇬🇧 English</a>
</p>

# BankSatu
> *One banking platform. Built for everyone.*

---

## Filosofi

### Mengapa BankSatu?

Bank di Indonesia sudah banyak. Tapi platform yang benar-benar menyatukan pengalaman nasabah dari awal hingga akhir — dari onboarding, transaksi, hingga layanan — masih terasa terfragmentasi.

BankSatu lahir dari satu pertanyaan sederhana:

> *"Kenapa urusan bank harus serumit itu?"*

**Satu** bukan sekadar angka. Ini adalah janji:
- Satu platform untuk semua kebutuhan perbankan
- Satu pengalaman yang konsisten dari mobile hingga web
- Satu titik kepercayaan antara bank dan nasabah

### Nilai Inti

| Nilai | Makna |
|---|---|
| **Kesederhanaan** | Fitur kompleks, tampilan sederhana |
| **Kepercayaan** | Data aman, transaksi transparan |
| **Inklusivitas** | Dirancang untuk semua segmen nasabah |
| **Kecepatan** | Tidak ada nasabah yang suka menunggu |

### Posisi Produk

BankSatu bukan pengganti core banking. BankSatu adalah **lapisan pengalaman** di atas infrastruktur perbankan yang sudah ada — membuat layanan bank terasa modern, cepat, dan manusiawi.

---

## Product Requirements Document (PRD)

| | |
|---|---|
| **Version** | v1.0 — Initial Release |
| **Status** | Draft |
| **Tanggal** | Mei 2026 |
| **Platform** | Mobile (iOS + Android) + Web |
| **Model** | White-label per institusi bank |
| **Target** | Nasabah bank Indonesia — semua segmen |

---

## 1. Executive Summary

BankSatu adalah customer-facing banking platform yang dirancang untuk memberikan pengalaman perbankan modern kepada nasabah — dari onboarding digital, transaksi harian, hingga layanan produk keuangan.

Platform ini hadir sebagai white-label solution yang bisa dikustomisasi per institusi bank, dengan tetap mempertahankan standar UX dan keamanan yang tinggi.

---

## 2. Problem Statement

### 2.1 Kondisi Saat Ini

- Aplikasi mobile banking mayoritas bank Indonesia terasa berat, lambat, dan tidak intuitif
- Onboarding nasabah baru masih membutuhkan kunjungan fisik ke kantor cabang
- Notifikasi transaksi tidak real-time atau tidak informatif
- Nasabah tidak punya visibilitas penuh terhadap produk keuangan mereka

### 2.2 Pain Points Utama

| Pain Point | Dampak | Frekuensi |
|---|---|---|
| Onboarding butuh datang ke cabang | Barrier tinggi untuk nasabah baru | Per akuisisi |
| Aplikasi lambat dan sering error | Kepercayaan turun, churn tinggi | Harian |
| Tidak ada notifikasi real-time | Nasabah tidak aware transaksi | Harian |
| Informasi produk tidak jelas | Cross-sell rendah | Bulanan |
| Reset PIN/password rumit | Frustrasi, call center overload | Mingguan |

---

## 3. Target User & Persona

| Persona | Karakteristik | Kebutuhan Utama |
|---|---|---|
| Nasabah muda (18–30) | Digital native, mobile-first | Onboarding cepat, UX modern |
| Nasabah produktif (31–50) | Butuh efisiensi, bisnis & pribadi | Transfer cepat, laporan keuangan |
| Nasabah senior (50+) | Kurang melek digital | UI sederhana, font besar, aksesibel |
| Nasabah UMKM | Campur rekening pribadi & bisnis | Kategorisasi transaksi, invoice |

---

## 4. Core Module

### 4.1 Onboarding & KYC Digital
- Registrasi akun tanpa harus ke cabang
- Foto KTP + selfie dengan liveness detection
- Verifikasi data otomatis via Dukcapil API
- e-Sign untuk pembukaan rekening

### 4.2 Dashboard & Transaksi
- Saldo real-time semua rekening
- Riwayat transaksi dengan filter & search
- Notifikasi push real-time setiap transaksi
- Kategorisasi pengeluaran otomatis

### 4.3 Transfer & Pembayaran
- Transfer antar bank via BI-FAST
- Pembayaran tagihan (PLN, PDAM, internet, BPJS)
- QRIS scan & pay
- Jadwalkan transfer berulang

### 4.4 Produk Keuangan
- Informasi tabungan, deposito, kredit
- Simulasi produk (KPR, KTA, deposito)
- Apply produk baru langsung dari app
- Status pengajuan real-time

### 4.5 Layanan & Self-Service
- Ganti PIN tanpa ke cabang
- Blokir/unblokir kartu
- Cetak rekening koran digital
- Chat dengan CS via in-app

---

## 5. Non-Functional Requirements

| Kategori | Target |
|---|---|
| Performance | App load < 2 detik |
| Availability | Uptime 99.9% |
| Security | OJK-compliant, enkripsi AES-256 |
| Compliance | PBI No. 23/6/PBI/2021, POJK 38 |
| Accessibility | WCAG 2.1 AA |

---

## 6. Tech Stack Recommendation

| Layer | Teknologi |
|---|---|
| Mobile | Flutter (iOS + Android) |
| Web | Next.js + PWA |
| Backend | Go (Golang) |
| Database | MySQL + Redis |
| Auth | JWT + OTP + Biometric |
| KYC | Dukcapil API + Liveness SDK |
| Payment | BI-FAST, QRIS (GPN) |

---

## 7. Roadmap

### Phase 1 — MVP (Bulan 1–3)
- Onboarding & KYC digital
- Dashboard saldo & transaksi
- Transfer antar bank
- Notifikasi real-time

### Phase 2 — Core Expansion (Bulan 4–6)
- Pembayaran tagihan & QRIS
- Produk keuangan & simulasi
- Self-service (PIN, blokir kartu)
- CS chat in-app

### Phase 3 — Growth (Bulan 7–12)
- Kategorisasi transaksi AI
- Apply produk keuangan digital
- Loyalty & reward program
- Open banking API

---

## 8. Success Metrics

| Metrik | Target |
|---|---|
| Onboarding completion rate | > 70% |
| DAU / MAU ratio | > 40% |
| Transaksi per user per bulan | > 8x |
| App store rating | > 4.5 |
| CS ticket via app | > 60% dari total |

---

## 9. Open Questions

1. Core banking system mana yang akan diintegrasikan? (Temenos, Silverlake, in-house)
2. Apakah KYC perlu face liveness atau cukup foto statis?
3. Apakah white-label mencakup custom domain dan app store listing terpisah?
4. Regulasi OJK mana yang paling kritikal untuk fase MVP?

---

*BankSatu — One banking platform. Built for everyone.*
*PRD v1.0 — Confidential*
