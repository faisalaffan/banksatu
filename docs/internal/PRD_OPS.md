# Product Requirements Document — BankSatu OPS

**Version:** 0.5.1-draft
**Author:** Muhammad Faisal Affan
**Status:** Draft
**Last Updated:** 2026-06-14

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Problem Statement](#2-problem-statement)
3. [Goals & Non-Goals](#3-goals--non-goals)
4. [Target Users](#4-target-users)
5. [Product Overview](#5-product-overview)
6. [Architecture Overview](#6-architecture-overview)
7. [Feature Modules](#7-feature-modules)
   - 7.1 Dashboard & Overview
   - 7.2 Nasabah Search & Profile
   - 7.3 Wawancara & Credit Assessment
   - 7.4 Approval Workflow
   - 7.5 KYC Review & Verifikasi
   - 7.6 Sengketa & Dispute Resolution
   - 7.7 Transaction Monitoring
   - 7.8 Reporting & Audit Trail
   - 7.9 Customer Service Tools
   - 7.10 Role-Based Access Control
   - 7.11 SLIK / BI Checking Integration
   - 7.12 APU-PPT & Sanctions Screening
   - 7.13 CDD/EDD Tiering & Risk Rating
   - 7.14 Restrukturisasi & Kolektibilitas (NPL)
   - 7.15 LTKM/LTKT Reporting (PPATK)
   - 7.16 Beneficial Ownership (BO)
   - 7.17 Data Master & Reference Tables
   - 7.18 Card Servicing Operations
   - 7.19 Loan Disbursement & Drawdown
   - 7.20 Payment Exception Handling
   - 7.21 Internal Fraud Detection (Employee)
   - 7.22 Dual Authorization — Customer Transactions
8. [API Surface](#8-api-surface)
9. [Mobile App & Web Dashboard](#9-mobile-app--web-dashboard)
10. [Security & Compliance](#10-security--compliance)
11. [Tech Stack](#11-tech-stack)
12. [Build Phases & Milestones](#12-build-phases--milestones)
13. [Success Metrics](#13-success-metrics)
14. [Open Questions](#14-open-questions)

---

## 1. Executive Summary

**BankSatu OPS** adalah aplikasi internal untuk petugas dan operational staff BankSatu — tersedia sebagai **mobile app (Flutter)** dan **web dashboard (React/Next.js)**. Mobile app digunakan untuk workflow sehari-hari di lapangan (wawancara nasabah, approval on-the-go, KYC review). Web dashboard digunakan untuk analisis mendalam dan reporting di kantor.

BankSatu OPS adalah **companion app** untuk BankSatu Mobile (nasabah-facing). Jika BankSatu Mobile adalah tempat nasabah melakukan transaksi, BankSatu OPS adalah tempat petugas memastikan semua berjalan aman, compliant, dan efisien.

**Scope fokus:** Credit/lending operations + compliance regulatory + card servicing + payment exception handling. Ini **bukan** full branch operations app — tidak mencakup teller/cash management, cek fisik, atau bank guarantee.

---

## 2. Problem Statement

### Saat ini

Operational staff bank menghadapi friksi signifikan:

- **Wawancara tidak terstruktur:** credit assessment untuk pengajuan limit masih pakai kertas atau spreadsheet, tidak ada workflow terintegrasi
- **Data terfragmentasi:** petugas harus buka 3-4 sistem untuk lihat profil nasabah, transaksi, dan dokumen KYC
- **Approval lambat:** workflow approval linear via email/WA, tidak ada paralel review atau escalation otomatis
- **Audit trail tidak lengkap:** siapa approve apa dan kapan sering tidak tercatat dengan baik
- **Dispute resolution manual:** sengketa transaksi diselesaikan via telepon dan email, tidak ada case management

### Akar Masalah

1. **Tooling operational underinvested** — bank fokus ke apps nasabah, tool internal diabaikan
2. **No single source of truth** — data nasabah tersebar di CRM, core banking, dokumen fisik
3. **Compliance friction** — petugas spend 40% waktu untuk paperwork, bukan analisis

### Hipotesis

Jika BankSatu OPS menyediakan platform operational terintegrasi dengan wawancara terstruktur, workflow approval, dan audit trail otomatis, maka:

- Waktu proses pengajuan limit turun dari mingguan ke harian
- Kualitas credit assessment meningkat karena data terpusat
- Compliance readiness meningkat karena semua tindakan tercatat

---

## 3. Goals & Non-Goals

### Goals

| #   | Goal                                                              | Priority |
| --- | ----------------------------------------------------------------- | -------- |
| G1  | Nasabah search & 360° profile view                                | P0       |
| G2  | Wawancara credit assessment terstruktur (IIR, pendapatan, dll)    | P0       |
| G3  | Approval workflow multi-level dengan paralel review               | P0       |
| G4  | SLIK OJK integration — BI Checking untuk semua pengajuan kredit   | P0       |
| G5  | APU-PPT screening: DTTOT, sanctions list, adverse media check     | P0       |
| G6  | CDD/EDD tiering dengan risk-rating nasabah                        | P1       |
| G7  | KYC review dashboard & verifikasi dokumen (termasuk e-KYC)        | P1       |
| G8  | Dispute case management dengan SLA escalation severity-based      | P1       |
| G9  | Real-time transaction monitoring & flagging + LTKM/LTKT workflow  | P1       |
| G10 | Restrukturisasi kredit & monitoring kolektibilitas NPL            | P1       |
| G11 | Audit trail lengkap dengan maker-checker visual                   | P1       |
| G12 | Document expiry tracking & re-KYC reminder otomatis               | P2       |
| G13 | Role-based access control granular (maker-checker separation)     | P2       |
| G14 | Customer service tools (live chat, call log)                      | P2       |
| G15 | Reporting & analytics operational + pelaporan regulator           | P2       |
| G16 | Card servicing: blokir, reissue, PIN reset, card dispute          | P1       |
| G17 | Loan disbursement & drawdown tracking                             | P1       |
| G18 | Payment exception handling: SKNBI/RTGS/BI-FAST retur              | P2       |
| G19 | Internal fraud detection: employee behavioral monitoring          | P2       |
| G20 | Dual authorization: customer multi-signatory + system config      | P2       |

### Non-Goals (v1)

- AI/ML credit scoring otomatis — assessment tetap oleh petugas, AI sebagai rekomendasi saja
- Integrasi core banking system real — gunakan mock
- Multi-cabang/multi-branch operational — single branch dulu
- Integrasi Dukcapil real-time — desain API contract + field di database untuk integrasi di v2
- Integrasi SLIK/BI Checking real-time — desain API contract + field di database, mock data di v1, integrasi real wajib di Phase 2b
- Integrasi PPATK API real-time — desain field + workflow pelaporan, mock submission di v1

### Explicitly Out of Scope (Semua Versi)

Fitur yang secara sadar **tidak** masuk scope BankSatu OPS karena tidak relevan dengan fokus lending + compliance:

- **Cek/Bilyet Giro fisik** — BankSatu adalah digital-first bank, tidak memproses cek fisik atau BG. Kalau ada di masa depan, akan jadi modul terpisah.
- **Garansi Bank (Bank Guarantee)** — penerbitan dan monitoring garansi bank untuk korporat. Out of scope karena target utama consumer/SME lending.
- **Teller & cash/vault management** — manajemen kas harian cabang, setoran/tarik tunai fisik. Out of scope karena single branch + digital-first.
- **Cross-selling / product recommendation** — rekomendasi produk otomatis ke petugas. Future enhancement, bukan v1.
- **Cross-border trade finance** — L/C, SKBDN, wesel ekspor. Out of scope.

### ⚠️ Compliance Notice

PRD ini dirancang dengan **compliance-ready architecture**. Fitur regulasi (SLIK, APU-PPT, LTKM/LTKT, Dukcapil) disiapkan skema database dan UI-nya di v1, dengan integrasi institusional (OJK, PPATK, Dukcapil) dijadwalkan di v2 setelah kerja sama API tersedia. **Tanpa integrasi ini, aplikasi TIDAK dapat digunakan untuk operasional bank berlisensi.** Risiko utama: audit OJK akan menemukan temuan jika SLIK check, APU-PPT screening, dan pelaporan LTKM tidak aktif.

### MVP Scope Definition (v1 — Demo/Pitch)

**Target v1:** Aplikasi operasional yang bisa di-demokan ke stakeholder dengan data mock. BUKAN produksi.

**Wajib ada (P0 — tanpa ini demo tidak jalan):**

| Modul | Scope v1 |
|-------|----------|
| 7.1 Dashboard | Task queue personal, SLA timer, quick stats dengan mock data |
| 7.2 Nasabah Search | Search + profil 360° dengan mock data nasabah |
| 7.3 Wawancara | Form multi-section + auto-calculation + simulasi bunga (mock data) |
| 7.4 Approval | Workflow 2-level (Supervisor → Manager) dengan mock |
| 7.5 KYC | Review queue + side-by-side view + document expiry tracking |
| 7.10 RBAC | Role-based access + maker-checker separation |

**Nice-to-have (P1 — bikin demo lebih convincing):**

| Modul | Scope v1 |
|-------|----------|
| 7.6 Sengketa | Case management + severity SLA |
| 7.7 Monitoring | Live feed + flag rules dasar (threshold, cross-city, midnight) |
| 7.8 Audit | Audit trail viewer + maker-checker visual |

**Compliance UI/DB ready (P2 — skema siap, mock data, integrasi real di v2):**

| Modul | Scope v1 |
|-------|----------|
| 7.11 SLIK | Database schema + UI + mock data |
| 7.12 APU-PPT | Database schema + UI screening + mock engine |
| 7.13 CDD/EDD | Risk-rating engine + periodic review scheduler |
| 7.14 NPL | Kolektibilitas dashboard + restrukturisasi workflow |
| 7.15 LTKM/LTKT | Form pelaporan + workflow submit (mock) |
| 7.16 BO | Form struktur kepemilikan + ownership graph |
| 7.17 Data Master | Reference tables + import workflow |

**Out of scope v1 (v2+):**
- Integrasi API SLIK OJK real-time
- Integrasi API Dukcapil real-time
- Integrasi API goAML PPATK
- Real-time sanctions list sync
- AI/ML credit scoring otomatis
- Multi-cabang/multi-branch

---

## 4. Target Users

### Primary: Credit Analyst / Petugas Wawancara

**Who:** Petugas yang melakukan wawancara nasabah untuk pengajuan limit kredit, kartu kredit, atau fasilitas perbankan lainnya.

**Jobs to be done:**
- "Saya mau lihat profil lengkap nasabah sebelum wawancara"
- "Saya mau form wawancara yang terstruktur, semua poin wajib terisi"
- "Saya mau lihat rekomendasi limit berdasarkan data yang saya input"
- "Saya mau submit hasil wawancara ke supervisor untuk approval"

### Secondary: Supervisor / Approval Officer

**Who:** Supervisor yang me-review hasil wawancara dan approve/reject pengajuan.

**Jobs to be done:**
- "Saya mau lihat semua pengajuan yang menunggu approval saya"
- "Saya mau bandingkan data wawancara dengan profil dan histori nasabah"
- "Saya mau approve/reject dengan catatan, bukan cuma tombol"
- "Saya mau escalation ke level atas kalau di luar wewenang"

### Tertiary: Customer Support & Dispute Agent

**Who:** Petugas yang menangani keluhan, sengketa transaksi, dan pertanyaan nasabah.

**Jobs to be done:**
- "Saya mau lihat histori lengkap transaksi yang disengketakan"
- "Saya mau track status investigasi dari buka sampai selesai"
- "Saya mau komunikasi langsung dengan nasabah via in-app chat"

---

## 5. Product Overview

### Core Concept: Operational Command Center

BankSatu OPS adalah single source of truth untuk semua aktivitas operational, diakses via mobile dan web:

```
         ┌──────────────┐     ┌──────────────┐
         │ Flutter Mobile│     │  Web Dashboard│
         │ (Daily Ops)   │     │ (Admin/Rprt)  │
         └──────┬───────┘     └──────┬────────┘
                │                    │
                └────────┬───────────┘
                         │
            ┌────────────▼────────────┐
            │     BankSatu OPS API     │
            └────────────┬────────────┘
                         │
            ┌────────────┼────────────┐
            │            │            │
     ┌──────▼──────┐ ┌──▼────┐ ┌─────▼──────┐
     │  Assessment │ │Apprvl │ │  Service   │
     │  • Interview│ │• Wkflw│ │ • Dispute  │
     │  • Scoring  │ │• Rvw  │ │ • CS Tools │
     │  • Document │ │• Esc  │ │ • LiveChat │
     └──────┬──────┘ └──┬────┘ └─────┬──────┘
            │            │            │
            └────────┬───┴────────────┘
                     │
          ┌──────────▼──────────┐
          │   BankSatu Core API  │
          │   (Shared Backend)   │
          └─────────────────────┘
```

### Key Design Principles

1. **Data completeness first** — semua informasi nasabah accessible dari satu layar
2. **Structured assessment** — wawancara tidak bisa submit kalau ada field wajib kosong
3. **Audit everything** — setiap view, edit, approve, reject tercatat
4. **Fast for power users** — keyboard shortcuts, bulk actions, advanced filter
5. **Compliance by design** — segregation of duties, dual control, 4-eyes principle

---

## 6. Architecture Overview

### System Components

```
┌─────────────────────────────────────────────────────────┐
│                   Client Layer                           │
│   Flutter Mobile (iOS + Android) — Daily Ops            │
│   React/Next.js Web — Admin & Reporting                 │
└──────────────────────────────┬──────────────────────────┘
                               │ HTTPS + mTLS + RBAC
┌──────────────────────────────▼──────────────────────────┐
│                  API Gateway (Shared)                    │
│   Auth middleware   Rate limiting   Role verification   │
└──────┬──────────────────────────────────────────────────┘
       │
┌──────▼──────────────────────────────────────────────────┐
│                  OPS Service Layer                       │
│                                                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │Assessment│  │ Approval │  │ Dispute  │              │
│  │ Service  │  │ Service  │  │ Service  │              │
│  └──────────┘  └──────────┘  └──────────┘              │
│                                                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │  Audit   │  │  Report  │  │   CS     │              │
│  │ Service  │  │ Service  │  │ Service  │              │
│  └──────────┘  └──────────┘  └──────────┘              │
└──────┬──────────────────────────────────────────────────┘
       │
┌──────▼──────────────────────────────────────────────────┐
│         Shared Data Layer (dengan BankSatu)             │
│  PostgreSQL   Redis   TimescaleDB                       │
└─────────────────────────────────────────────────────────┘
```

---

## 7. Feature Modules

### 7.1 Dashboard & Overview

**Purpose:** Operational command center — petugas lihat workload dan prioritas.

**Capabilities:**
- Ringkasan pengajuan pending (per jenis: limit, kartu, dispute)
- SLA timer — pengajuan yang hampir deadline
- Personal task queue ("Tugas Saya")
- Quick actions: cari nasabah, buat pengajuan baru
- Notifikasi real-time: pengajuan masuk, approval diminta, dispute eskalasi

**NFR:**
- Dashboard load < 1 detik
- Real-time update via WebSocket

---

### 7.2 Nasabah Search & Profile

**Purpose:** Single view 360° profil nasabah — semua data dalam satu layar.

**Capabilities:**
- Global search by nama, NIK, nomor rekening, nomor kartu, email, telepon
- Profile summary: foto KTP, data diri, alamat, pekerjaan
- Account overview: semua rekening, saldo, kartu aktif
- Transaction history dengan filter granular (tanggal, nominal, jenis)
- Credit history: limit saat ini, pengajuan sebelumnya, status approval
- Catatan internal (internal memo) — hanya visible ke petugas
- Tab navigasi: Overview, Keuangan, Dokumen, Wawancara, Approval, Audit

**NFR:**
- Search result < 500ms
- Profile load < 1 detik
- Minimum 3 tahun histori transaksi

---

### 7.3 Wawancara & Credit Assessment

**Purpose:** Form wawancara terstruktur untuk menilai kelayakan kredit dan menentukan limit nasabah. Ini adalah **core module** BankSatu OPS.

**Assessment Categories:**

#### A. Informasi Dasar Nasabah
- Nama lengkap, NIK, tanggal lahir, alamat sesuai KTP
- Status pernikahan, jumlah tanggungan
- Pendidikan terakhir
- Auto-populated dari KYC data

#### B. Informasi Pekerjaan & Penghasilan (IIR — Informasi Ikhtisar Rekening)
- Jenis pekerjaan: karyawan tetap, kontrak, wiraswasta, profesional, tidak bekerja
- Nama perusahaan / bidang usaha
- Lama bekerja / usaha berjalan
- **Pendapatan Bersih Bulanan** (dari gaji atau usaha)
- **Pendapatan Tambahan** (sampingan, investasi, sewa)
- **Total Pengeluaran Bulanan** (rutin + cicilan)
- Sumber data: slip gaji 3 bulan terakhir, rekening koran, SK pegawai

#### C. Informasi Usaha (khusus wiraswasta/pengusaha)
- Nama usaha, bidang usaha, lama beroperasi
- **Pendapatan Usaha Bulanan** (omzet)
- **Biaya Operasional Bulanan**
- **Laba Bersih Bulanan** (auto-calculated: omzet - biaya)
- Jumlah karyawan
- Legalitas usaha: SIUP, NIB, TDP, NPWP badan
- Laporan keuangan 6 bulan terakhir

#### D. Kepemilikan Aset
- Rumah tinggal: milik sendiri, sewa, keluarga (sertifikat)
- Kendaraan: mobil, motor (tahun, taksiran harga)
- Aset lain: tanah, emas, deposito, saham
- Estimasi total aset (auto-sum)

#### E. Kewajiban / Liabilitas
- Kredit aktif: KPR, KKB, kredit usaha, kartu kredit bank lain
- Cicilan bulanan total
- Debt-to-Income Ratio (auto-calculated: total cicilan / total pendapatan)

#### F. Tujuan Pengajuan & Simulasi Bunga

**Regulasi:** POJK 22/2023 tentang Perlindungan Konsumen — wajib transparansi suku bunga efektif (bukan cuma flat).

- Jenis fasilitas: kartu kredit, kredit usaha, KPR, personal loan
- Tujuan penggunaan dana
- Jumlah pengajuan limit
- **Simulasi bunga kredit (real-time calculator):**
  - Tenor (bulan): 6, 12, 24, 36, 48, 60
  - Suku bunga flat (%) — nominal yang dikutip ke nasabah
  - Suku bunga efektif (%) — auto-calculated: memperhitungkan compounding
  - Total pembayaran (pokok + bunga)
  - Cicilan bulanan
  - Biaya administrasi, provisi, asuransi (jika ada)
  - **Total biaya kredit (APR)** — angka wajib yang harus di-disclose ke nasabah per POJK 22/2023
- **Perbandingan visual:** grafik batang bunga flat vs bunga efektif, tabel amortisasi
- Disclaimer: "Simulasi ini bersifat ilustratif. Suku bunga final ditentukan saat approval."

**Formula Bunga Efektif (Metode Anuitas):**

```
Cicilan Bulanan = P × [i × (1 + i)^n] / [(1 + i)^n - 1]

Dimana:
  P = Pokok pinjaman
  i = Suku bunga per bulan (suku bunga tahunan / 12)
  n = Jumlah bulan (tenor)

APR (Annual Percentage Rate) = [(Total Pembayaran - Pokok) / Pokok] / Tenor Tahun × 100%
```

**Contoh:** Pinjaman Rp 10.000.000, tenor 12 bulan, bunga flat 10%/tahun.
- Bunga flat: cicilan = (10jt + 1jt) / 12 = Rp 916.667/bulan  
- Bunga efektif (anuitas): cicilan = Rp 879.159/bulan
- **APR = 10.47%** → angka ini yang wajib di-disclose ke nasabah per POJK 22/2023

**Disclaimer wajib ditampilkan:** "Simulasi ini bersifat ilustratif dan dapat berubah sewaktu-waktu. Suku bunga final ditentukan pada saat persetujuan kredit. Nasabah berhak mendapatkan informasi lengkap mengenai suku bunga, biaya, dan ketentuan sebelum menandatangani perjanjian kredit."

**NFR:**
- Kalkulator simulasi real-time, update setiap perubahan input
- Grafik render client-side, < 100ms

#### G. Rekomendasi & Scoring

Sistem menghitung skor otomatis berdasarkan bobot:

| Kriteria | Bobot | Skor (1-5) |
| -------- | ----- | ---------- |
| Pendapatan Bersih | 20% | Auto: < 5jt=1, 5-10jt=2, 10-25jt=3, 25-50jt=4, >50jt=5 |
| Debt-to-Income Ratio | 20% | Auto: >50%=1, 40-50%=2, 30-40%=3, 15-30%=4, <15%=5 |
| **SLIK / BI Checking** | 15% | Auto: kolektibilitas Macet=1, Diragukan=2, Kurang Lancar=3, DPK=4, Lancar=5 |
| Stabilitas Pekerjaan/Usaha | 15% | Manual: petugas input |
| Total Aset | 15% | Auto: berdasarkan total |
| Karakter (dari wawancara) | 10% | Manual: penilaian subjektif |
| Legalitas Usaha | 5% | Manual: kelengkapan dokumen |

**Skor Total = Σ (bobot × skor)**

**Rekomendasi Limit:**
- Skor ≥ 4.0 → Disetujui, limit = 30% × pendapatan bersih × 12 bulan
- Skor 3.0-3.9 → Disetujui dengan catatan, limit = 20% × pendapatan bersih × 12 bulan
- Skor 2.0-2.9 → Ditunda, butuh dokumen tambahan
- Skor < 2.0 → Ditolak

Petugas bisa override rekomendasi dengan justifikasi tertulis.

**Capabilities:**
- Form wawancara multi-section dengan progress bar
- Auto-populate data dari profil nasabah dan KYC
- Auto-calculation DTI, total aset, total liabilitas, skor
- Preview rekomendasi limit real-time saat form diisi
- Simpan draft (belum submit)
- Submit ke supervisor untuk approval
- Lampiran dokumen pendukung (slip gaji, rekening koran, dsb)
- History wawancara sebelumnya per nasabah

**NFR:**
- Auto-calculation < 100ms
- Form auto-save setiap 30 detik
- Semua field wajib terisi sebelum bisa submit
- Dokumen lampiran max 10MB per file, total 50MB

---

### 7.4 Approval Workflow

**Purpose:** Workflow approval multi-level dengan transparansi penuh.

**Capabilities:**
- Queue approval personal ("Menunggu Approval Saya")
- Detail pengajuan lengkap: data nasabah, hasil wawancara, rekomendasi, dokumen
- Tindakan: Setujui, Tolak, Minta Revisi, Eskalasi
- Setiap tindakan wajib disertai catatan/justifikasi
- Multi-level approval: Petugas → Supervisor → Manager → Direksi
- Parallel review: multiple approver bisa review bersamaan
- SLA tracking: pengajuan yang melebihi batas waktu auto-escalate
- Notifikasi ke petugas ketika pengajuan di-approve/reject
- Bulk approval untuk pengajuan rutin (batch)

**Approval Matrix:**

| Limit Pengajuan | Level 1 | Level 2 | Level 3 |
| --------------- | ------- | ------- | ------- |
| < Rp 10jt | Supervisor | — | — |
| Rp 10jt - 50jt | Supervisor | Manager | — |
| Rp 50jt - 500jt | Supervisor | Manager | Direksi |
| > Rp 500jt | Manager | Direksi | Komite Kredit |

**NFR:**
- Approval action < 1 detik
- Notifikasi real-time
- Audit trail immutable

---

### 7.5 KYC Review & Verifikasi

**Purpose:** Dashboard untuk me-review dan verifikasi KYC nasabah. Diperluas dengan e-KYC Dukcapil, CDD risk rating, dan document expiry tracking.

**Regulasi:** POJK 12/2017 (APU-PPT), Permendagri 104/2019 (e-KYC Dukcapil).

**Capabilities:**
- Queue KYC pending review
- Side-by-side view: foto KTP vs foto selfie/KYC face
- **e-KYC Dukcapil verification** (v2: real-time NIK validation via Dukcapil API. v1: API contract + format validation + mock response)
- NIK validation: format NIK 16 digit, kode wilayah (provinsi/kabupaten/kecamatan), tanggal lahir match
- Detail data KTP: NIK, nama, alamat, tanggal lahir, status perkawinan
- **CDD risk rating indicator** — menampilkan hasil auto risk-rating dari modul 7.13 di halaman KYC
- Flag potensial: foto blur, data tidak match, KTP terindikasi palsu, NIK tidak valid
- Tindakan: Approve, Reject dengan alasan, Minta Upload Ulang
- Bulk KYC review (batch processing)
- Statistik KYC: approval rate, rejection reasons, average review time

**Document Expiry & Re-KYC:**
- **KTP expiry tracking:** sistem deteksi KTP akan expired (H-90, H-60, H-30 hari)
- **Re-KYC reminder otomatis:** notifikasi ke petugas kalau KTP nasabah expired atau periodic CDD review sudah due
- **Re-KYC queue:** nasabah yang butuh update dokumen
- **Periodic review scheduler:** untuk nasabah High Risk (tiap 1 thn), Medium Risk (tiap 2 thn), Low Risk (tiap 3 thn)

**NFR:**
- Side-by-side image load < 2 detik
- KYC queue sortable by date, risk level, expiry urgency
- Periodic review reminder via cron job + push notification ke petugas

---

### 7.6 Sengketa & Dispute Resolution

**Purpose:** Case management end-to-end untuk sengketa transaksi dengan SLA escalation berbasis severity.

**Capabilities:**
- Queue sengketa: baru, dalam investigasi, selesai
- Detail sengketa: transaksi, nominal, merchant, alasan nasabah
- Timeline investigasi: catatan per langkah dengan timestamp
- Attachment: screenshot, bukti, dokumen pendukung
- Komunikasi internal: note antar petugas (tidak visible nasabah)
- Komunikasi eksternal: kirim pesan ke nasabah via in-app notification
- Integrasi dengan transaction log untuk verifikasi
- Resolusi: refund, tolak klaim, partial refund

**Severity-Based SLA Escalation Matrix:**

| Severity | Kriteria | SLA Resolusi | Eskalasi Level 1 | Eskalasi Level 2 |
| -------- | -------- | ------------ | ---------------- | ---------------- |
| **Kritis** | Fraud terkonfirmasi, nominal > Rp 50jt, kartu dicuri, transaksi luar negeri tidak dikenal | 24 jam | Supervisor (1 jam no action) | Manager (4 jam no action) |
| **Tinggi** | Nominal > Rp 10jt, merchant tidak dikenal, recurring tidak sah | 3 hari | Supervisor (1 hari no action) | Manager (2 hari no action) |
| **Sedang** | Nominal Rp 1jt-10jt, double charge, refund belum diterima | 7 hari | Supervisor (3 hari no action) | — |
| **Rendah** | Nominal < Rp 1jt, admin fee dispute, selisih kecil | 14 hari | Supervisor (7 hari no action) | — |

**NFR:**
- Case load < 1 detik
- Timeline real-time update
- Severity auto-assigned dari flag rules, bisa override manual
- Eskalasi otomatis via cron job + push notification

---

### 7.7 Transaction Monitoring

**Purpose:** Real-time monitoring transaksi untuk deteksi fraud, unusual activity, dan trigger pelaporan LTKM/LTKT ke PPATK.

**Regulasi:** UU 8/2010 (TPPU), PP 43/2015, Peraturan PPATK.

**Capabilities:**
- Live transaction feed dengan filter (nominal, jenis, nasabah)
- Flag otomatis: transaksi > threshold, luar kota/negara, midnight, multiple attempts
- Detail transaksi dengan full context (nasabah, device, lokasi, IP)
- Manual flag/unflag oleh petugas
- Bulk action: freeze kartu, blokir akun sementara
- Alert configuration: threshold nominal, frekuensi, pola spesifik
- Case creation: flag → investigasi → sengketa
- **LTKM/LTKT workflow trigger** — flag yang memenuhi kriteria PPATK otomatis membuat draft laporan di modul 7.15

**Flag Rules (Default):**

| Rule | Threshold | Aksi |
| ---- | --------- | ---- |
| Large single tx | > Rp 25jt | Flag kuning |
| Large single tx | > Rp 100jt | Flag merah + notif |
| Cash tx ≥ Rp 500jt | Akumulasi 1 hari | **Flag merah + trigger LTKT draft** |
| Cross-city tx | Dalam < 1 jam | Flag kuning |
| Midnight tx | 00:00 - 04:00, > Rp 5jt | Flag kuning |
| Multiple failed PIN | > 3x dalam 10 menit | Flag merah + freeze |
| New device + large tx | Device baru + > Rp 10jt | Flag merah |
| **Smurfing pattern** | Multiple tx < threshold ke rekening sama, total > threshold | **Flag merah + trigger LTKM draft** |
| **Tx ke high-risk country** | Negara FATF blacklist/greylist | **Flag merah + trigger LTKM draft** |
| **Tx tidak sesuai profil** | Nasabah penghasilan 5jt → tx 50jt | **Flag kuning + trigger LTKM draft** |
| **Unknown source** | Dana masuk besar dari sumber tidak dikenal | **Flag kuning + trigger LTKM draft** |

**NFR:**
- Transaction feed latency < 500ms dari core banking
- Flag detection < 100ms
- LTKM/LTKT draft auto-creation < 1 detik setelah flag merah

---

### 7.8 Reporting & Audit Trail

**Purpose:** Laporan operasional, audit trail compliance, dan maker-checker visual trace.

**Regulasi:** POJK 12/2017 (audit APU-PPT), UU 27/2022 (UU PDP — retensi & consent tracking).

**Capabilities:**
- **Maker-Checker Visual Trace:** setiap mutasi data sensitif (limit, status nasabah, approval) menampilkan UI eksplisit: siapa Maker (yang input/mengajukan) dan siapa Checker (yang approve). Bukan cuma log pasif — visual timeline dengan foto profil petugas dan timestamp
- Audit trail: setiap tindakan petugas tercatat (view, edit, approve, reject)
- Filter audit: by petugas, by nasabah, by jenis tindakan, by tanggal
- Export audit log (PDF/CSV)
- **UU PDP compliance tracking:**
  - Consent log: kapan nasabah memberikan persetujuan data, untuk tujuan apa
  - Data retention policy: aturan retensi per jenis data (KTP, transaksi, wawancara)
  - Right-to-erasure workflow: nasabah minta hapus data → petugas verifikasi → compliance officer approve → data di-anonimisasi
  - Data breach log: catat setiap akses tidak sah atau insiden data
- Operational reports: pengajuan per bulan, approval rate, rata-rata SLA
- Credit portfolio: total limit disetujui, default rate, segmentasi, kolektibilitas summary
- Dispute analytics: volume, resolution rate, top merchant masalah, severity distribution
- KYC metrics: approval rate, rejection reasons, processing time, Dukcapil hit rate
- **Pelaporan regulator:** pre-built report untuk OJK (SLIK summary, credit portfolio), PPATK (LTKM/LTKT submission log), BI (statistik perbankan)

**Data Retention Policy (Default):**

| Jenis Data | Retensi Aktif | Retensi Arsip | Ketentuan |
| ---------- | ------------- | ------------- | --------- |
| Data KTP & identitas | 5 tahun setelah nasabah tutup akun | +5 tahun | UU PDP |
| Transaksi keuangan | 5 tahun | +5 tahun | UU 8/2010 (TPPU) |
| Hasil wawancara kredit | Selama kredit aktif + 3 tahun | +2 tahun | POJK 64/2020 |
| Audit log petugas | 5 tahun | +5 tahun | POJK 12/2017 |
| SLIK report history | 3 tahun | +2 tahun | SEOJK 49/2020 |
| LTKM/LTKT | 10 tahun | +5 tahun | UU TPPU |

### Notification Channel Preferences & Opt-Out

**Regulasi:** UU PDP (UU 27/2022) — nasabah berhak memilih channel komunikasi dan opt-out.

**Capabilities:**
- **Channel preferences per nasabah:** SMS, Email, WhatsApp, In-App Push, Telepon
- **Opt-out granular:** nasabah bisa opt-out dari channel tertentu tanpa opt-out semua (misal: nonaktifkan SMS, tetap terima email)
- **Sinkronisasi ke modul CS (7.9):** petugas CS tidak bisa menghubungi via channel yang sudah di-opt-out — UI tampilkan warning "Nasabah telah opt-out dari channel ini"
- **Opt-out history:** track setiap perubahan preferensi dengan timestamp
- **Re-opt-in workflow:** nasabah bisa aktifkan kembali channel via BankSatu Mobile
- **Mandatory channel exception:** notifikasi transaksi, keamanan, dan regulasi TETAP dikirim walaupun nasabah opt-out (dasar hukum: kewajiban regulator)

### Compliance Officer Oversight

**Konteks:** Compliance Officer punya akses powerful (screening APU-PPT, approval LTKM, DTTOT override). Siapa yang mengaudit Compliance Officer?

**Capabilities:**
- **Compliance Review Role:** role terpisah "Compliance Reviewer" (bisa diisi oleh Internal Audit atau Direksi) yang punya akses read-only ke semua tindakan Compliance Officer
- **Auto-flag anomali Compliance Officer:**
  - Compliance Officer meng-override screening result tanpa justifikasi → flag
  - Compliance Officer approve LTKM untuk transaksi yang melibatkan dirinya sendiri → auto-reject
  - Compliance Officer melakukan bulk action tidak wajar → flag
- **Quarterly compliance audit report:** ringkasan semua tindakan Compliance Officer per kuartal untuk review Direksi
- **Segregation:** Compliance Officer TIDAK bisa meng-audit dirinya sendiri — hanya Compliance Reviewer yang bisa

---

### 7.9 Customer Service Tools

**Purpose:** Tool untuk petugas CS berinteraksi dengan nasabah.

**Capabilities:**
- In-app live chat dengan nasabah (dari BankSatu Mobile)
- Call log: catat panggilan telepon, durasi, ringkasan
- Ticket system: buat, assign, resolve ticket
- Knowledge base internal: FAQ, prosedur, skrip
- Quick reply template untuk pertanyaan umum
- Eskalasi ticket ke supervisor

**NFR:**
- Live chat latency < 500ms
- Ticket system real-time

---

### 7.10 Role-Based Access Control

**Purpose:** Kontrol akses granular dengan pemisahan tegas Maker vs Checker (four-eyes principle).

**Roles:**

| Role | Akses |
| ---- | ----- |
| **Credit Analyst** | Search nasabah, wawancara, submit pengajuan, lihat profil |
| **Supervisor** | Approval level 1, review wawancara, lihat semua pengajuan tim |
| **Manager** | Approval level 2, reporting, override limit |
| **Direksi** | Approval level 3, full reporting, audit log view |
| **CS Agent** | Search nasabah, dispute tools, live chat, ticket |
| **KYC Officer** | KYC review queue, approve/reject KYC |
| **Compliance Officer** | APU-PPT screening review, LTKM/LTKT approval, sanctions check |
| **Collection Agent** | Collection queue, follow-up tracking, restrukturisasi pengajuan |
| **Admin** | User management, role assignment, system config |

**Maker-Checker Separation (Four-Eyes Principle):**

| Tindakan | Maker (siapa yang melakukan) | Checker (siapa yang approve) |
| -------- | ---------------------------- | --------------------------- |
| Pengajuan limit kredit | Credit Analyst | Supervisor / Manager / Direksi |
| Perubahan limit | Supervisor | Manager |
| Restrukturisasi kredit | Collection Agent | Manager / Direksi |
| Write-off proposal | Collection Agent | Direksi / Komite Kredit |
| KYC approval | KYC Officer | Supervisor (random sampling 10%) |
| LTKM/LTKT submission | Compliance Officer | Manager Compliance |
| Data retention erasure | CS Agent | Compliance Officer |
| BO structure change ≥ 10% | Compliance Officer | Manager Compliance |
| User role change | Admin | Admin ke-2 (dual admin) |

**Dual Control untuk System Configuration:**

| Perubahan Konfigurasi | Maker | Checker |
| --------------------- | ----- | ------- |
| Flag rules threshold (7.7) | Admin | Admin ke-2 |
| Approval matrix limit (7.4) | Admin | Manager |
| Interest rate reference (7.17) | Admin | Manager |
| DTTOT/Sanctions list update (7.12) | Compliance Officer | Manager Compliance |
| Risk rating criteria bobot (7.13) | Manager | Direksi |
| SLA severity matrix (7.6) | Manager | Direksi |
| Role permission change (7.10) | Admin | Admin ke-2 + Manager |
| Data retention policy (7.8) | Compliance Officer | Direksi |

**Pengecualian Maker-Checker:**
- View/search tidak butuh checker
- Draft wawancara (belum submit) tidak butuh checker
- Internal note/komunikasi tidak butuh checker
- Tindakan oleh Compliance Officer untuk flag DTTOT/Sanctions positif → wajib checker

**Capabilities:**
- Granular permission per modul (view, create, edit, approve, delete)
- Dual control: tindakan kritis butuh 2 petugas berbeda (maker ≠ checker)
- **Auto-reject jika maker = checker** — sistem menolak approval dari petugas yang sama
- Session timeout 15 menit inactivity
- Login log per petugas dengan device fingerprint
- IP whitelist untuk akses dari luar kantor

**NFR:**
- Permission check tiap API call < 10ms
- Session management di Redis
- Maker-Checker validation real-time

---

### 7.11 SLIK / BI Checking Integration

**Purpose:** Cek riwayat kredit nasabah melalui Sistem Layanan Informasi Keuangan (SLIK) OJK. **Wajib regulasi untuk semua pengajuan kredit.**

**Regulasi:** POJK 64/2020, SEOJK 49/2020.

**v1 (Mock):**
- Skema database siap untuk menyimpan hasil SLIK: ID historis, total fasilitas, outstanding, kolektibilitas per bank
- UI menampilkan placeholder "Data SLIK" di profil nasabah dengan field: bank pelapor, jenis kredit, plafon, outstanding, kolektibilitas (Lancar/DPK/Kurang Lancar/Diragukan/Macet)
- Mock data untuk development dan demo

**v2 (Real Integration):**
- API integration ke SLIK OJK via ID portal
- Auto-fetch SLIK report saat pengajuan kredit baru
- Kolektibilitas existing diperhitungkan dalam skor di 7.3-G
- Flag otomatis: nasabah dengan kolektibilitas Macet di bank lain → auto-reject
- History SLIK check tercatat di audit trail

**NFR:**
- SLIK data caching 24 jam (tidak fetch ulang untuk nasabah yang sama di hari yang sama)
- Timeout API SLIK < 10 detik

---

### 7.12 APU-PPT & Sanctions Screening

**Purpose:** Screening Anti Pencucian Uang dan Pencegahan Pendanaan Terorisme. **Wajib per POJK 12/2017 dan PP 43/2015.**

**Capabilities:**
- **DTTOT screening:** setiap nasabah baru dan existing di-screen terhadap Daftar Terduga Teroris dan Organisasi Teroris
- **Sanctions list screening:** cek terhadap OFAC, UN Sanctions, EU Sanctions, dan daftar sanksi lokal
- **Adverse media check:** cek nama nasabah dan beneficial owner terhadap pemberitaan negatif (fraud, korupsi, kejahatan keuangan)
- **PEP screening:** deteksi Politically Exposed Person (Penyelenggara Negara) dan keluarganya
- Flag severity: Clear → No Hit → Possible Match → Confirmed Match
- Auto-block: Confirmed Match pada DTTOT atau sanctions → auto-reject + notifikasi ke compliance officer

**Risk Factors untuk Screening:**

| Risk Factor | Flag |
| ----------- | ---- |
| Nama di DTTOT | **Critical** — auto-reject, notifikasi PPATK |
| Nama di sanctions list (OFAC/UN/EU) | **Critical** — auto-reject |
| Adverse media — fraud/korupsi | **High** — mandatory EDD |
| PEP / keluarga PEP | **High** — mandatory EDD |
| Adverse media — negative non-kriminal | **Medium** — optional EDD |
| Usaha cash-intensive | **Medium** — enhanced monitoring |

**v1 (Mock):**
- Database skema untuk DTTOT dan sanctions list
- UI screening result di profil nasabah
- Mock screening engine (rule-based, bisa diganti dengan API real)
- Workflow flag → investigasi → resolve

**v2 (Real Integration):**
- API integration ke DTTOT (PPATK/BNPT)
- Real-time sanctions list sync (NLP-based name matching)
- Automated PEP database lookup

**NFR:**
- Screening auto-triggered saat nasabah baru terdaftar, pengajuan kredit, dan transaksi besar (> Rp 100jt)
- Screening latency < 2 detik

---

### 7.13 CDD/EDD Tiering & Risk Rating

**Purpose:** Customer Due Diligence dan Enhanced Due Diligence dengan risk-rating otomatis. **Wajib per POJK 12/2017.**

**Risk Rating Levels:**

| Level | Kriteria | Frekuensi Review | Approval |
| ----- | -------- | ---------------- | -------- |
| **Low Risk** (1) | Karyawan tetap, penghasilan stabil, dokumen lengkap, domisili jelas | Setiap 3 tahun | Supervisor |
| **Medium Risk** (2) | Wiraswasta, usaha menengah, domisili valid | Setiap 2 tahun | Supervisor + Manager |
| **High Risk** (3) | PEP/keluarga PEP, nasabah asing, usaha cash-intensive, adverse media hit, domisili tidak jelas | Setiap 1 tahun | Manager + Direksi |
| **Prohibited** (X) | DTTOT hit, sanctions confirmed, fraud confirmed | N/A | Auto-reject |

**EDD Requirements (High Risk):**
- Dokumen tambahan: sumber dana, laporan keuangan audited, referensi bank lain
- Wawancara wajib tatap muka (tidak bisa remote)
- Approval minimum 2 level (Manager + Direksi)
- Enhanced transaction monitoring (threshold lebih rendah)
- Beneficial owner identification (siapa pemilik manfaat sebenarnya)

**Capabilities:**
- Auto risk-rating calculation berdasarkan data nasabah + screening result
- Periodic review reminder: notifikasi 30 hari sebelum due date
- Risk re-assessment trigger: perubahan pekerjaan, adverse media baru, transaksi tidak wajar
- Risk history timeline: track perubahan rating dari waktu ke waktu
- Override risk rating manual dengan justifikasi (audit trailed)

**NFR:**
- Auto risk-rating calculation < 500ms
- Periodic review scheduler (cron job)

---

### 7.14 Restrukturisasi & Kolektibilitas (NPL Monitoring)

**Purpose:** Monitoring kolektibilitas kredit existing dan workflow restrukturisasi. **Wajib per SEOJK 42/2019.**

**Kolektibilitas Classification (SEOJK):**

| Kolektibilitas | Hari Tunggakan | Deskripsi |
| -------------- | -------------- | --------- |
| **1 — Lancar** | 0 hari | Pembayaran tepat waktu |
| **2 — DPK** (Dalam Perhatian Khusus) | 1-30 hari | Tunggakan ringan |
| **3 — Kurang Lancar** | 31-90 hari | Tunggakan signifikan |
| **4 — Diragukan** | 91-120 hari | Risiko tinggi gagal bayar |
| **5 — Macet** | > 120 hari | Gagal bayar, write-off |

**Capabilities:**
- **Kolektibilitas dashboard:** status semua nasabah kredit dengan filter per kolektibilitas
- **Auto-downgrade:** sistem otomatis menurunkan kolektibilitas berdasarkan hari tunggakan
- **Restrukturisasi workflow:** petugas mengajukan restrukturisasi (perpanjangan tenor, penurunan bunga, grace period) → approval berjenjang
- **Collection queue:** petugas collection dapat task list nasabah DPK dan Kurang Lancar untuk di-follow up
- **Call log & follow-up tracking:** setiap kontak dengan nasabah tercatat (telepon, WA, surat)
- **Agunan valuation tracking:** update nilai agunan secara berkala
- **Write-off proposal:** workflow untuk pengajuan hapus buku/hapus tagih dengan approval direksi
- **Recovery tracking:** tracking pembayaran setelah write-off

**Restrukturisasi Approval Matrix:**

| Tipe Restrukturisasi | Level 1 | Level 2 | Level 3 |
| -------------------- | ------- | ------- | ------- |
| Perpanjangan tenor ≤ 12 bulan | Supervisor | — | — |
| Perpanjangan tenor > 12 bulan | Supervisor | Manager | — |
| Penurunan bunga | Manager | Direksi | — |
| Grace period (penundaan pokok) | Manager | Direksi | — |
| Haircut / write-off | Direksi | Komite Kredit | — |

**NFR:**
- Kolektibilitas downgrade otomatis via nightly cron
- Collection queue sortable by tunggakan, nilai kredit, risk level
- Semua restrukturisasi tercatat di audit trail

### Dormant / Inactive Account Handling

**Regulasi:** POJK 12/2017 (APU-PPT) — rekening dormant yang tiba-tiba aktif = red flag. POJK 18/2021 tentang Rekening Dormant.

**Dormant Definition:**

| Status | Kriteria | Tindakan |
| ------ | -------- | -------- |
| **Active** | Transaksi dalam 6 bulan terakhir | Normal |
| **Inactive** | Tidak ada transaksi 6-12 bulan | Notifikasi ke nasabah (email/SMS) |
| **Dormant** | Tidak ada transaksi > 12 bulan | Restriksi: tidak bisa transfer/withdraw tanpa reaktivasi. Saldo tetap bisa dilihat. |
| **Dormant + Large Tx** | Dormant > 12 bulan + tiba-tiba transaksi > Rp 10jt | **Red flag** — auto-escalate ke compliance officer (potensi pencucian uang) |

**Capabilities:**
- **Auto-classification:** nightly cron meng-update status rekening berdasarkan transaksi terakhir
- **Dormant dashboard:** list semua rekening inactive dan dormant dengan filter
- **Reaktivasi workflow:** nasabah minta reaktivasi → wajib re-verifikasi KYC (termasuk CDD ulang) → petugas approve
- **Dormant alert:** notifikasi ke compliance officer jika rekening dormant melakukan transaksi besar
- **Pre-dormant notification:** 30 hari sebelum status jadi dormant, sistem kirim notifikasi ke nasabah
- **Escheatment placeholder:** field untuk tracking dana dormant yang akan diserahkan ke negara (UU jika applicable)

**NFR:**
- Dormant classification via nightly cron
- Reaktivasi butuh re-KYC mandatory (auto-trigger dari 7.5)

---

### 7.15 LTKM/LTKT Reporting (PPATK)

**Purpose:** Workflow generate dan submit Laporan Transaksi Keuangan Mencurigakan dan Laporan Transaksi Keuangan Tunai ke PPATK. **Wajib per UU 8/2010 dan PP 43/2015.**

**Trigger Rules:**

| Laporan | Trigger | Deadline |
| ------- | ------- | -------- |
| **LTKT** (Tunai) | Transaksi tunai ≥ Rp 500.000.000 (akumulasi 1 hari) | 14 hari kerja |
| **LTKM** (Mencurigakan) | Transaksi mencurigakan — tidak ada batas nominal | 3 hari kerja setelah diketahui |

**Indikator Transaksi Mencurigakan (sesuai PPATK):**
- Tidak sesuai profil & karakteristik nasabah
- Tidak memiliki tujuan ekonomis yang jelas
- Menggunakan identitas palsu/dokumen mencurigakan
- Transaksi dengan pihak di negara high-risk (FATF blacklist)
- Structured transaction (smurfing — dipecah di bawah threshold)
- Dana berasal dari unknown source secara tiba-tiba

**Capabilities:**
- Auto-flag transaksi yang memenuhi kriteria LTKT/LTKM
- Form pelaporan dengan field sesuai format PPATK (identitas pelapor, nasabah, transaksi, kronologi, indikator)
- Draft → review → submit workflow
- Tracking status pelaporan: draft, submitted, acknowledged PPATK
- History semua laporan per nasabah
- Attachment: bukti transaksi, kronologi, dokumen pendukung

**v1 (Mock):**
- Database skema dan form pelaporan lengkap
- Mock submission (simulasi, tidak kirim ke PPATK real)
- Workflow internal: flag → draft → review → mock submit

**v2 (Real Integration):**
- API integration ke goAML PPATK (jika tersedia)
- Auto-generate laporan dari flag transaksi

**NFR:**
- Flag detection real-time saat transaksi terjadi
- LTKM draft harus dibuat dalam 1x24 jam setelah flag

---

### 7.16 Beneficial Ownership (BO)

**Purpose:** Identifikasi Pemilik Manfaat (Beneficial Owner) dari nasabah badan usaha/korporasi. **Wajib per Permenkumham 21/2019 dan POJK 12/2017.**

**Definisi BO:** Orang perseorangan yang:
- Memiliki saham ≥ 25% (kepemilikan langsung)
- Memiliki hak suara ≥ 25%
- Menerima manfaat ≥ 25% dari laba perusahaan
- Memiliki kewenangan mengangkat/memberhentikan direksi
- Pengendali utama/ultimate beneficial owner

**Capabilities:**
- **BO Declaration Form:** struktur kepemilikan bertingkat (langsung → tidak langsung)
- **Ownership graph visual:** diagram pohon siapa memiliki apa, berapa persen
- **Multi-level BO:** capture pemilik tidak langsung melalui perusahaan perantara
- **Identitas BO:** NIK, nama, alamat, persentase kepemilikan, hubungan dengan pemilik terdaftar
- **BO Verification:** screening BO terhadap DTTOT, sanctions list, adverse media
- **BO History:** track perubahan struktur kepemilikan dari waktu ke waktu
- **BO Certificate:** generate surat pernyataan BO sesuai format Permenkumham
- **PEP Flag:** auto-flag jika BO adalah Penyelenggara Negara atau keluarganya

**Contoh Struktur BO:**

```
PT Maju Bersama (Nasabah)
├── Ahmad Sudrajat (45% saham — BO Langsung)
│   └── PT Holding Jaya (pemilik Ahmad 100%)
│       └── Maria Sudrajat (istri Ahmad — BO Tidak Langsung)
├── Budi Hartono (30% saham — BO Langsung)
├── PT Investasi Nusantara (25% saham)
│   └── Charlie Wijaya (60% saham PT Investasi — BO Tidak Langsung)
```

**NFR:**
- BO graph render < 500ms
- Setiap BO wajib di-screen terhadap APU-PPT (auto-trigger dari modul 7.12)
- BO declaration wajib di-update jika ada perubahan struktur ≥ 10%

---

### 7.17 Data Master & Reference Tables

**Purpose:** Reference data untuk validasi alamat, kode wilayah, dan data master lainnya.

**Reference Tables:**

| Tabel | Sumber | Penggunaan |
| ----- | ------ | ---------- |
| **Wilayah Administratif** (provinsi, kabupaten, kecamatan, kelurahan) | Kemendagri (Permendagri 58/2021) | Validasi alamat KTP di KYC (7.5), alamat usaha di wawancara (7.3-C) |
| **Kode Pos** | BPS / Pos Indonesia | Auto-complete alamat |
| **Kode KBLI** (Klasifikasi Baku Lapangan Usaha Indonesia) | BPS | Klasifikasi bidang usaha di wawancara (7.3-C) |
| **Daftar Bank** (kode bank + SWIFT) | BI | SLIK (7.11), transfer monitoring |
| **Kode MCC** (Merchant Category Code) | ISO | Transaction monitoring (7.7), flag rules per kategori |
| **Daftar Negara High-Risk** | FATF Greylist/Blacklist | APU-PPT screening (7.12), cross-border flag |
| **Daftar Penyelenggara Negara (PEP)** | Data publik | CDD/EDD (7.13), PEP auto-flag |
| **Suku Bunga Acuan** (BI Rate, LPS Rate) | BI, LPS | Simulasi bunga kredit (7.3-F) |

**Capabilities:**
- Reference data import (CSV/JSON/API sync)
- Version tracking: siapa update, kapan, perubahan apa
- Auto-complete di semua form menggunakan reference data (alamat, kode bank, KBLI)
- Deprecated data flag (wilayah pemekaran, kode bank kadaluarsa)
- Manual update oleh Admin dengan audit trail

**Periodic Review untuk Data Dinamis:**

| Data | Sumber | Frekuensi Update | Proses |
| ---- | ------ | ---------------- | ------ |
| FATF Greylist/Blacklist | FATF (www.fatf-gafi.org) | 3x/tahun (Feb, Jun, Okt) | Compliance Officer download → import CSV → Admin approve → audit trail |
| PEP List | Data publik (LHKPN, KPU, Kemendagri) | Quarterly | Compliance Officer update manual → Admin approve |
| DTTOT | PPATK / BNPT | Jika ada update | Compliance Officer import file → Admin approve |
| Sanctions List (OFAC, UN, EU) | Website resmi masing-masing | Monthly | Auto-scheduled check + manual import jika ada perubahan |
| BI Rate / LPS Rate | BI, LPS | Setiap perubahan (ad-hoc) | Admin update via form → audit trail |

**Update Workflow:**
1. Compliance Officer menerima/cek update dari sumber
2. Import data baru ke staging table (tidak langsung production)
3. Diff review: tampilkan perubahan (tambah, hapus, update) dari data sebelumnya
4. Admin atau Manager Compliance approve → data pindah ke production table
5. Audit trail: siapa import, siapa approve, timestamp, jumlah perubahan

**NFR:**
- Reference data cached di Redis, TTL 24 jam
- Auto-complete response < 200ms
- Import 50.000+ baris data wilayah < 30 detik

---

### 7.18 Card Servicing Operations

**Purpose:** Modul operasional kartu untuk task harian CS: blokir, reissue, PIN reset, kartu hilang/rusak.

**Capabilities:**
- **Kartu hilang/rusak workflow:** nasabah lapor via BankSatu Mobile → ticket otomatis dibuat di OPS → petugas verifikasi → blokir kartu lama → reissue kartu baru
- **PIN reset:** nasabah lupa PIN → petugas verifikasi identitas (KYC re-check) → reset PIN → kirim PIN baru via channel aman
- **Blokir/unblokir kartu ad-hoc:** nasabah minta blokir sementara (mis. travelling, kartu tertinggal) → petugas blokir/unblokir dari OPS
- **Kartu rusak/ganti jenis:** upgrade kartu (silver → gold → platinum) → reissue dengan nomor baru
- **Kartu tambahan (supplementary card):** pengajuan kartu tambahan untuk keluarga → approval → reissue
- **Kartu expired auto-reissue:** sistem deteksi kartu akan expired (H-60, H-30) → auto-buat ticket reissue → kirim kartu baru
- **Kartu gagal kirim/return:** tracking kartu yang dikembalikan kurir → update alamat → kirim ulang
- **Card stock management:** tracking stok kartu fisik (nomor kartu, status: tersedia/dipakai/rusak)
- **Card delivery tracking:** integrasi dengan kurir (resi, status pengiriman, estimasi tiba)
- Integrasi dengan modul 7.7 (Monitoring): freeze kartu saat fraud flag merah

**Kartu Types:**

| Jenis Kartu | Limit Range | Approval |
| ----------- | ----------- | -------- |
| Silver (Debit) | Saldo rekening | Otomatis |
| Gold (Kredit) | Rp 5jt - 25jt | Supervisor |
| Platinum (Kredit) | Rp 25jt - 100jt | Manager |
| Infinite/Black | > Rp 100jt | Direksi |

**NFR:**
- Blokir kartu dari OPS ke core banking < 2 detik
- Reissue card processing < 1 hari kerja (workflow, bukan cetak fisik)
- PIN reset butuh verifikasi identitas wajib (KYC re-check)

---

### 7.19 Loan Disbursement & Drawdown Tracking

**Purpose:** Workflow pencairan dana kredit setelah approval. Tracking disbursement sekaligus atau bertahap.

**Capabilities:**
- **Disbursement request:** setelah approval kredit (7.4), petugas atau nasabah mengajukan pencairan
- **Disbursement types:**
  - **Sekaligus (lumpsum):** seluruh plafon dicairkan satu kali (kredit konsumer, KPR)
  - **Bertahap (term drawdown):** dicairkan sesuai progress (kredit konstruksi, modal kerja) — setiap pencairan butuh approval
- **Drawdown schedule:** jadwal pencairan bertahap dengan milestone (contoh: 30% saat akad, 40% setelah progress 50%, 30% setelah selesai)
- **Pre-disbursement checklist:** verifikasi dokumen lengkap sebelum dana dicairkan:
  - Akad kredit ditandatangani
  - Agunan diikat (SKMHT/APHT untuk KPR)
  - Asuransi jiwa/kredit aktif
  - Biaya administrasi & provisi dibayar
- **Disbursement approval:** maker-checker per pencairan
- **Fund transfer execution:** dana dikirim ke rekening nasabah atau langsung ke pihak ketiga (developer, supplier)
- **Disbursement history:** timeline semua pencairan per fasilitas kredit
- **Remaining limit tracking:** plafon - total disbursed = sisa yang bisa dicairkan

**Disbursement Approval Matrix:**

| Jumlah Pencairan | Level 1 | Level 2 |
| ---------------- | ------- | ------- |
| ≤ Plafon, sesuai jadwal | Supervisor | — |
| Di luar jadwal / perubahan | Supervisor | Manager |
| > 80% plafon (final drawdown) | Manager | Direksi |

**NFR:**
- Disbursement execution ke core banking < 5 detik
- Pre-disbursement checklist semua harus checked sebelum bisa submit
- Drawdown schedule auto-reminder ke petugas H-7, H-3, H-1

---

### 7.20 Payment Exception Handling (SKNBI/RTGS/BI-FAST)

**Purpose:** Modul investigasi dan retur untuk transaksi pembayaran yang gagal di sistem kliring.

**Context:** Saat nasabah melakukan transfer via SKNBI/RTGS/BI-FAST, transaksi bisa gagal karena: salah nomor rekening, rekening tujuan tutup, nama tidak match, limit exceeded, sistem kliring timeout. Petugas OPS butuh tool untuk investigasi dan retur.

**Capabilities:**
- **Failed transaction queue:** semua transaksi kliring gagal dalam satu dashboard
- **Failure reason classification:**
  - Rekening tujuan tidak ditemukan
  - Nama penerima tidak sesuai
  - Rekening tujuan diblokir/tutup
  - Limit transaksi exceeded
  - Sistem kliring timeout / RTO (Return Timeout)
  - Duplikat transaksi
- **Investigation detail:** full context — data pengirim, penerima, nominal, reference number, timestamp, kliring batch ID
- **Retur otomatis:** dana auto-dikembalikan ke pengirim jika transaksi gagal (sesuai aturan BI)
- **Retur manual:** jika auto-retur gagal → petugas investigasi → retur manual
- **Retur notification:** notifikasi ke nasabah bahwa dana sudah dikembalikan + alasan kegagalan
- **Exception reporting:** laporan transaksi gagal per periode (untuk rekonsiliasi BI)
- **Escalation:** transaksi gagal > 1x24 jam tanpa resolusi → auto-escalate ke supervisor

**BI-FAST Specific:**
- BI-FAST bersifat real-time irrevocable — jika transaksi gagal, retur harus dalam batch yang sama
- Timeout BI-FAST = 60 detik → status "Pending" atau "Timed Out"

**SKNBI Specific:**
- SKNBI batch-based (4 batch/hari) — retur di batch berikutnya
- Daftar hitam penarik (blacklist) untuk cek yang ditolak berulang

**NFR:**
- Failed transaction feed real-time dari core banking
- Auto-retur < 5 menit setelah kegagalan
- Investigation queue sortable by nominal, urgency

---

### 7.21 Internal Fraud Detection (Employee Monitoring)

**Purpose:** Behavioral analytics untuk deteksi anomali pada tindakan petugas. **Concern serius di semua bank — insider threat.**

**Regulasi:** POJK 12/2017 (APU-PPT — termasuk pegawai bank), SEOJK tentang Manajemen Risiko Operasional.

**Detection Rules:**

| Rule | Threshold | Severity |
| ---- | --------- | -------- |
| **VIP profile lookup tanpa alasan bisnis** | Petugas search nasabah VIP/High-Net-Worth > 5x dalam sehari tanpa ticket/wawancara terkait | High |
| **Approval velocity anomali** | Petugas approve > 20 pengajuan dalam < 1 jam | Medium |
| **Approval outside working hours** | Approve/reject di luar jam kerja (00:00-06:00) tanpa on-call schedule | Medium |
| **Same-device login berbeda** | 1 device dipakai login oleh 2+ petugas berbeda | High |
| **Data export tidak wajar** | Petugas export > 1000 baris data nasabah dalam 1 hari | High |
| **Self-approval attempt** | Petugas mencoba approve pengajuan yang melibatkan dirinya atau keluarganya | Critical |
| **Repeated failed access** | Petugas gagal akses modul di luar role-nya > 5x | Medium |
| **Data change outside workflow** | Petugas mengubah data nasabah langsung via API/database (bukan via UI) | Critical |
| **Geolocation anomaly** | Petugas login dari 2 kota berbeda dalam < 1 jam | High |

**Capabilities:**
- Real-time flag untuk petugas (mirip transaction monitoring tapi untuk karyawan)
- Case creation otomatis: flag → investigasi internal → Compliance Reviewer
- Dashboard "Employee Risk Score" per petugas (agregat dari flag)
- Anomali pattern detection: cross-reference tindakan petugas dengan data nasabah
- **Segregation:** hanya Compliance Reviewer dan Direksi yang bisa lihat employee monitoring dashboard
- Whistleblower channel: petugas bisa lapor anomali rekan kerja secara anonim

**NFR:**
- Flag detection real-time
- Employee risk score update tiap 24 jam (batch)
- Data employee monitoring dienkripsi dan dipisahkan dari operational DB

---

### 7.22 Dual Authorization — Customer Transactions

**Purpose:** Dual authorization untuk transaksi nasabah yang membutuhkan multiple signatory (umum di rekening korporat/giro).

**Berbeda dari maker-checker internal (7.10):** Ini adalah authorization oleh **nasabah** (signatory rekening), bukan oleh petugas.

**Use Case:** PT Maju Bersaya punya rekening giro dengan 3 signatory: Direktur (Ahmad), Finance Manager (Budi), Komisaris (Citra). Transfer > Rp 500jt butuh approval minimum 2 dari 3 signatory.

**Capabilities:**
- **Signatory management per rekening:** daftar signatory, tipe (mandatory/optional), threshold approval
- **Transaction approval rules per rekening:**

  | Jumlah Transaksi | Signatory Requirement |
  | ---------------- | --------------------- |
  | < Rp 100jt | 1 signatory (any) |
  | Rp 100jt - 500jt | 2 signatory (any 2) |
  | > Rp 500jt | 2 signatory (1 harus Direktur/Komisaris) |
  | Semua transaksi luar negeri | 2 signatory wajib |

- **Signatory approval flow:** transaksi dibuat oleh 1 signatory → pending approval signatory lain → semua approve → transaksi dieksekusi
- **Timeout:** transaksi pending > 24 jam → auto-cancel + notifikasi
- **Signatory delegation:** signatory bisa mendelegasikan wewenang ke orang lain dengan batas waktu dan nominal tertentu
- **Audit trail:** siapa yang request, siapa yang approve, timestamp per signatory
- **Override oleh petugas:** dalam kondisi darurat (mis. signatory sakit semua), petugas bisa override dengan approval level lebih tinggi (Manager + Compliance Officer)

**Integration:**
- Signatory list disinkronkan dengan data BO (modul 7.16) — signatory yang juga BO harus di-flag
- Transaction monitoring (7.7) punya rule tambahan: transaksi yang menunggu dual approval > threshold

**NFR:**
- Approval notification ke semua signatory via push + email + SMS
- Timeout auto-cancel < 1 menit setelah deadline
- Override oleh petugas wajib audit trail + justifikasi tertulis

---

### Cross-Module Data Flow

Untuk memastikan konsistensi antar modul, berikut aliran data kunci yang harus terhubung:

| Flow | Source → Target | Data |
| ---- | --------------- | ---- |
| SLIK → Scoring | 7.11 → 7.3-G | Kolektibilitas SLIK otomatis masuk ke 15% bobot scoring kredit. Jika SLIK unavailable (mock), scoring pakai default Lancar=5. |
| Screening → CDD/EDD | 7.12 → 7.13 | Hasil APU-PPT screening (DTTOT, sanctions, PEP, adverse media) auto-trigger risk-rating upgrade. DTTOT hit → Prohibited (X). PEP hit → High Risk. |
| KYC → CDD/EDD | 7.5 → 7.13 | Dokumen KYC tidak lengkap → maksimum Medium Risk. KTP expired → flag untuk re-KYC sebelum approval bisa dilanjutkan. |
| CDD/EDD → Approval | 7.13 → 7.4 | Risk rating menentukan minimum approval level. Low Risk → Supervisor cukup. High Risk → wajib Manager + Direksi. Prohibited → auto-reject. |
| BO → APU-PPT | 7.16 → 7.12 | Setiap BO baru/berubah otomatis di-screen terhadap DTTOT, sanctions, adverse media. BO yang juga PEP → flag ke CDD/EDD. |
| Wawancara → Approval | 7.3 → 7.4 | Hasil wawancara + skor + rekomendasi limit → masuk ke queue approval. Override petugas → flag khusus di approval. |
| Approval → Disbursement | 7.4 → 7.19 | Setelah approval final, auto-create disbursement request. Pre-disbursement checklist harus complete sebelum dana cair. |
| Dormant → APU-PPT | 7.14 → 7.12 | Rekening dormant yang tiba-tiba transaksi besar → auto-flag ke compliance untuk screening ulang APU-PPT. |
| Flag → LTKM/LTKT | 7.7 → 7.15 | Flag merah (fraud, smurfing, high-risk country, unknown source) → auto-create LTKM/LTKT draft. |
| Flag → Sengketa | 7.7 → 7.6 | Flag kuning/merah dari monitoring → bisa dikonversi jadi case sengketa oleh petugas. |
| Card Fraud → Monitoring | 7.18 → 7.7 | Kartu blokir/reissue karena fraud → auto-flag di monitoring untuk tracking transaksi terkait. |
| Employee Flag → Compliance | 7.21 → 7.12 | Flag internal fraud (VIP lookup, self-approval) → auto-create case untuk Compliance Reviewer. |
| Dual Auth → Transaction | 7.22 → 7.7 | Transaksi korporat pending multi-signatory → masuk monitoring sebagai "Pending Approval" dengan timeout tracker. |

**Aturan umum integrasi:**
- Setiap perubahan status di modul upstream HARUS trigger event yang bisa dikonsumsi modul downstream (Event-Driven pattern)
- Semua data mengalir secara immutable — setiap perubahan mencatat versi baru, tidak overwrite
- Jika data source unavailable (mock/SLIK down), sistem harus graceful degrade dengan fallback default, bukan gagal total
- Setiap cross-module trigger tercatat di audit trail dengan correlation ID

---

## 8. API Surface

### Base URL

```
https://api.banksatu.dev/ops/v1
```

### Authentication

```
Authorization: Bearer <access_token>
X-OPS-User-ID: <officer_id>
X-Device-ID: <device_fingerprint>
```

### Role Verification

Setiap endpoint OPS memverifikasi role petugas. Header tambahan:

```
X-OPS-Role: credit_analyst | supervisor | manager | cs_agent | kyc_officer | admin
```

### Standard Response Envelope

```json
{
  "data": { ... },
  "meta": {
    "request_id": "req_xxx",
    "officer_id": "ops_xxx",
    "duration_ms": 142,
    "audit_id": "audit_xxx"
  },
  "error": null
}
```

Setiap mutasi (approval, rejection, edit) menghasilkan `audit_id` untuk traceability.

### Idempotency

Semua mutasi wajib menyertakan:

```
Idempotency-Key: <unique_key>
```

---

## 9. Mobile App & Web Dashboard

### Mobile App (Flutter)

**Framework:** Flutter 3.x (Dart) — share codebase dengan BankSatu Mobile.

**Target:** iOS 15+, Android 8+

**Digunakan untuk:** workflow harian di lapangan — petugas wawancara, supervisor approval on-the-go, KYC officer review dari tablet.

#### Navigation Structure (Mobile)

Aplikasi menggunakan `go_router` dengan `StatefulShellRoute` untuk 5 tab:

| Tab | Route | Content |
| --- | ----- | ------- |
| Dashboard | `/ops` | Task queue, SLA timer, quick stats |
| Nasabah | `/ops/nasabah` | Search, profil 360° |
| Pengajuan | `/ops/pengajuan` | Wawancara, approval queue |
| Monitoring | `/ops/monitoring` | Live feed, flag, sengketa |
| Lainnya | `/ops/lainnya` | Report, audit, admin |

#### Key Screens (Mobile)

| Screen | Route | Deskripsi |
| ------ | ----- | --------- |
| OpsDashboardScreen | `/ops` | Ringkasan + task queue personal |
| NasabahSearchScreen | `/ops/nasabah` | Search & list nasabah |
| NasabahProfileScreen | `/ops/nasabah/:id` | Profil 360° dengan tab navigasi |
| WawancaraBaruScreen | `/ops/nasabah/:id/wawancara/baru` | Form wawancara multi-section |
| WawancaraDetailScreen | `/ops/nasabah/:id/wawancara/:wid` | Detail hasil + rekomendasi |
| WawancaraDraftScreen | `/ops/wawancara/draft` | Draft wawancara tersimpan |
| ApprovalQueueScreen | `/ops/approval` | Queue approval personal |
| ApprovalDetailScreen | `/ops/approval/:id` | Detail + approve/reject/revisi |
| KYCQueueScreen | `/ops/kyc` | Queue review KYC |
| KYCDetailScreen | `/ops/kyc/:id` | Side-by-side KTP vs selfie |
| SengketaListScreen | `/ops/sengketa` | List sengketa aktif |
| SengketaDetailScreen | `/ops/sengketa/:id` | Timeline + case management |
| TxMonitoringScreen | `/ops/monitoring` | Live transaction feed |
| AuditLogScreen | `/ops/audit` | Audit trail viewer |
| ProfileScreen | `/ops/profil` | Profil petugas + settings |
| AdminUsersScreen | `/ops/admin/users` | Manajemen user (admin only) |

### Web Dashboard (React/Next.js)

**Framework:** React 19 + Next.js 16 (App Router)

**Target:** Desktop — Chrome 120+, Edge 120+

**Digunakan untuk:** analisis mendalam, reporting, bulk operations, admin konfigurasi.

#### Key Screens (Web)

| Screen | Route | Deskripsi |
| ------ | ----- | --------- |
| ReportsDashboard | `/ops/reports` | Laporan operasional + chart |
| CreditPortfolio | `/ops/reports/credit` | Portfolio kredit + segmentasi |
| AdminRoles | `/ops/admin/roles` | Role & permission config |
| SystemConfig | `/ops/admin/config` | Konfigurasi sistem (admin) |

### Key UX Principles

**Mobile:**
1. **Offline-capable** — form wawancara bisa diisi offline, sync saat online
2. **Thumb-friendly** — semua tindakan utama dalam jangkauan ibu jari
3. **Biometric confirm** — tindakan kritis (approve, reject) dikonfirmasi sidik jari
4. **Quick scan** — data nasabah bisa di-scan dari KTP fisik via kamera

**Web:**
1. **Power user efficiency** — keyboard shortcuts, bulk actions, advanced filter
2. **Data density** — maksimal informasi tanpa scroll berlebihan
3. **Dark mode default** — ruangan operasional biasanya low-light

---

## 10. Security & Compliance

### Security Measures

| Layer | Measure |
| ----- | ------- |
| Transport | TLS 1.3, certificate pinning |
| Auth | JWT access (15min) + refresh (1d), IP whitelist |
| RBAC | Permission check setiap API call |
| Audit | Semua tindakan tercatat immutable |
| Session | Auto-logout 15 menit inactivity |
| Dual Control | Tindakan kritis butuh 2 petugas (maker ≠ checker) |
| Data | Semua data nasabah di-mask di log, PII encrypted at rest |

### Compliance Standards

| Regulasi | Requirement | Implementasi |
| -------- | ----------- | ------------ |
| **POJK 12/2017** | APU-PPT: CDD/EDD, DTTOT screening, risk rating | Modul 7.12, 7.13 |
| **POJK 64/2020** | SLIK: BI Checking wajib untuk semua kredit | Modul 7.11 |
| **SEOJK 42/2019** | Kolektibilitas NPL: klasifikasi Lancar-Macet | Modul 7.14 |
| **UU 8/2010 (TPPU)** | LTKM/LTKT: pelaporan transaksi mencurigakan | Modul 7.15 |
| **UU 27/2022 (UU PDP)** | Pelindungan data pribadi: consent, retensi, right-to-erasure, channel opt-out | Modul 7.8 |
| **PP 43/2015** | APU-PPT: screening DTTOT, LTKM/LTKT | Modul 7.12, 7.15 |
| **POJK 22/2023** | Perlindungan Konsumen: transparansi suku bunga efektif, APR disclosure | Modul 7.3-F |
| **Permenkumham 21/2019** | Beneficial Ownership: identifikasi pemilik manfaat korporasi | Modul 7.16 |
| **Permendagri 104/2019** | e-KYC Dukcapil: NIK validation | Modul 7.5 |
| **Permendagri 58/2021** | Kode wilayah administratif Indonesia | Modul 7.17 |
| **POJK 18/2021** | Rekening Dormant: klasifikasi, reaktivasi, escheatment | Modul 7.14 |
| **BI SNAP** | Standar Open API nasional | API design |
| **ISO 27001** | Information security management | Security controls |
| **PCI DSS** | Keamanan data kartu (jika applicable) | Card data handling |

### UU PDP (UU 27/2022) — Data Privacy Requirements

| Requirement | Implementasi |
| ----------- | ------------ |
| **Consent tracking** | Consent log: kapan, untuk apa, versi kebijakan privasi yang disetujui |
| **Data retention** | Retensi per jenis data (lihat tabel 7.8), auto-delete/hapus setelah expired |
| **Right to access** | Nasabah bisa minta salinan data pribadi yang disimpan |
| **Right to erasure** | Workflow hapus data: nasabah request → petugas verifikasi → compliance officer approve → data anonimisasi |
| **Data breach notification** | Notifikasi ke nasabah dan regulator dalam 3x24 jam setelah breach diketahui |
| **DPO (Data Protection Officer)** | Role Compliance Officer bertindak sebagai DPO |
| **Data processing record** | Audit trail mencatat setiap akses, proses, dan transfer data pribadi |
| **Cross-border transfer** | Data nasabah tidak boleh keluar Indonesia tanpa izin eksplisit |

### Segregation of Duties

| Tidak Boleh | Karena |
| ----------- | ------ |
| Petugas wawancara approve pengajuan sendiri | Conflict of interest |
| CS agent akses credit scoring | Di luar wewenang |
| Satu orang complete approval semua level | 4-eyes principle |
| Maker = Checker untuk tindakan yang sama | Dual control — sistem menolak otomatis |
| Compliance Officer yang flag LTKM juga submit laporan | Konflik kepentingan investigasi |

---

## 11. Tech Stack

| Layer | Technology | Rationale |
| ----- | ---------- | --------- |
| Mobile | Flutter 3.x + Dart | Share codebase dengan BankSatu Mobile |
| Frontend Web | React 19 + Next.js 16 (App Router) | SSR opsional, RSC untuk data berat |
| UI Components (Web) | shadcn/ui + Tailwind CSS 4 | Consistent, accessible |
| State (Web) | TanStack Query + Zustand | Server state + client state |
| Tables (Web) | TanStack Table | Virtual scroll untuk 10K+ baris |
| Forms (Web) | React Hook Form + Zod | Validasi terstruktur |
| Charts (Web) | Recharts | Operational reports |
| API | Go (net/http + chi) | Shared dengan BankSatu |
| Database | PostgreSQL (shared) + Redis | ACID + cache/session |
| Real-time | WebSocket (shared) | Live feed, notif |
| Container | Docker + Docker Compose | Portabel |

---

## 12. Build Phases & Milestones

### Phase 1 — Core Operations (Weeks 1–4)

**Goal:** Search nasabah + wawancara + approval working end-to-end di Flutter mobile + Web.

- [ ] Flutter OPS project setup (share codebase dengan BankSatu Mobile)
- [ ] Next.js project setup dengan shadcn/ui (web dashboard)
- [ ] RBAC middleware (role verification) di API
- [ ] Nasabah search & 360° profile view (mobile + web)
- [ ] Form wawancara multi-section dengan auto-calculation (mobile)
- [ ] Approval workflow 2-level (Supervisor → Manager) — mobile + web
- [ ] Backend API OPS dengan mock data nasabah
- [ ] Audit trail untuk semua tindakan
- [ ] Shared PostgreSQL schema extension untuk OPS

**Deliverable:** Petugas bisa cari nasabah di mobile, isi form wawancara, submit, dan supervisor bisa approve/reject dari mobile atau web — semua tercatat di audit.

---

### Phase 2 — KYC & Dispute Operations (Weeks 5–7)

**Goal:** KYC operational + dispute management. Fokus pada fitur yang langsung digunakan petugas.

- [ ] KYC review queue dengan side-by-side view (KTP vs selfie)
- [ ] e-KYC Dukcapil placeholder (format validation + mock response)
- [ ] Document expiry tracking & re-KYC reminder otomatis
- [ ] Bulk KYC approve/reject
- [ ] Dispute case management dengan severity-based SLA escalation matrix
- [ ] Komunikasi internal + eksternal di sengketa
- [ ] SLA tracking untuk KYC dan sengketa
- [ ] **Card servicing — modul 7.18:** blokir/unblokir/reissue/PIN reset workflow, kartu hilang/rusak, supplementary card

**Deliverable:** Petugas bisa proses KYC dengan document tracking, sengketa dengan SLA, dan kartu servicing harian.

> **Catatan:** SLIK, APU-PPT, CDD/EDD (database schema + engine) dipindahkan ke Phase 2b — modul regulasi yang lebih berat secara teknis.

---

### Phase 2b — Compliance Regulatory Core (Weeks 8–10)

**Goal:** Modul regulasi wajib: SLIK, APU-PPT, CDD/EDD, Beneficial Ownership, Data Master.

- [ ] SLIK database schema + UI mock (field & API contract siap untuk integrasi OJK)
- [ ] APU-PPT screening engine: DTTOT, sanctions list, adverse media, PEP detection
- [ ] CDD/EDD auto risk-rating + periodic review scheduler + EDD requirements
- [ ] **Beneficial Ownership (BO) module — modul 7.16:** form struktur kepemilikan, ownership graph visual, BO history tracking, BO certificate generation
- [ ] **Data Master & Reference Tables — modul 7.17:** import wilayah administratif Kemendagri, KBLI, kode bank, FATF country list, PEP list
- [ ] **Dormant account flagging — modul 7.14:** auto-classification Active/Inactive/Dormant, reaktivasi + re-KYC workflow, dormant alert
- [ ] **Interest rate disclosure — modul 7.3-F:** kalkulator simulasi bunga flat vs efektif, APR calculator, tabel amortisasi, compliance POJK 22/2023
- [ ] **Notification channel opt-out — modul 7.8:** channel preferences per nasabah, opt-out granular, re-opt-in workflow, mandatory channel exception
- [ ] **Compliance Officer oversight — modul 7.8:** Compliance Reviewer role, auto-flag anomali, quarterly compliance audit report
- [ ] APU-PPT screening log + investigasi workflow
- [ ] BO ownership graph visual (siapa memiliki apa, berapa persen)
- [ ] Regional code auto-complete di form alamat

**Deliverable:** Compliance officer bisa screening nasabah, assign risk rating, capture BO, deteksi rekening dormant, dan petugas bisa simulasi bunga sesuai POJK 22/2023.

---

### Phase 3 — Monitoring, Collection, Disbursement & CS (Weeks 11–13)

**Goal:** Real-time monitoring + kolektibilitas + disbursement + payment exception + LTKM/LTKT + CS tools di mobile.

- [ ] Live transaction feed dengan flag otomatis + LTKM/LTKT trigger rules (mobile + web)
- [ ] Flag rules configuration termasuk threshold PPATK (web)
- [ ] Bulk action: freeze, blokir (mobile)
- [ ] Kolektibilitas dashboard + auto-downgrade cron (mobile + web)
- [ ] Restrukturisasi workflow + approval matrix (mobile)
- [ ] Collection queue + follow-up tracking (mobile)
- [ ] **Loan disbursement — modul 7.19:** lumpsum + term drawdown, pre-disbursement checklist, remaining limit tracking
- [ ] **Payment exception — modul 7.20:** failed transaction queue, SKNBI/RTGS/BI-FAST retur workflow, auto-retur
- [ ] LTKM/LTKT report draft generator + workflow submit (mobile + web)
- [ ] In-app live chat — petugas di mobile, nasabah di BankSatu Mobile
- [ ] Ticket system (mobile + web)
- [ ] Call log (mobile)
- [ ] **Internal fraud detection — modul 7.21:** employee monitoring rules, employee risk score dashboard, anomaly case creation
- [ ] **Dual authorization — modul 7.22:** multi-signatory per rekening, signatory approval flow, timeout auto-cancel

**Deliverable:** Petugas bisa monitor transaksi, kelola kolektibilitas, proses pencairan kredit, handle retur kliring, generate laporan PPATK, dan layani nasabah via chat — semua dari mobile.

---

### Phase 4 — Reporting, Admin & PDP (Weeks 14–15)

**Goal:** Web reporting + regulatory reports + user management + UU PDP compliance.

- [ ] Audit trail viewer dengan filter granular + maker-checker visual timeline (web)
- [ ] Operational reports: pengajuan, approval, dispute, KYC, kolektibilitas (web)
- [ ] Credit portfolio dashboard dengan segmentasi NPL (web)
- [ ] Pelaporan regulator: OJK summary, PPATK log, BI statistik (web)
- [ ] UU PDP: consent log, data retention policy, right-to-erasure workflow (web)
- [ ] Export PDF/CSV dengan filter granular (web)
- [ ] User management + role assignment dengan maker-checker separation (web)
- [ ] Scheduled report via email

**Deliverable:** Manajemen dan compliance officer bisa lihat laporan lengkap, laporan regulator, dan kelola user dengan UU PDP compliance.

---

### Phase 5 — Polish & Security Hardening (Weeks 16–18)

**Goal:** Polish, performance, security hardening — mobile + web.

- [ ] Mobile offline mode (sync wawancara draft, collection notes saat online)
- [ ] KTP scanner via kamera (mobile)
- [ ] Keyboard shortcuts & power user features (web)
- [ ] Bulk approval untuk pengajuan rutin (web)
- [ ] Advanced filter di semua list view (mobile + web)
- [ ] Performance optimization (list virtual scroll, data caching)
- [ ] Security audit & penetration testing (termasuk APU-PPT compliance audit)
- [ ] Load testing (50+ petugas concurrent)
- [ ] Compliance readiness checklist: semua modul regulasi siap untuk integrasi API eksternal di v2

**Deliverable:** App mobile + web production-ready, fast, secure, compliance-audit-ready.

---

## 13. Success Metrics

### Technical

| Metric | Target |
| ------ | ------ |
| Dashboard load | < 1 detik |
| Nasabah search | < 500ms |
| Wawancara form auto-calc | < 100ms |
| Approval action | < 1 detik |
| Transaction feed latency | < 500ms |
| Concurrent users | 100+ petugas |
| Uptime | 99.9% |

### Operational

| Metric | Target |
| ------ | ------ |
| Wawancara completion time | < 20 menit |
| Approval turnaround | < 4 jam (level 1), < 24 jam (level 2) |
| KYC review time | < 5 menit per nasabah |
| Dispute resolution | < 7 hari (reguler), < 2 hari (urgent) |
| Form error rate | < 2% (validasi cegah submit tidak lengkap) |

---

## 14. Open Questions

| # | Question | Owner | Deadline |
| --- | --- | --- | --- |
| OQ1 | Go atau NestJS untuk OPS backend? (Go jika share codebase dengan BankSatu) | Faisal | Phase 1 start |
| OQ2 | UI mobile: share codebase penuh dengan BankSatu Mobile atau Flutter project terpisah? | Faisal | Phase 1 start |
| OQ3 | UI web: dashboard-heavy (single page banyak widget) atau navigation-heavy? | Faisal | Phase 1 start |
| OQ4 | Skor kredit: rule-based dulu atau pakai model ML sederhana? | Faisal | Phase 1 start |
| OQ5 | Integrasi SLIK/BI Checking: kapan API OJK tersedia untuk integrasi real? Tanpa ini, Phase 2 tidak bisa claim compliance-ready. | Faisal | Phase 1 start |
| OQ6 | Integrasi Dukcapil: apakah ada akses API e-KYC Dukcapil? Atau fallback manual? | Faisal | Phase 2 |
| OQ7 | DTTOT & sanctions list: apakah ada akses API/file dari PPATK/BNPT? Atau pakai list publik (OFAC/UN)? | Faisal | Phase 2 |
| OQ8 | GoAML PPATK: apakah API pelaporan elektronik tersedia untuk integrasi? | Faisal | Phase 3 |
| OQ9 | Multi-tenant: satu instance untuk semua cabang atau per cabang? | Faisal | Phase 3 |
| OQ10 | Apache 2.0 atau MIT untuk lisensi OPS? (BankSatu Mobile mungkin beda lisensi) | Faisal | Sebelum public |
| OQ11 | Kapan APU-PPT screening dan SLIK akan jadi mandatory requirement untuk claim "production-ready"? | Faisal | **Resolved** — v1 = demo/pitch dengan compliance UI/DB ready (lihat MVP Scope). v2 = integrasi API eksternal + production-ready. |
| OQ12 | Scope v1: apakah v1 targetnya "prototype dengan compliance UI/DB siap" atau "aplikasi operasional dengan mock regulatory data"? | Faisal | **Resolved** — v1 = demo/pitch (P0+P1 modules operational dengan mock data, P2 = compliance UI/DB ready tanpa integrasi API eksternal). Lihat MVP Scope Definition di Section 3. |

---

_Dokumen ini adalah living document. Update setiap ada keputusan arsitektur atau perubahan scope._

---

**BankSatu OPS** — Operational excellence, compliance by design.
