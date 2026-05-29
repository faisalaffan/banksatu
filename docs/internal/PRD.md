# Product Requirements Document

# BankSatu — Digital Banking Platform

**Version:** 0.1.0-draft
**Author:** Muhammad Faisal Affan
**Status:** Draft
**Last Updated:** 2026-05-29

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Problem Statement](#2-problem-statement)
3. [Goals & Non-Goals](#3-goals--non-goals)
4. [Target Users](#4-target-users)
5. [Product Overview](#5-product-overview)
6. [Architecture Overview](#6-architecture-overview)
7. [Feature Modules](#7-feature-modules)
   - 7.1 Auth & Identity
   - 7.2 Accounts & Balances
   - 7.3 Transfers & Payments
   - 7.4 Security & Control
   - 7.5 Money Management
   - 7.6 Multi-currency & FX
   - 7.7 AI & Automation
   - 7.8 Notification Intelligence
   - 7.9 Social & Collaborative Finance
   - 7.10 Accessibility & Inclusivity
8. [API Surface](#8-api-surface)
9. [Mobile App](#9-mobile-app)
10. [Compliance & Security](#10-compliance--security)
11. [Tech Stack](#11-tech-stack)
12. [Build Phases & Milestones](#12-build-phases--milestones)
13. [Success Metrics](#13-success-metrics)
14. [Risks & Trade-offs](#14-risks--trade-offs)
15. [Out of Scope](#15-out-of-scope)
16. [Open Questions](#16-open-questions)

---

## 1. Executive Summary

**BankSatu** adalah platform perbankan digital modern yang dibangun untuk kecepatan, keamanan, dan kemudahan. Platform ini menutup gap antara apa yang diberikan bank tradisional Indonesia dan apa yang sebenarnya dibutuhkan pengguna modern.

BankSatu dibangun dengan dua lapisan:

- **Mobile App (Flutter)** — pengalaman perbankan cross-platform yang seamless
- **Backend API** — infrastruktur aman yang mendukung semua operasi perbankan

BankSatu tidak mencoba menjadi bank komersial. BankSatu adalah **reference implementation** arsitektur perbankan digital modern — membuktikan bahwa UX perbankan bisa lebih baik, lebih aman, dan lebih transparan.

---

## 2. Problem Statement

### Saat ini

Aplikasi perbankan Indonesia tertinggal secara UX dan fitur:

- **Fragmentasi:** pengguna butuh 3-4 aplikasi untuk kebutuhan finansial berbeda
- **UX buruk:** 4-5 step untuk transaksi yang seharusnya 1-tap
- **Keamanan outdated:** mayoritas masih SMS OTP, rentan SIM swap
- **Tidak transparan:** fee tersembunyi, FX markup, merchant name tidak readable
- **Locked-in:** data tidak portable, account closure sulit disengaja

### Akar Masalah

Tiga pola utama (dari analisis UNIQUE_POINT.md):

1. **Insentif bertentangan** — transparansi fee, FX spread, portabilitas data merugikan revenue bank
2. **Legacy + kultur** — core banking tua (Temenos, Finacle), tim IT-driven bukan product-driven
3. **Regulasi belum jelas** — CBDC, programmable money, identity provider

### Hipotesis

Jika BankSatu membangun platform perbankan dengan prinsip **transparency-first, security-modern, UX-radical**, maka:

- Pengguna dapat mengelola keuangan dari satu tempat
- Fitur yang seharusnya standard (virtual card, spending analytics, webhook) tersedia tanpa friksi
- Platform menjadi referensi bagaimana mobile banking seharusnya dibangun

---

## 3. Goals & Non-Goals

### Goals

| #   | Goal                                                              | Priority |
| --- | ----------------------------------------------------------------- | -------- |
| G1  | Auth modern: passkey/FIDO2, biometric, device binding             | P0       |
| G2  | Core banking: saldo, mutasi, transfer, bayar                      | P0       |
| G3  | Virtual card per-merchant dengan spending lock                    | P0       |
| G4  | Real-time notification intelligence (custom threshold, digest)    | P1       |
| G5  | Spending analytics & budgeting (envelope dengan hard stop)        | P1       |
| G6  | Multi-currency wallet dengan live mid-market rate                 | P1       |
| G7  | AI-powered: natural language search transaksi, predictive cashflow| P2       |
| G8  | Webhook & personal API untuk integrasi eksternal                  | P2       |
| G9  | Accessibility first: screen reader, high contrast, voice banking  | P2       |
| G10 | Social finance: shared wallet, group savings, bill splitting      | P2       |

### Non-Goals (v1)

- Lisensi perbankan resmi — ini reference implementation, bukan bank komersial
- Integrasi core banking system real (Temenos, Finacle) — gunakan mock/simulasi
- Kepatuhan penuh BI/OJK — arsitektur compliant-ready, bukan audited
- Crypto/stablecoin custody — di luar cakupan
- Web UI — mobile-first untuk v1

---

## 4. Target Users

### Primary: Mobile-First Digital Native

**Who:** Individu 20-40 tahun yang nyaman dengan teknologi, sudah pakai mobile banking tapi frustrasi dengan keterbatasannya.

**Pain points:**

- Perlu 3-4 aplikasi berbeda untuk kebutuhan finansial
- Tidak bisa lihat recurring payment yang aktif
- Transfer ke multiple rekening harus satu per satu
- Tidak tahu total pengeluaran per kategori secara real-time

**Jobs to be done:**

- "Saya mau lihat semua saldo dan pengeluaran di satu tempat"
- "Saya mau blokir kartu untuk merchant tertentu tanpa ganti kartu"
- "Saya mau kirim uang ke 5 orang sekaligus"
- "Saya mau notifikasi kalau pengeluaran kategori makan sudah > 2jt bulan ini"

### Secondary: SME / Freelancer

**Who:** Pemilik UMKM, freelancer, content creator yang butuh pemisahan keuangan bisnis dan pribadi.

**Pain points:**

- Tidak bisa bikin sub-account dengan permission berbeda
- Export ke accounting software harus manual CSV
- Tidak ada webhook untuk integrasi ke sistem sendiri

**Jobs to be done:**

- "Saya mau kasir saya bisa terima pembayaran tapi tidak bisa transfer keluar"
- "Saya mau transaksi otomatis masuk ke Jurnal/Accurate"
- "Saya mau payment link dengan expiry dan jumlah yang bisa diatur"

---

## 5. Product Overview

### Core Concept: Trusted Financial Hub

BankSatu diposisikan sebagai **single source of truth** untuk kehidupan finansial pengguna:

```
                    ┌─────────────────────┐
                    │   BankSatu Mobile    │
                    │   (Flutter App)      │
                    └──────────┬──────────┘
                               │
            ┌──────────────────┼──────────────────┐
            │                  │                  │
     ┌──────▼──────┐   ┌──────▼──────┐   ┌──────▼──────┐
     │   Security  │   │   Finance   │   │     AI      │
     │   Layer     │   │   Layer     │   │   Layer     │
     │             │   │             │   │             │
     │ • Passkey   │   │ • Accounts  │   │ • NL Search │
     │ • Biometric │   │ • Transfer  │   │ • Cashflow  │
     │ • VCard     │   │ • Budget    │   │ • Anomaly   │
     │ • Device    │   │ • FX        │   │ • Tax       │
     └──────┬──────┘   └──────┬──────┘   └──────┬──────┘
            │                  │                  │
            └──────────────────┼──────────────────┘
                               │
                    ┌──────────▼──────────┐
                    │   Core Banking API  │
                    │   (Mock/Simulated)  │
                    └─────────────────────┘
```

### Key Design Principles

1. **Transparency-first** — setiap fee, rate, dan status terlihat sebelum transaksi
2. **Security-modern** — passkey, biometric, device binding, no SMS OTP
3. **UX-radical** — 1-tap untuk frequent actions, widget, deep link
4. **Offline-capable** — saldo dan histori tetap bisa dilihat tanpa koneksi
5. **Accessible by default** — screen reader, high contrast, voice banking dari awal

---

## 6. Architecture Overview

### System Components

```
┌─────────────────────────────────────────────────────────┐
│                   Client Layer                           │
│   Flutter Mobile (iOS + Android)                        │
│   Platform: MacOS, Windows, Web (opsional)              │
└──────────────────────────────┬──────────────────────────┘
                               │ HTTPS + mTLS
┌──────────────────────────────▼──────────────────────────┐
│                  API Gateway                             │
│   Auth middleware   Rate limiting   Request routing     │
│   (Go / TypeScript — TBD)                               │
└──────┬──────────────────────────────────────────────────┘
       │
┌──────▼──────────────────────────────────────────────────┐
│                  Service Layer                           │
│                                                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │  Auth    │  │ Account  │  │ Transfer │              │
│  │ Service  │  │ Service  │  │ Service  │              │
│  └──────────┘  └──────────┘  └──────────┘              │
│                                                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │  Card    │  │ Budget   │  │  Notif   │              │
│  │ Service  │  │ Service  │  │ Service  │              │
│  └──────────┘  └──────────┘  └──────────┘              │
└──────┬──────────────────────────────────────────────────┘
       │
┌──────▼──────────────────────────────────────────────────┐
│                  Data Layer                              │
│  PostgreSQL (primary)   Redis (cache/session)            │
│  TimescaleDB (time-series untuk transaksi)              │
└─────────────────────────────────────────────────────────┘
       │
┌──────▼──────────────────────────────────────────────────┐
│               Observability Layer                        │
│   OpenTelemetry   Prometheus + Grafana   Loki            │
└─────────────────────────────────────────────────────────┘
```

### Data Flow: Transfer (Example)

```
User tap "Transfer"
    │
    ▼
Flutter App (biometric confirm)
    │
    ▼
API Gateway (auth + rate limit)
    │
    ▼
Transfer Service
    ├── Validate balance (Account Service)
    ├── Create transaction record (PostgreSQL)
    ├── Send notification (Notification Service)
    └── Log trace (OpenTelemetry)
    │
    ▼
Response → Flutter App (update saldo lokal)
```

---

## 7. Feature Modules

### 7.1 Auth & Identity

**Purpose:** Sistem autentikasi modern tanpa SMS OTP.

**Capabilities:**
- Passkey / FIDO2 login (biometric + device-bound)
- Device binding & trusted device management
- Remote logout semua device
- Login activity log (device + lokasi + waktu)
- Session-based OTP via in-app (bukan SMS)
- Decoy PIN / duress PIN

**NFR:**
- Biometric auth latency < 200ms
- Passkey fallback ke PIN (bukan SMS)

---

### 7.2 Accounts & Balances

**Purpose:** Manajemen rekening dengan real-time balance.

**Capabilities:**
- Multi-account view (tabungan, giro, deposito)
- Real-time balance update via SSE/WebSocket
- Offline balance view (cached)
- Widget home screen: saldo + quick action
- Sub-account dengan permission berbeda

---

### 7.3 Transfers & Payments

**Purpose:** Transfer dana dengan UX minimal.

**Capabilities:**
- Transfer ke sesama bank dan antar bank
- Bulk transfer (multiple rekening sekaligus)
- Scheduled transfer (dengan edit/cancel)
- Request money (kirim tagihan, dibayar langsung)
- Payment link dengan expiry/limit/amount
- 1-tap shortcut transaksi favorit
- Deep link ke transaksi spesifik (permalink bukti)

---

### 7.4 Security & Control

**Purpose:** Kontrol keamanan granular untuk pengguna.

**Capabilities:**
- Virtual card per-merchant (disposable/locked)
- Freeze/unfreeze kartu real-time per channel (online/ATM/POS)
- Spending lock per kategori merchant (MCC filter)
- Travel mode (whitelist negara)
- Notif kartu dipakai di luar kota/negara
- Temporary block + unblock tanpa ganti kartu

---

### 7.5 Money Management

**Purpose:** Budgeting dan analytics yang actionable.

**Capabilities:**
- Categorized spending analytics real-time
- Envelope budgeting dengan hard stop
- Round-up auto-saving
- Recurring payment management (lihat & cancel auto-debit)
- Full transaction history tanpa batas waktu
- Export PDF/CSV dengan filter granular
- Financial health score yang actionable

---

### 7.6 Multi-currency & FX

**Purpose:** Multi-currency wallet dengan transparansi penuh.

**Capabilities:**
- Multi-currency wallet real-time
- Live mid-market FX rate tanpa spread tersembunyi
- Hold foreign currency & convert manual saat rate bagus
- SWIFT fee transparency (lihat fee sebelum kirim)

---

### 7.7 AI & Automation

**Purpose:** AI-powered insights yang benar-benar berguna.

**Capabilities:**
- Natural language search transaksi ("makan di Senayan bulan lalu")
- Predictive cashflow berbasis pola historis
- Smart notification (anomaly detection)
- Tax report export (rekap untuk SPT)
- Merchant name cleaning (raw acquirer string → readable)
- Geolocation transaksi (peta)

---

### 7.8 Notification Intelligence

**Purpose:** Notifikasi yang cerdas, bukan spam.

**Capabilities:**
- Custom alert threshold ("notif kalau saldo < X")
- Quiet hours non-kritis
- Digest mode (rangkum notif harian bukan satu per satu)
- Transfer masuk dengan nama pengirim benar
- Notif jatuh tempo kewajiban dari semua sumber

---

### 7.9 Social & Collaborative Finance

**Purpose:** Keuangan yang bisa dikelola bersama.

**Capabilities:**
- Shared account / joint wallet
- Group savings goal (patungan, arisan)
- Bill splitting terintegrasi (native, bukan link eksternal)
- Contact-based transaction history
- Approval workflow untuk transaksi besar

---

### 7.10 Accessibility & Inclusivity

**Purpose:** Banking untuk semua orang, bukan hanya yang mampu secara visual/fisik.

**Capabilities:**
- Screen reader proper (TalkBack/VoiceOver) — full audit
- Voice banking (tunanetra/lansia)
- High contrast / large text mode
- Mode lansia (UI disederhanakan: saldo + 2 tombol)
- Dukungan bahasa daerah

---

## 8. API Surface

### Base URL

```
https://api.banksatu.dev/v1
```

### Authentication

```
Authorization: Bearer <access_token>
X-Device-ID: <device_fingerprint>
```

### Standard Response Envelope

```json
{
  "data": { ... },
  "meta": {
    "request_id": "req_xxx",
    "duration_ms": 142
  },
  "error": null
}
```

### Idempotency

Semua mutasi (transfer, payment) wajib menyertakan:

```
Idempotency-Key: <unique_key>
```

Server mendeteksi duplikat dan mengembalikan response original, bukan memproses ulang.

---

## 9. Mobile App

### Platform

- **Framework:** Flutter 3.x (Dart)
- **Target:** iOS 15+, Android 8+, macOS (opsional), Windows (opsional)

### Navigation Structure

| Tab | Content |
| --- | ------- |
| Home | Saldo, quick actions, widget, recent transactions |
| Transfer | Transfer, payment, request money |
| Cards | Virtual/physical cards, spending control |
| Analytics | Spending breakdown, budget, cashflow |
| Profile | Settings, security, accessibility |

### Key UX Principles

1. **1-tap untuk frequent actions** — transfer ke kontak favorit cukup 1 tap dari home
2. **Biometric confirm, not password** — setiap transaksi dikonfirmasi dengan sidik jari/wajah
3. **Offline-first** — data ter-cache lokal, sync saat online
4. **Animasi meaningful** — bukan dekorasi, tapi feedback (swipe to confirm, shake on error)

---

## 10. Compliance & Security

### Security Measures

| Layer | Measure |
| --- | --- |
| Transport | TLS 1.3, certificate pinning di mobile |
| Auth | Passkey/FIDO2, JWT access (15min) + refresh (7d) |
| Storage | Semua data sensitif encrypted at rest (AES-256) |
| API | Rate limiting, idempotency, input validation |
| Monitoring | Anomaly detection, audit trail semua akses |
| Keys | HSM untuk signing keys, key rotation otomatis |

### Compliance-Ready Architecture

Meskipun bukan bank berlisensi, arsitektur dirancang agar comply dengan:

- **BI SNAP** — standar Open API nasional
- **OJK** — perlindungan data nasabah
- **PCI DSS** — keamanan data kartu (Level 4)
- **ISO 27001** — information security management

---

## 11. Tech Stack

Lihat [TECHSTACK.md](./TECHSTACK.md) untuk landscape lengkap dan keputusan teknologi.

### Ringkasan

| Layer | Technology | Rationale |
| --- | --- | --- |
| Mobile | Flutter 3.x + Dart | Cross-platform, single codebase |
| API Gateway | Go (net/http + chi) atau TypeScript (Hono) | TBD Phase 1 |
| Database | PostgreSQL 16 + TimescaleDB | ACID + time-series |
| Cache | Redis | Session, rate limiting, cache |
| Observability | OpenTelemetry + Prometheus + Grafana + Loki | Standard, open-source |
| Container | Docker + Docker Compose (dev) | Portabel, reproducible |

---

## 12. Build Phases & Milestones

### Phase 1 — Core Banking (Weeks 1–4)

**Goal:** Auth + akun + transfer working end-to-end di Flutter app

- [ ] Flutter project setup dengan arsitektur clean (feature-first)
- [ ] Auth: passkey/FIDO2 + biometric + PIN fallback
- [ ] Account: saldo, mutasi, detail transaksi
- [ ] Transfer: intra-bank, antar-bank, bulk
- [ ] Backend API dengan mock banking data
- [ ] PostgreSQL schema + migration setup
- [ ] Docker Compose untuk local dev

**Deliverable:** App bisa login, lihat saldo, transfer — semua di Flutter.

---

### Phase 2 — Security & Control (Weeks 5–6)

**Goal:** Fitur keamanan yang tidak ada di bank lain

- [ ] Virtual card per-merchant
- [ ] Freeze/unfreeze kartu per-channel
- [ ] Spending lock per MCC
- [ ] Travel mode
- [ ] Device management (trusted device, remote logout)
- [ ] Login activity log

**Deliverable:** Pengguna punya kontrol granular atas kartu dan akun.

---

### Phase 3 — Money Management (Weeks 7–8)

**Goal:** Budgeting + analytics yang benar-benar berguna

- [ ] Categorized spending real-time
- [ ] Envelope budgeting dengan hard stop
- [ ] Recurring payment management
- [ ] Financial health score
- [ ] Multi-currency wallet + live FX rate
- [ ] Export laporan (PDF/CSV)

**Deliverable:** Pengguna paham kemana uang mereka pergi dan bisa kontrol.

---

### Phase 4 — Intelligence & Social (Weeks 9–10)

**Goal:** Fitur yang bikin BankSatu overpower

- [ ] NL search transaksi
- [ ] Predictive cashflow
- [ ] Smart notification (custom threshold, digest, quiet hours)
- [ ] Bill splitting + group savings
- [ ] Shared account / joint wallet

**Deliverable:** Banking app yang terasa cerdas, bukan cuma pencatat transaksi.

---

### Phase 5 — Polish & Accessibility (Weeks 11–12)

**Goal:** Production-ready polish + inclusive banking

- [ ] Accessibility audit penuh (TalkBack, VoiceOver)
- [ ] High contrast / large text / mode lansia
- [ ] Voice banking prototype
- [ ] Performance optimization (cold start < 1.5s)
- [ ] Offline mode enhancement
- [ ] Widget home screen
- [ ] Apple Watch / WearOS companion

**Deliverable:** App yang bisa dipakai semua orang, performa smooth.

---

## 13. Success Metrics

### Technical

| Metric | Target |
| --- | --- |
| App cold start | < 1.5s |
| Biometric auth latency | < 200ms |
| API P99 latency (read) | < 50ms |
| API P99 latency (write) | < 200ms |
| Offline availability | Semua read endpoints |
| Crash-free rate | > 99.5% |
| Accessibility score (WCAG) | AA minimum |

### Product

| Metric | Target |
| --- | --- |
| Transfer flow steps | ≤ 3 tap (dari home) |
| Frequent transfer | 1 tap |
| Notif open rate | > 40% (vs industry 10-15%) |
| Feature discoverability | In-app search, bukan FAQ |

---

## 14. Risks & Trade-offs

### Risk 1: Flutter vs Native

**Risk:** Flutter UI tidak 100% native look-and-feel.  
**Mitigation:** Target fidelity > 90%, bukan 100%. Custom cupertino/material adaptation.  
**Trade-off:** Single codebase vs dual native team. Untuk portofolio, Flutter jauh lebih efisien.

### Risk 2: Passkey adoption

**Risk:** Passkey masih baru di Indonesia, user belum familiar.  
**Mitigation:** Fallback ke PIN (bukan SMS). Edukasi in-app saat onboarding.  
**Trade-off:** Security modern vs familiar UX. Banking justify security.

### Risk 3: Real-time dengan mock backend

**Risk:** Tanpa core banking system real, demo terasa fake.  
**Mitigation:** WebSocket + state management yang realistis. Gunakan data generator untuk transaksi yang believable.  
**Trade-off:** Demonstrasi arsitektur, bukan koneksi ke bank produksi.

### Risk 4: Scope vs depth

**Risk:** 23+ kategori fitur (dari UNIQUE_POINT.md) tidak bisa semua diimplementasi.  
**Mitigation:** Phase 1-3 adalah core yang cukup untuk portofolio. Phase 4+ adalah showcase diferensiasi.  
**Trade-off:** Depth di 5-7 fitur kunci lebih baik dari breadth di 50 fitur.

---

## 15. Out of Scope

Items berikut **tidak** akan diimplementasi:

- **Lisensi perbankan resmi** — ini technical showcase, bukan commercial bank
- **Integrasi core banking real** (Temenos, Finacle) — gunakan mock
- **Crypto/stablecoin custody** — dilarang regulasi
- **CBDC (Rupiah Digital)** — menunggu BI
- **Kepatuhan penuh BI/OJK** — arsitektur compliant-ready, bukan audited
- **Web UI** — mobile-first, web bisa menyusul
- **Integrasi BI-Fast/DIPS real** — protokol compliance saja

---

## 16. Open Questions

| # | Question | Owner | Deadline |
| --- | --- | --- | --- |
| OQ1 | Go atau TypeScript untuk backend API? | Faisal | Phase 1 start |
| OQ2 | Mock banking data: generate random atau replay data real (anonimisasi)? | Faisal | Phase 1 start |
| OQ3 | State management Flutter: Riverpod atau Bloc? | Faisal | Phase 1 start |
| OQ4 | Gunakan BI SNAP API spec untuk kontrak API internal? | Faisal | Phase 1 start |
| OQ5 | Lisensi: MIT atau source-available? | Faisal | Sebelum public |
| OQ6 | Domain publik? | Faisal | Phase 4 |

---

_Dokumen ini adalah living document. Update setiap ada keputusan arsitektur atau perubahan scope._

---

**BankSatu** — Modern digital banking, built right.
