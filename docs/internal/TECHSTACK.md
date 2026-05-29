## Tech Landscape — Digital Banking Platform

### Mobile Framework

| Tool | Keterangan | Status |
| --- | --- | --- |
| **Flutter** | Cross-platform (iOS + Android + Desktop) | **Dipilih** |
| React Native | JavaScript ecosystem, less performant | Alternatif |
| Kotlin Multiplatform | Growing, tapi ecosystem immature | Watch |
| SwiftUI + Jetpack Compose | True native, dua codebase | Tidak dipilih |

### Backend / API

| Tool | Keterangan | Status |
| --- | --- | --- |
| **Go (net/http + chi)** | Performa tinggi, type-safe, standard library kuat | Kandidat utama |
| **TypeScript (Hono + Bun)** | Cepat develop, unified JS/TS stack | Kandidat alternatif |
| FastAPI (Python) | AI/ML ecosystem kuat, kurang di concurrency | Tidak dipilih untuk core banking |
| Rust (Axum) | Performa maksimal, learning curve tinggi | Overkill untuk v1 |

### Database

| Tool | Keterangan | Status |
| --- | --- | --- |
| **PostgreSQL 16** | ACID, proven, extension ecosystem kaya | **Dipilih** |
| **TimescaleDB** | Time-series extension untuk data transaksi | **Dipilih** |
| Redis | Cache, session, rate limiting, pub/sub | **Dipilih** |
| CockroachDB | Distributed SQL, survivability tinggi | Overkill untuk v1 |
| MongoDB | Document store, tidak cocok untuk transaksi finansial | Tidak dipilih |

### Auth & Security

| Tool | Keterangan | Status |
| --- | --- | --- |
| **WebAuthn / FIDO2** | Passkey standard, biometric + device-bound | **Dipilih** |
| Ory Kratos | Open-source identity management | Pertimbangan |
| Clerk | Managed auth, bagus tapi third-party dependency | Alternatif managed |
| Keycloak | Enterprise IAM, terlalu berat | Tidak dipilih untuk mobile |

### Real-time Communication

| Tool | Keterangan | Status |
| --- | --- | --- |
| **WebSocket (Go gorilla/websocket)** | Native, performa tinggi | **Dipilih** |
| **Server-Sent Events** | Untuk streaming notifikasi ke mobile | **Dipilih** |
| Firebase Cloud Messaging | Push notification ke mobile | **Dipilih** |
| gRPC | Performa sangat tinggi, kurang mobile-friendly | Pertimbangan internal service |

### Observability

| Tool | Keterangan | Status |
| --- | --- | --- |
| **OpenTelemetry** | Standard tracing, vendor-neutral | **Dipilih** |
| **Prometheus + Grafana** | Metrics + dashboard | **Dipilih** |
| **Loki** | Log aggregation | **Dipilih** |
| Sentry | Error tracking mobile | **Dipilih** |

### Flutter State Management

| Tool | Keterangan | Status |
| --- | --- | --- |
| **Riverpod** | Compile-safe, testable, modern | Rekomendasi |
| Bloc | Popular, boilerplate berat | Alternatif |
| Provider | Simple, cukup untuk state basic | Pilihan minimal |
| Signals | Reaktif, mirip Solid.js | Watch |

### Flutter Packages (Key)

| Package | Use Case |
| --- | --- |
| flutter_secure_storage | Simpan token, PIN hash di Keychain/Keystore |
| local_auth | Biometric (Face ID, fingerprint) |
| flutter_screen_recording | Detek screen recording, security |
| drift (SQLite) | Local DB untuk offline cache |
| flutter_widget_from_html | Render HTML di transaksi/notif |
| go_router | Declarative routing dengan deep link |
| freezed | Immutable data classes, union types |
| flutter_hooks | Logic reuse tanpa boilerplate |

### CI/CD & Infrastructure

| Tool | Keterangan | Status |
| --- | --- | --- |
| **GitHub Actions** | CI/CD pipeline | **Dipilih** |
| **Docker + Docker Compose** | Local dev environment | **Dipilih** |
| **Makefile / Taskfile** | Task runner untuk command umum | **Dipilih** |
| Fastlane | Mobile app deployment ke App Store/Play Store | **Dipilih** |

### Testing

| Layer | Tool |
| --- | --- |
| Unit (Dart) | flutter_test + mockito |
| Widget | flutter_test (widget testing) |
| Integration | integration_test (native) atau Patrol |
| API Contract | Pact atau Dredd |
| Security | OWASP ZAP + custom audit |
| Load | k6 (untuk backend) |
| Accessibility | Accessibility Scanner + manual audit |

---

## Architecture Decision Records (ADR)

### ADR-001: Flutter untuk Mobile

**Keputusan:** Flutter sebagai framework mobile.

**Alasan:**
- Single codebase untuk iOS, Android, macOS, Windows
- Hot reload untuk iterasi cepat
- Performance native-quality untuk animasi dan transisi
- Dart type-safe, null-safety, mudah dipelajari

**Konsekuensi:**
- Tidak 100% native look-and-feel (acceptable trade-off)
- App size lebih besar dari native (~15-20MB base)
- Perlu custom platform channel untuk fitur OS-specific (passkey, widget)

### ADR-002: PostgreSQL + TimescaleDB untuk Data

**Keputusan:** PostgreSQL sebagai primary database dengan TimescaleDB extension.

**Alasan:**
- Transaksi finansial butuh ACID guarantee
- TimescaleDB memberikan time-series optimization untuk data transaksi (partitioning, compression, continuous aggregates)
- Satu database untuk OLTP + analytics (tidak perlu ETL pipeline terpisah)
- Hostable di mana saja (managed Cloud SQL atau self-hosted)

**Konsekuensi:**
- Perlu tuning untuk workload campuran (OLTP + analytics)
- Tidak se-scalable Cassandra untuk insert-only workload (acceptable untuk skala demo)

### ADR-003: Passkey/FIDO2 sebagai Auth Primer

**Keputusan:** Passkey sebagai metode autentikasi utama, PIN sebagai fallback.

**Alasan:**
- Security superior vs password dan SMS OTP
- Phishing-resistant
- UX lebih baik (biometric = 1 action)
- Standard W3C, didukung iOS 16+ dan Android 9+

**Konsekuensi:**
- User education diperlukan untuk adopsi
- Perlu implementasi WebAuthn server-side
- Fallback PIN harus tetap secure (rate-limited, hashed)

---

## Prioritas Pembelajaran (Sprint 0)

```
Week 1:   Flutter project structure + Riverpod + go_router
Week 2:   Flutter clean architecture (feature-first) + flutter_secure_storage
Week 3:   Backend API setup (Go/TS) + PostgreSQL schema + migration
Week 4:   Passkey/FIDO2 implementation research + PoC
```

---

## Catatan

Tech landscape perbankan digital lebih stabil dibanding AI/LLM landscape. Keputusan di atas bersifat foundational dan tidak akan banyak berubah dalam 6-12 bulan ke depan.

Yang penting bukan tools-nya, tapi:

1. **Arsitektur yang benar** — isolation, idempotency, audit trail
2. **Security mindset** — setiap fitur di-review dari sudut pandang attacker
3. **UX yang diuji dengan user nyata** — bukan asumsi developer

Fokus: **Flutter + Riverpod + PostgreSQL + Passkey + OpenTelemetry**.
