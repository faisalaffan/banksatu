# Product Requirements Document

# BankSatu — Digital Banking Platform

**Version:** 0.2.0-draft
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
   - 7.11 SME & Business Banking
   - 7.12 Wealth & Investments
   - 7.13 Syariah Banking
   - 7.14 Subscription Management
   - 7.15 Digital Lifestyle
   - 7.16 Digital Legacy & Inheritance
   - 7.17 Developer & Partner Platform
   - 7.18 Innovation Lab
8. [API Surface](#8-api-surface)
9. [Mobile App](#9-mobile-app)
10. [Compliance & Security](#10-compliance--security)
11. [Tech Stack](#11-tech-stack)
12. [Build Phases & Milestones](#12-build-phases--milestones)
13. [Success Metrics](#13-success-metrics)
14. [Risks & Trade-offs](#14-risks--trade-offs)
15. [Out of Scope](#15-out-of-scope)
16. [Open Questions](#16-open-questions)
- [Appendix A — Missing Screens Prioritization](#appendix-a--missing-screens-prioritization)
- [Appendix B — Screen Inventory (by Module)](#appendix-b--screen-inventory-by-module)

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
| G11 | SME banking: dashboard bisnis, invoice, programmable money        | P1       |
| G12 | Wealth & investments: portfolio, reksa dana, emas, deposito       | P2       |
| G13 | Syariah banking: rekening syariah, investasi halal, zakat         | P1       |
| G14 | Subscription management: recurring payment visibility & control   | P1       |
| G15 | Digital lifestyle: marketplace, loyalty, customer service         | P2       |
| G16 | Digital legacy: ahli waris digital, dispute resolution            | P2       |
| G17 | Developer platform: OAuth, personal API, webhook                   | P2       |
| G18 | Innovation lab: future rails, system status, beta access          | P3       |

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

### 7.11 SME & Business Banking

**Purpose:** Perbankan bisnis untuk UMKM dan freelancer dengan manajemen invoice dan programmable money.

**Capabilities:**
- Dashboard bisnis: pemasukan, piutang, batas kredit
- Pembuatan dan pengiriman invoice digital
- Programmable money: dana dengan aturan alokasi dan approval bertingkat
- Multi-role access: owner, kasir, akuntan dengan permission berbeda
- Real-time business cashflow overview

**NFR:**
- Invoice generation < 500ms
- Programmable money rule execution atomic

---

### 7.12 Wealth & Investments

**Purpose:** Investasi dan wealth management terintegrasi dalam satu platform.

**Capabilities:**
- Portofolio investasi real-time dengan MoM tracking
- Investasi reksa dana, emas, saham dari satu aplikasi
- Time deposit (deposito) dengan simulasi bunga
- Katalog produk keuangan dengan risk/return profile
- Live market data untuk keputusan investasi

**NFR:**
- Portfolio data sync < 5 detik
- Chart rendering 60fps

---

### 7.13 Syariah Banking

**Purpose:** Layanan perbankan syariah compliant untuk segmen pengguna muslim.

**Capabilities:**
- Rekening syariah tanpa riba
- Transparansi akad dan nisbah bagi hasil
- Portofolio investasi halal
- Kalkulator zakat otomatis

**NFR:**
- Sertifikasi syariah compliant
- Audit trail semua akad

---

### 7.14 Subscription Management

**Purpose:** Manajemen langganan dan recurring payment yang transparan.

**Capabilities:**
- Lihat semua subscription aktif dari berbagai sumber
- Deteksi kenaikan harga dan billing tidak wajar
- Cancel subscription langsung dari aplikasi
- Notifikasi sebelum auto-renewal
- Total spending per bulan untuk semua subscription

**NFR:**
- Subscription detection otomatis dari transaksi
- Billing calendar view

---

### 7.15 Digital Lifestyle

**Purpose:** Integrasi layanan gaya hidup dalam ekosistem perbankan.

**Capabilities:**
- Marketplace tiket, voucher, dan produk digital
- Loyalty program dengan points-based rewards
- Redemption rewards langsung dari aplikasi
- Customer service multi-channel (live chat, telepon, email)

**NFR:**
- Marketplace load < 2 detik
- Live chat response < 3 detik

---

### 7.16 Digital Legacy & Inheritance

**Purpose:** Perencanaan warisan digital dan perlindungan transaksi.

**Capabilities:**
- Penunjukan ahli waris digital dengan alokasi aset
- Verifikasi identitas ahli waris multi-factor
- Dispute resolution untuk transaksi tidak dikenal
- Ticket tracking investigasi transaksi
- Timeline otomatis untuk klaim warisan

**NFR:**
- Verifikasi ahli waris wajib biometric + dokumen
- Audit trail semua klaim dan dispute

---

### 7.17 Developer & Partner Platform

**Purpose:** Platform terbuka untuk developer dan integrasi pihak ketiga.

**Capabilities:**
- Personal API key dengan scope-based permission
- Webhook untuk event transaksi real-time
- OAuth 2.0 authorization untuk third-party apps
- API documentation interaktif
- Rate limiting dan usage analytics

**NFR:**
- API authentication < 10ms
- Webhook delivery < 500ms
- OAuth flow compliant dengan RFC 6749

---

### 7.18 Innovation Lab

**Purpose:** Fitur eksperimental dan infrastruktur untuk inovasi masa depan.

**Capabilities:**
- Future Rails: showcase fitur upcoming dan beta
- System status dashboard real-time
- Service health monitoring (Core Banking, BI-FAST, Card Auth)
- Latency tracking per komponen
- Early access opt-in untuk fitur beta

**NFR:**
- System status update real-time via WebSocket
- Beta feature toggle tanpa app update

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

Aplikasi menggunakan `go_router` dengan `StatefulShellRoute` untuk 5 tab bottom navigation:

| Tab | Route | Content |
| --- | ----- | ------- |
| Dashboard | `/` | Saldo, quick actions, recent transactions |
| Security | `/security` | Virtual card, spending control, dispute, digital heir |
| Subscriptions | `/subscriptions` | Manajemen subscription dan recurring payment |
| Syariah | `/syariah` | Rekening syariah, portofolio halal, zakat |
| Future Rails | `/future-rails` | Fitur eksperimental, beta access, system status |

Rute global (di luar shell navigation):

| Kategori | Route | Screen |
| -------- | ----- | ------ |
| **Auth & Onboarding** | `/onboarding` | OnboardingScreen |
| | `/login` | LoginScreen (passkey + PIN) |
| | `/oauth/authorize` | OAuthLoginScreen |
| | `/kyc/identity` | KYCIdentityScreen |
| | `/kyc/face` | KYCFaceScreen |
| | `/kyc/success` | KYCSuccessScreen |
| **Profile** | `/profile` | ProfileScreen |
| | `/profile/customer-service` | CustomerServiceScreen |
| **Transactions** | `/transactions/transfer` | TransferScreen |
| | `/transactions/pay-bills` | PayBillsScreen |
| | `/transactions/pln-detail` | PLNDetailScreen |
| | `/transactions/qris-scan` | QRISScanScreen |
| | `/transactions/bill-split` | BillSplitScreen |
| | `/transactions/scheduled` | ScheduledTransferScreen |
| **Wealth** | `/wealth/invest` | InvestScreen |
| | `/wealth/portfolio` | PortfolioScreen |
| | `/wealth/savings/time-deposit` | TimeDepositScreen |
| | `/wealth/savings/shared-vault` | SharedVaultScreen |
| | `/wealth/roundup` | RoundUpScreen |
| | `/wealth/roundup/instruments` | RoundUpInstrumentsScreen |
| | `/wealth/multicurrency` | MulticurrencyWalletScreen |
| | `/wealth/live-fx` | LiveFxRateScreen |
| | `/wealth/products` | FinancialProductsScreen |
| | `/wealth/shared-wallet` | SharedWalletScreen |
| **Analytics & AI** | `/analytics/chat` | AIAssistantScreen |
| | `/analytics/search` | AIAssistantSearchScreen |
| | `/analytics/insights` | AIFinancialInsightsScreen |
| | `/analytics/intelligence` | TransactionIntelligenceScreen |
| | `/analytics/notification` | NotificationIntelligenceScreen |
| | `/analytics/widgets` | WidgetQuickActionsScreen |
| **SME** | `/sme/dashboard` | SMEDashboardScreen |
| | `/sme/invoices/new` | SMENewInvoiceScreen |
| | `/sme/programmable-money/detail` | ProgrammableMoneyDetailScreen |
| | `/sme/programmable-money/verify` | ProgrammableMoneyVerifyScreen |
| | `/sme/programmable-money/rejected` | ProgrammableMoneyRejectedScreen |
| **Settings** | `/settings/accessibility` | AccessibilitySettingsScreen |
| | `/settings/themes` | ThemeCustomizerScreen |
| | `/settings/biometrics` | BiometricsSetupScreen |
| | `/settings/languages` | LanguageSelectorScreen |
| | `/settings/security-logs` | SecurityLogsScreen |
| **Dashboard** | `/dashboard/loyalty` | LoyaltyScreen |
| | `/dashboard/system-status` | SystemStatusScreen |
| | `/dashboard/lifestyle` | LifestyleMarketplaceScreen |
| | `/dashboard/notifications` | NotificationCenterScreen |
| **Security** | `/security/card-limit` | CardLimitSettingsScreen |
| | `/security/digital-heir` | DigitalHeirScreen |
| | `/security/dispute-manager` | DisputeManagerScreen |
| | `/security/virtual-card` | VirtualCardScreen |
| | `/security/credit-card` | CreditCardScreen |
| | `/security/personal-api` | PersonalApiScreen |
| **Dashboard (child)** | `/transaction/:id` | TransactionDetailScreen |

**Total: 56 screen, 56 route.**

### Router Phase Mapping

Komentar phase di `app_router.dart` dan relasi dengan PRD build phase:

| Router Phase | PRD Phase | Konten |
| ------------ | --------- | ------ |
| Phase 1 | Phase 1 | Onboarding, Login, OAuth, KYC, Profile |
| Phase 2 | Phase 1 | Transfer, PayBills, PLN, QRIS, BillSplit, Scheduled |
| Phase 3 | Phase 3 | Invest, Portfolio, TimeDeposit, SharedVault, RoundUp |
| Phase 4 | Phase 4 | AI Assistant, Search, Insights, Intelligence |
| Phase 5 | Phase 2 | SME Dashboard, Invoice, ProgrammableMoney |
| Phase 6 | Phase 5 | Accessibility, Themes, Biometrics, Language, SecurityLogs |
| 15 New Routes | Phase 3+ | Multicurrency, FX, FinancialProducts, CardLimit, SharedWallet, CustomerService, Lifestyle, Loyalty, NotificationCenter, SystemStatus, DigitalHeir, Dispute, VirtualCard, CreditCard, PersonalApi |

### Key UX Principles

1. **1-tap untuk frequent actions** — transfer ke kontak favorit cukup 1 tap dari home
2. **Biometric confirm, not password** — setiap transaksi dikonfirmasi dengan sidik jari/wajah
3. **Offline-first** — data ter-cache lokal, sync saat online
4. **Animasi meaningful** — bukan dekorasi, tapi feedback (swipe to confirm, shake on error)
5. **Passkey-first auth** — FIDO2 + biometric + PIN fallback, tanpa SMS OTP

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

- [x] Flutter project setup dengan arsitektur clean (feature-first)
- [x] Auth: passkey/FIDO2 + biometric + PIN fallback (LoginScreen, BiometricsSetupScreen)
- [x] Account: saldo, mutasi, detail transaksi (DashboardScreen, TransactionDetailScreen)
- [x] Transfer: intra-bank, antar-bank (TransferScreen, PayBillsScreen, PLNDetailScreen, QRISScanScreen)
- [x] Scheduled transfer (ScheduledTransferScreen)
- [x] Onboarding flow (OnboardingScreen, KYCIdentityScreen, KYCFaceScreen, KYCSuccessScreen)
- [x] Profile (ProfileScreen)
- [ ] Bulk transfer
- [ ] Request money
- [ ] Payment link generation
- [ ] Backend API dengan mock banking data
- [ ] PostgreSQL schema + migration setup
- [ ] Docker Compose untuk local dev

**Deliverable:** App bisa login, lihat saldo, transfer — semua di Flutter.

---

### Phase 2 — Security & Control (Weeks 5–6)

**Goal:** Fitur keamanan yang tidak ada di bank lain

- [x] Virtual card per-merchant (VirtualCardScreen, CreditCardScreen)
- [x] Card limit & spending lock (CardLimitSettingsScreen)
- [x] Security overview (SecurityScreen)
- [x] Login activity log (SecurityLogsScreen)
- [x] SME dashboard & invoicing (SMEDashboardScreen, SMENewInvoiceScreen)
- [x] Programmable money (ProgrammableMoneyDetailScreen, ProgrammableMoneyVerifyScreen, ProgrammableMoneyRejectedScreen)
- [x] OAuth authorization (OAuthLoginScreen)
- [x] Dispute manager (DisputeManagerScreen)
- [ ] Travel mode
- [ ] Device management (trusted device, remote logout)
- [ ] Decoy/duress PIN
- [ ] Freeze/unfreeze kartu per-channel

**Deliverable:** Pengguna punya kontrol granular atas kartu dan akun.

---

### Phase 3 — Money Management (Weeks 7–8)

**Goal:** Budgeting + analytics yang benar-benar berguna

- [x] Multi-currency wallet + live FX rate (MulticurrencyWalletScreen, LiveFxRateScreen)
- [x] Round-up auto-saving (RoundUpScreen, RoundUpInstrumentsScreen)
- [x] Shared wallet & vault (SharedWalletScreen, SharedVaultScreen)
- [x] Bill splitting (BillSplitScreen)
- [x] Investment & portfolio (InvestScreen, PortfolioScreen, TimeDepositScreen)
- [x] Financial products catalog (FinancialProductsScreen)
- [x] Subscription management (SubscriptionScreen)
- [ ] Categorized spending real-time (TransactionIntelligenceScreen — existing, needs enhancement)
- [ ] Envelope budgeting dengan hard stop
- [ ] Recurring payment management
- [ ] Financial health score
- [ ] Export laporan (PDF/CSV)

**Deliverable:** Pengguna paham kemana uang mereka pergi dan bisa kontrol.

---

### Phase 4 — Intelligence & Social (Weeks 9–10)

**Goal:** Fitur yang bikin BankSatu overpower

- [x] AI assistant & NL search (AIAssistantScreen, AIAssistantSearchScreen)
- [x] AI financial insights (AIFinancialInsightsScreen)
- [x] Transaction intelligence (TransactionIntelligenceScreen)
- [x] Smart notification (NotificationIntelligenceScreen, NotificationCenterScreen)
- [x] Widget quick actions (WidgetQuickActionsScreen)
- [x] Loyalty & rewards (LoyaltyScreen)
- [x] Lifestyle marketplace (LifestyleMarketplaceScreen)
- [x] Customer service (CustomerServiceScreen)
- [x] Personal API & webhook (PersonalApiScreen)
- [x] Digital heir (DigitalHeirScreen)
- [ ] Predictive cashflow
- [ ] Tax report export (SPT)
- [ ] Geolocation transaksi (peta)
- [ ] Group savings goal (patungan/arisan)
- [ ] Approval workflow untuk transaksi besar
- [ ] Contact-based transaction history

**Deliverable:** Banking app yang terasa cerdas, bukan cuma pencatat transaksi.

---

### Phase 5 — Polish & Accessibility (Weeks 11–12)

**Goal:** Production-ready polish + inclusive banking

- [x] Accessibility settings (AccessibilitySettingsScreen)
- [x] Theme customizer — high contrast/large text (ThemeCustomizerScreen)
- [x] Language selector (LanguageSelectorScreen)
- [x] Syariah banking (SyariahScreen)
- [x] Future rails & system status (FutureRailsScreen, SystemStatusScreen)
- [ ] Accessibility audit penuh (TalkBack, VoiceOver)
- [ ] Voice banking prototype
- [ ] Elder mode (UI disederhanakan: saldo + 2 tombol)
- [ ] Performance optimization (cold start < 1.5s)
- [ ] Offline mode enhancement
- [ ] Widget home screen
- [ ] Apple Watch / WearOS companion

**Deliverable:** App yang bisa dipakai semua orang, performa smooth.

### Phase 6 — Unimplemented Screens (Backlog)

Prioritas screen yang belum diimplementasi (19 screen). Lihat [Appendix A — Missing Screens Prioritization](#appendix-a--missing-screens-prioritization).

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
- **Apple Watch / WearOS companion** — menunggu demand & resource

Catatan: Screen Syariah, Future Rails, Lifestyle Marketplace, dan Loyalty yang sebelumnya tidak disebut di PRD kini dimasukkan sebagai modul 7.13, 7.15, 7.18. Screen-screen ini sudah diimplementasi di kode.

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

## Appendix A — Missing Screens Prioritization

19 screen dari PRD yang belum diimplementasi, diprioritaskan berdasarkan alignment dengan build phase.

### Priority A — Aligned Phase 1-3 (Core, Security, Money Mgmt)

| # | Screen | Modul PRD | Alasan |
|---|--------|-----------|--------|
| 1 | Bulk Transfer | 7.3 Transfers | Phase 1: transfer ke multiple rekening, fundamental |
| 2 | Device Management | 7.1 Auth | Phase 1: trusted device, remote logout |
| 3 | Sub-account Management | 7.2 Accounts | Phase 1: multi-account dengan permission |
| 4 | Payment Link Generation | 7.3 Transfers | Phase 1: payment link dengan expiry/limit |
| 5 | Request Money | 7.3 Transfers | Phase 1: kirim tagihan, dibayar langsung |
| 6 | Travel Mode | 7.4 Security | Phase 2: whitelist negara untuk kartu |
| 7 | Envelope Budgeting | 7.5 Money Mgmt | Phase 3: envelope dengan hard stop |
| 8 | Recurring Payment Mgmt | 7.5 Money Mgmt | Phase 3: lihat & cancel auto-debit |
| 9 | Export PDF/CSV | 7.5 Money Mgmt | Phase 3: export laporan dengan filter |
| 10 | Financial Health Score | 7.5 Money Mgmt | Phase 3: actionable score |

### Priority B — Aligned Phase 4-5 (Intelligence, Polish)

| # | Screen | Modul PRD | Alasan |
|---|--------|-----------|--------|
| 11 | Tax Report (SPT) | 7.7 AI | Phase 4: rekap untuk SPT |
| 12 | Predictive Cashflow | 7.7 AI | Phase 4: cashflow berbasis pola historis |
| 13 | Geolocation Map | 7.7 AI | Phase 4: peta transaksi |
| 14 | Group Savings Goal | 7.9 Social | Phase 4: patungan, arisan |
| 15 | Approval Workflow | 7.9 Social | Phase 4: approval transaksi besar |
| 16 | Contact-Based Tx History | 7.9 Social | Phase 4: history berdasarkan kontak |
| 17 | Voice Banking | 7.10 Accessibility | Phase 5: voice banking untuk tunanetra |
| 18 | Elder Mode | 7.10 Accessibility | Phase 5: UI sederhana saldo + 2 tombol |
| 19 | Decoy/Duress PIN | 7.1 Auth | Phase 2: PIN paksaan untuk keamanan |

## Appendix B — Screen Inventory (by Module)

Total 56 screen Dart, wired di `app_router.dart` via `go_router`.

### Shell Tabs (5)

| Tab | Screen | Route |
|-----|--------|-------|
| Dashboard | DashboardScreen | `/` |
| | TransactionDetailScreen | `/transaction/:id` |
| Security | SecurityScreen | `/security` |
| Subscriptions | SubscriptionScreen | `/subscriptions` |
| Syariah | SyariahScreen | `/syariah` |
| Future Rails | FutureRailsScreen | `/future-rails` |

### Global Routes (49)

| Module | Screen | Route |
|--------|--------|-------|
| 7.1 Auth | OnboardingScreen | `/onboarding` |
| | LoginScreen | `/login` |
| 7.17 Dev Platform | OAuthLoginScreen | `/oauth/authorize` |
| 7.1 Auth | KYCIdentityScreen | `/kyc/identity` |
| | KYCFaceScreen | `/kyc/face` |
| | KYCSuccessScreen | `/kyc/success` |
| 7.2 Accounts | ProfileScreen | `/profile` |
| 7.15 Digital Lifestyle | CustomerServiceScreen | `/profile/customer-service` |
| 7.3 Transfers | TransferScreen | `/transactions/transfer` |
| | PayBillsScreen | `/transactions/pay-bills` |
| | PLNDetailScreen | `/transactions/pln-detail` |
| | QRISScanScreen | `/transactions/qris-scan` |
| | BillSplitScreen | `/transactions/bill-split` |
| | ScheduledTransferScreen | `/transactions/scheduled` |
| 7.12 Wealth | InvestScreen | `/wealth/invest` |
| | PortfolioScreen | `/wealth/portfolio` |
| | TimeDepositScreen | `/wealth/savings/time-deposit` |
| | SharedVaultScreen | `/wealth/savings/shared-vault` |
| | RoundUpScreen | `/wealth/roundup` |
| | RoundUpInstrumentsScreen | `/wealth/roundup/instruments` |
| 7.6 FX | MulticurrencyWalletScreen | `/wealth/multicurrency` |
| | LiveFxRateScreen | `/wealth/live-fx` |
| 7.12 Wealth | FinancialProductsScreen | `/wealth/products` |
| 7.9 Social | SharedWalletScreen | `/wealth/shared-wallet` |
| 7.7 AI | AIAssistantScreen | `/analytics/chat` |
| | AIAssistantSearchScreen | `/analytics/search` |
| | AIFinancialInsightsScreen | `/analytics/insights` |
| | TransactionIntelligenceScreen | `/analytics/intelligence` |
| 7.8 Notif | NotificationIntelligenceScreen | `/analytics/notification` |
| 7.5 Money Mgmt | WidgetQuickActionsScreen | `/analytics/widgets` |
| 7.11 SME | SMEDashboardScreen | `/sme/dashboard` |
| | SMENewInvoiceScreen | `/sme/invoices/new` |
| | ProgrammableMoneyDetailScreen | `/sme/programmable-money/detail` |
| | ProgrammableMoneyVerifyScreen | `/sme/programmable-money/verify` |
| | ProgrammableMoneyRejectedScreen | `/sme/programmable-money/rejected` |
| 7.10 Accessibility | AccessibilitySettingsScreen | `/settings/accessibility` |
| | ThemeCustomizerScreen | `/settings/themes` |
| | BiometricsSetupScreen | `/settings/biometrics` |
| | LanguageSelectorScreen | `/settings/languages` |
| | SecurityLogsScreen | `/settings/security-logs` |
| 7.15 Digital Lifestyle | LoyaltyScreen | `/dashboard/loyalty` |
| 7.18 Innovation Lab | SystemStatusScreen | `/dashboard/system-status` |
| 7.15 Digital Lifestyle | LifestyleMarketplaceScreen | `/dashboard/lifestyle` |
| 7.8 Notif | NotificationCenterScreen | `/dashboard/notifications` |
| 7.4 Security | CardLimitSettingsScreen | `/security/card-limit` |
| 7.16 Digital Legacy | DigitalHeirScreen | `/security/digital-heir` |
| | DisputeManagerScreen | `/security/dispute-manager` |
| 7.4 Security | VirtualCardScreen | `/security/virtual-card` |
| | CreditCardScreen | `/security/credit-card` |
| 7.17 Dev Platform | PersonalApiScreen | `/security/personal-api` |

**BankSatu** — Modern digital banking, built right.
