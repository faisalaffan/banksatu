# Product Requirements Document — BankSatu OPS

**Version:** 0.1.0-draft
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
8. [API Surface](#8-api-surface)
9. [Web App](#9-web-app)
10. [Security & Compliance](#10-security--compliance)
11. [Tech Stack](#11-tech-stack)
12. [Build Phases & Milestones](#12-build-phases--milestones)
13. [Success Metrics](#13-success-metrics)
14. [Open Questions](#14-open-questions)

---

## 1. Executive Summary

**BankSatu OPS** adalah aplikasi internal untuk petugas dan operational staff BankSatu. Aplikasi ini menjadi backend operational hub — tempat petugas memproses pengajuan nasabah, melakukan wawancara credit assessment, meninjau KYC, menyelesaikan sengketa, dan memonitor transaksi.

BankSatu OPS adalah **companion app** untuk BankSatu Mobile (nasabah-facing). Jika BankSatu Mobile adalah tempat nasabah melakukan transaksi, BankSatu OPS adalah tempat petugas memastikan semua berjalan aman, compliant, dan efisien.

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
| G4  | KYC review dashboard & verifikasi dokumen                         | P1       |
| G5  | Dispute case management end-to-end                                | P1       |
| G6  | Real-time transaction monitoring & flagging                       | P1       |
| G7  | Audit trail lengkap (siapa, apa, kapan)                           | P1       |
| G8  | Role-based access control granular                                | P2       |
| G9  | Customer service tools (live chat, call log)                      | P2       |
| G10 | Reporting & analytics operational                                 | P2       |

### Non-Goals (v1)

- Integrasi dengan BI Checking/SLIK real-time — gunakan mock data
- AI/ML credit scoring otomatis — assessment tetap oleh petugas, AI sebagai rekomendasi saja
- Mobile native app untuk OPS — web-first untuk v1
- Integrasi core banking system real — gunakan mock
- Multi-cabang/multi-branch operational — single branch dulu

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

BankSatu OPS adalah single source of truth untuk semua aktivitas operational:

```
                    ┌─────────────────────┐
                    │   BankSatu OPS       │
                    │   (Web App)          │
                    └──────────┬──────────┘
                               │
            ┌──────────────────┼──────────────────┐
            │                  │                  │
     ┌──────▼──────┐   ┌──────▼──────┐   ┌──────▼──────┐
     │  Assessment │   │  Approval   │   │   Service   │
     │  Layer      │   │  Layer      │   │  Layer      │
     │             │   │             │   │             │
     │ • Interview │   │ • Workflow  │   │ • Dispute   │
     │ • Scoring   │   │ • Review    │   │ • CS Tools   │
     │ • Document  │   │ • Escalate  │   │ • Live Chat │
     └──────┬──────┘   └──────┬──────┘   └──────┬──────┘
            │                  │                  │
            └──────────────────┼──────────────────┘
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
│   Web App (React/Next.js) - Desktop First               │
│   Mobile-friendly untuk supervisor on-call              │
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

#### F. Tujuan Pengajuan
- Jenis fasilitas: kartu kredit, kredit usaha, KPR, personal loan
- Tujuan penggunaan dana
- Jumlah pengajuan limit

#### G. Rekomendasi & Scoring

Sistem menghitung skor otomatis berdasarkan bobot:

| Kriteria | Bobot | Skor (1-5) |
| -------- | ----- | ---------- |
| Pendapatan Bersih | 25% | Auto: < 5jt=1, 5-10jt=2, 10-25jt=3, 25-50jt=4, >50jt=5 |
| Debt-to-Income Ratio | 25% | Auto: >50%=1, 40-50%=2, 30-40%=3, 15-30%=4, <15%=5 |
| Stabilitas Pekerjaan/Usaha | 15% | Manual: petugas input |
| Total Aset | 15% | Auto: berdasarkan total |
| Karakter (dari wawancara) | 10% | Manual: penilaian subjektif |
| Legalitas Usaha | 10% | Manual: kelengkapan dokumen |

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

**Purpose:** Dashboard untuk me-review dan verifikasi KYC nasabah.

**Capabilities:**
- Queue KYC pending review
- Side-by-side view: foto KTP vs foto selfie/KYC face
- Detail data KTP: NIK, nama, alamat, tanggal lahir
- Validasi otomatis: NIK format, usia > 17, KTP tidak expired
- Flag potensial: foto blur, data tidak match, KTP terindikasi palsu
- Tindakan: Approve, Reject dengan alasan, Minta Upload Ulang
- Bulk KYC review (batch processing)
- Statistik KYC: approval rate, rejection reasons, average review time

**NFR:**
- Side-by-side image load < 2 detik
- KYC queue sortable by date, risk level

---

### 7.6 Sengketa & Dispute Resolution

**Purpose:** Case management end-to-end untuk sengketa transaksi.

**Capabilities:**
- Queue sengketa: baru, dalam investigasi, selesai
- Detail sengketa: transaksi, nominal, merchant, alasan nasabah
- Timeline investigasi: catatan per langkah dengan timestamp
- Attachment: screenshot, bukti, dokumen pendukung
- Komunikasi internal: note antar petugas (tidak visible nasabah)
- Komunikasi eksternal: kirim pesan ke nasabah via in-app notification
- Integrasi dengan transaction log untuk verifikasi
- SLA tracking: sengketa > 14 hari auto-escalate
- Resolusi: refund, tolak klaim, partial refund

**NFR:**
- Case load < 1 detik
- Timeline real-time update

---

### 7.7 Transaction Monitoring

**Purpose:** Real-time monitoring transaksi untuk deteksi fraud dan unusual activity.

**Capabilities:**
- Live transaction feed dengan filter (nominal, jenis, nasabah)
- Flag otomatis: transaksi > threshold, luar kota/negara, midnight, multiple attempts
- Detail transaksi dengan full context (nasabah, device, lokasi, IP)
- Manual flag/unflag oleh petugas
- Bulk action: freeze kartu, blokir akun sementara
- Alert configuration: threshold nominal, frekuensi, pola spesifik
- Case creation: flag → investigasi → sengketa

**Flag Rules (Default):**

| Rule | Threshold | Aksi |
| ---- | --------- | ---- |
| Large single tx | > Rp 25jt | Flag kuning |
| Large single tx | > Rp 100jt | Flag merah + notif |
| Cross-city tx | Dalam < 1 jam | Flag kuning |
| Midnight tx | 00:00 - 04:00, > Rp 5jt | Flag kuning |
| Multiple failed PIN | > 3x dalam 10 menit | Flag merah + freeze |
| New device + large tx | Device baru + > Rp 10jt | Flag merah |

**NFR:**
- Transaction feed latency < 500ms dari core banking
- Flag detection < 100ms

---

### 7.8 Reporting & Audit Trail

**Purpose:** Laporan operasional dan audit trail untuk compliance.

**Capabilities:**
- Audit trail: setiap tindakan petugas tercatat (view, edit, approve, reject)
- Filter audit: by petugas, by nasabah, by jenis tindakan, by tanggal
- Export audit log (PDF/CSV)
- Operational reports: pengajuan per bulan, approval rate, rata-rata SLA
- Credit portfolio: total limit disetujui, default rate, segmentasi
- Dispute analytics: volume, resolution rate, top merchant masalah
- KYC metrics: approval rate, rejection reasons, processing time
- Scheduled report: kirim otomatis ke email setiap minggu/bulan

**NFR:**
- Audit log immutable, write-once
- Export 10.000+ baris < 5 detik
- Report generation < 3 detik

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

**Purpose:** Kontrol akses granular berdasarkan role petugas.

**Roles:**

| Role | Akses |
| ---- | ----- |
| **Credit Analyst** | Search nasabah, wawancara, submit pengajuan, lihat profil |
| **Supervisor** | Approval level 1, review wawancara, lihat semua pengajuan tim |
| **Manager** | Approval level 2, reporting, override limit |
| **Direksi** | Approval level 3, full reporting, audit log view |
| **CS Agent** | Search nasabah, dispute tools, live chat, ticket |
| **KYC Officer** | KYC review queue, approve/reject KYC |
| **Admin** | User management, role assignment, system config |

**Capabilities:**
- Granular permission per modul (view, create, edit, approve, delete)
- Dual control: tindakan kritis butuh 2 petugas
- Session timeout 15 menit inactivity
- Login log per petugas
- IP whitelist untuk akses dari luar kantor

**NFR:**
- Permission check tiap API call < 10ms
- Session management di Redis

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

## 9. Web App

### Platform

- **Framework:** React 19 + Next.js 16 (App Router)
- **Target:** Desktop (utama), Tablet (supervisor on-call)
- **Browser:** Chrome 120+, Edge 120+, Safari 18+

### Navigation Structure

| Section | Content |
| ------- | ------- |
| Dashboard | Ringkasan, task queue, SLA timer |
| Nasabah | Search, profil 360°, history |
| Pengajuan | Wawancara baru, draft, queue |
| Approval | Queue approval, history |
| KYC | Review queue, verifikasi |
| Sengketa | Case management, timeline |
| Monitoring | Live feed, flag, alert |
| Laporan | Report, audit trail |
| Admin | User, role, konfigurasi |

### Key UX Principles

1. **Power user efficiency** — keyboard shortcuts, bulk actions, advanced filter
2. **Data density** — tampilkan maksimal informasi tanpa scroll berlebihan
3. **Contextual actions** — tindakan selalu tersedia tanpa pindah layar
4. **Real-time updates** — data selalu fresh tanpa manual refresh
5. **Dark mode default** — OPS sering dipakai dalam ruangan dengan pencahayaan rendah

### Key Screens

| Screen | Route | Deskripsi |
| ------ | ----- | --------- |
| OpsDashboard | `/ops` | Dashboard utama |
| NasabahSearch | `/ops/nasabah` | Search & list nasabah |
| NasabahProfile | `/ops/nasabah/:id` | Profil 360° nasabah |
| WawancaraBaru | `/ops/nasabah/:id/wawancara/baru` | Form wawancara baru |
| WawancaraDetail | `/ops/nasabah/:id/wawancara/:wid` | Detail hasil wawancara |
| WawancaraDraft | `/ops/wawancara/draft` | Draft wawancara |
| ApprovalQueue | `/ops/approval` | Queue approval |
| ApprovalDetail | `/ops/approval/:id` | Detail pengajuan + approve/reject |
| KYCQueue | `/ops/kyc` | Queue review KYC |
| KYCDetail | `/ops/kyc/:id` | Detail KYC side-by-side |
| SengketaList | `/ops/sengketa` | List sengketa |
| SengketaDetail | `/ops/sengketa/:id` | Detail sengketa + timeline |
| TxMonitoring | `/ops/monitoring` | Live transaction feed |
| AuditLog | `/ops/audit` | Audit trail |
| Reports | `/ops/reports` | Laporan operasional |
| AdminUsers | `/ops/admin/users` | Manajemen user |
| AdminRoles | `/ops/admin/roles` | Manajemen role |

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
| Dual Control | Tindakan kritis butuh 2 petugas |
| Data | Semua data nasabah di-mask di log |

### Compliance

- **OJK POJK** — perlindungan data nasabah, manajemen risiko
- **BI SNAP** — standar API nasional
- **ISO 27001** — information security management
- **PCI DSS** — jika memproses data kartu

### Segregation of Duties

| Tidak Boleh | Karena |
| ----------- | ------ |
| Petugas wawancara approve pengajuan sendiri | Conflict of interest |
| CS agent akses credit scoring | Di luar wewenang |
| Satu orang complete approval semua level | 4-eyes principle |

---

## 11. Tech Stack

| Layer | Technology | Rationale |
| ----- | ---------- | --------- |
| Frontend | React 19 + Next.js 16 (App Router) | SSR opsional, RSC untuk data berat |
| UI Components | shadcn/ui + Tailwind CSS 4 | Consistent, accessible |
| State | TanStack Query + Zustand | Server state + client state |
| Tables | TanStack Table | Virtual scroll untuk 10K+ baris |
| Forms | React Hook Form + Zod | Validasi terstruktur |
| Charts | Recharts | Operational reports |
| API | Go (net/http + chi) | Shared dengan BankSatu |
| Database | PostgreSQL (shared) + Redis | ACID + cache/session |
| Real-time | WebSocket (shared) | Live feed, notif |
| Container | Docker + Docker Compose | Portabel |

---

## 12. Build Phases & Milestones

### Phase 1 — Core Operations (Weeks 1–3)

**Goal:** Search nasabah + wawancara + approval working end-to-end di Web.

- [ ] Next.js project setup dengan shadcn/ui
- [ ] RBAC middleware (role verification)
- [ ] Nasabah search & 360° profile view
- [ ] Form wawancara multi-section dengan auto-calculation
- [ ] Approval workflow 2-level (Supervisor → Manager)
- [ ] Backend API OPS dengan mock data nasabah
- [ ] Audit trail untuk semua tindakan
- [ ] Shared PostgreSQL schema extension untuk OPS

**Deliverable:** Petugas bisa cari nasabah, isi form wawancara, submit, dan supervisor bisa approve/reject — semua tercatat di audit.

---

### Phase 2 — KYC & Dispute (Weeks 4–5)

**Goal:** Review KYC + dispute management.

- [ ] KYC review queue dengan side-by-side view
- [ ] Bulk KYC approve/reject
- [ ] Dispute case management dengan timeline
- [ ] Komunikasi internal + eksternal di sengketa
- [ ] SLA tracking untuk KYC dan sengketa

**Deliverable:** Petugas bisa proses KYC dan sengketa dalam satu platform.

---

### Phase 3 — Monitoring & CS (Weeks 6–7)

**Goal:** Real-time monitoring + customer service tools.

- [ ] Live transaction feed dengan flag otomatis
- [ ] Flag rules configuration
- [ ] Bulk action: freeze, blokir
- [ ] In-app live chat (petugas ↔ nasabah)
- [ ] Ticket system
- [ ] Call log

**Deliverable:** Petugas bisa monitor transaksi real-time dan layani nasabah via chat.

---

### Phase 4 — Reporting & Admin (Weeks 8–9)

**Goal:** Reporting + user management.

- [ ] Audit trail viewer dengan filter granular
- [ ] Operational reports (pengajuan, approval, dispute, KYC)
- [ ] Credit portfolio dashboard
- [ ] Export PDF/CSV
- [ ] User management + role assignment
- [ ] Scheduled report via email

**Deliverable:** Manajemen bisa lihat laporan dan kelola user.

---

### Phase 5 — Polish (Week 10)

**Goal:** Polish, performance, security hardening.

- [ ] Keyboard shortcuts & power user features
- [ ] Bulk approval untuk pengajuan rutin
- [ ] Advanced filter di semua list view
- [ ] Performance optimization (list virtual scroll, data caching)
- [ ] Security audit & penetration testing
- [ ] Load testing (50+ petugas concurrent)

**Deliverable:** App production-ready, fast, secure.

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
| OQ2 | UI: dashboard-heavy (single page banyak widget) atau navigation-heavy (banyak halaman)? | Faisal | Phase 1 start |
| OQ3 | Apakah petugas perlu akses mobile native? Atau mobile browser cukup? | Faisal | Phase 2 |
| OQ4 | Skor kredit: rule-based dulu atau pakai model ML sederhana? | Faisal | Phase 1 start |
| OQ5 | Integrasi SLIK/BI Checking: mock dulu atau pakai data dummy yang realistis? | Faisal | Phase 1 start |
| OQ6 | Multi-tenant: satu instance untuk semua cabang atau per cabang? | Faisal | Phase 3 |

---

_Dokumen ini adalah living document. Update setiap ada keputusan arsitektur atau perubahan scope._

---

**BankSatu OPS** — Operational excellence, built for the people who make banking work.
