# Gap Fitur Mobile Banking Indonesia

Ringkasan fitur "overpower" yang masih kosong atau jarang ada di aplikasi perbankan Indonesia, beserta akar masalah dan implikasi untuk builder.

_Konteks: per awal 2026 — BRImo, Livin' by Mandiri, BCA Mobile/myBCA, Wondr BNI, Jenius, M2U Maybank._

---

## 1. Security & Control

| Fitur                                                        | Status di ID                                                     |
| ------------------------------------------------------------ | ---------------------------------------------------------------- |
| Virtual card per-merchant (disposable/locked)                | Hampir tidak ada. BCA punya virtual card tapi bukan per-merchant |
| Freeze/unfreeze kartu real-time per channel (online/ATM/POS) | Sangat jarang                                                    |
| Spending lock per kategori merchant (MCC filter)             | Tidak ada                                                        |
| Session-based OTP device binding (bukan SMS)                 | Mayoritas masih SMS OTP — rentan SIM swap                        |
| Passkey / FIDO2 login                                        | Belum ada bank besar yang full passkey                           |
| Login activity log (device & lokasi)                         | Hampir tidak ada                                                 |
| Remote logout semua device                                   | Tidak ada                                                        |
| Trusted device management                                    | Tidak ada                                                        |
| Travel mode (whitelist negara)                               | Tidak ada                                                        |
| Transaction signing dengan hardware key/passkey              | Tidak ada                                                        |
| Decoy PIN / duress PIN (PIN palsu saat dipaksa di ATM)       | Tidak ada                                                        |

## 2. Money Management

| Fitur                                                    | Status di ID                                           |
| -------------------------------------------------------- | ------------------------------------------------------ |
| Round-up auto-invest                                     | Livin' versi basic, mayoritas tidak ada                |
| Envelope budgeting dengan hard stop                      | Jenius "kapsul" tapi tidak enforce blocking            |
| Categorized spending analytics real-time                 | Wondr BNI awal, tidak granular                         |
| Bill splitting terintegrasi (bukan link eksternal)       | Tidak ada native                                       |
| Recurring payment management (lihat & cancel auto-debit) | Tidak ada — user tidak tahu siapa saja yang auto-debit |

## 3. Multi-currency & FX

| Fitur                                                  | Status di ID                                            |
| ------------------------------------------------------ | ------------------------------------------------------- |
| Multi-currency wallet real-time                        | Wondr BNI baru launch 12 mata uang (Jul 2025), terbatas |
| Live mid-market FX rate tanpa spread tersembunyi       | Tidak ada — semua markup besar                          |
| Hold foreign currency & convert manual saat rate bagus | Belum ada yang proper                                   |
| SWIFT fee transparency (lihat fee sebelum kirim)       | Tidak ada — fee kejutan setelah transaksi               |

## 4. AI / Automation

| Fitur                                      | Status di ID        |
| ------------------------------------------ | ------------------- |
| Natural language search transaksi          | Tidak ada           |
| Predictive cashflow berbasis pola historis | Tidak ada           |
| Smart notification (anomaly detection)     | Tidak ada eksplisit |
| Tax report export (rekap untuk SPT)        | Tidak ada           |

## 5. SME / Power User

| Fitur                                                                     | Status di ID                                |
| ------------------------------------------------------------------------- | ------------------------------------------- |
| Sub-account dengan permission (kasir bayar tapi tak bisa transfer keluar) | Tidak ada di consumer. BCA Bisnis terbatas  |
| API access untuk personal account (Open Banking)                          | BI sudah regulasi SNAP, adopsi minim        |
| Webhook / notifikasi ke sistem eksternal                                  | Tidak ada untuk personal                    |
| Bulk payment dari CSV untuk UMKM                                          | Mandiri CMS ada tapi enterprise only, mahal |

## 6. UX / Interaction Layer

| Fitur                                             | Status di ID                     |
| ------------------------------------------------- | -------------------------------- |
| Widget home screen (saldo + quick action)         | Hampir tidak ada                 |
| Shortcut transaksi favorit (1-tap)                | Tidak ada proper, masih 4-5 step |
| Offline mode untuk lihat saldo/histori            | Tidak ada                        |
| Apple Watch / WearOS support                      | Tidak ada                        |
| Keyboard extension (bayar dari chat)              | Tidak ada. GoPay sudah punya     |
| Deep link ke transaksi spesifik (permalink bukti) | Tidak ada                        |

## 7. Notification Intelligence

| Fitur                                            | Status di ID       |
| ------------------------------------------------ | ------------------ |
| Custom alert threshold ("notif kalau saldo < X") | Hampir tidak ada   |
| Quiet hours non-kritis                           | Tidak ada          |
| Digest mode (rangkum notif harian)               | Tidak ada          |
| Notif kartu dipakai di luar kota/negara          | Tidak ada proaktif |

## 8. Product & Account Management

| Fitur                                          | Status di ID                     |
| ---------------------------------------------- | -------------------------------- |
| Deposito custom tenor                          | Tidak ada                        |
| Auto-rollover deposito dengan kondisi          | Tidak ada                        |
| Giro digital untuk non-enterprise              | Tidak ada                        |
| Credit limit adjustment self-service real-time | Tidak ada                        |
| Soft pull credit score internal                | Bank punya datanya, tidak expose |
| Kartu virtual anak/keluarga dengan limit       | Tidak ada                        |

## 9. Integrasi Ekosistem

| Fitur                                                   | Status di ID                 |
| ------------------------------------------------------- | ---------------------------- |
| Export ke accounting software (Jurnal, Accurate, Xero)  | Tidak ada, manual CSV        |
| Sinkronisasi ke Google/Apple Wallet                     | Tidak ada                    |
| Login with Bank (OAuth, bank sebagai identity provider) | Tidak ada                    |
| Payment link dengan expiry/limit/amount                 | Flip/Xendit bisa, bank belum |
| Invoice native dengan link bayar                        | Tidak ada di consumer/UMKM   |

## 10. Fraud & Dispute

| Fitur                                            | Status di ID             |
| ------------------------------------------------ | ------------------------ |
| Dispute transaksi in-app (tanpa telpon 1500-xxx) | Tidak ada                |
| Temporary block + unblock tanpa ganti kartu      | Sangat jarang            |
| Fraud report dengan tracking status real-time    | Tidak ada                |
| Chargeback management untuk kartu debit          | Tidak ada expose ke user |

## 11. Data & Transparency

| Fitur                                      | Status di ID                                    |
| ------------------------------------------ | ----------------------------------------------- |
| Full transaction history tanpa batas waktu | BCA 3 bulan, Mandiri 6 bulan; sisanya ke cabang |
| Export PDF/CSV dengan filter granular      | Tidak ada proper                                |
| Merchant name yang readable                | Masih raw acquirer string                       |
| Geolocation transaksi (peta)               | Tidak ada                                       |
| Fee breakdown transparan                   | Hidden                                          |

## 12. Transfer & Payment Edge Cases

| Fitur                                                 | Status di ID                  |
| ----------------------------------------------------- | ----------------------------- |
| Scheduled transfer dengan kondisi (if-this-then-that) | Tidak ada                     |
| Transfer ke multiple rekening sekaligus               | Tidak ada di consumer         |
| Request money (kirim tagihan, dibayar langsung)       | Tidak ada. GoPay/OVO punya    |
| Escrow sederhana                                      | Tidak ada                     |
| Transfer terjadwal yang bisa di-edit/cancel           | Inkonsisten                   |
| Notif transfer masuk dengan nama pengirim benar       | Sering tanpa nama / terpotong |

## 13. Personalization & Context

| Fitur                                      | Status di ID      |
| ------------------------------------------ | ----------------- |
| Onboarding adaptif (UMKM/karyawan/pelajar) | Tidak ada         |
| Rekomendasi produk berbasis perilaku nyata | Tidak ada genuine |
| Financial health score yang actionable     | Tidak ada         |
| Perbandingan rate deposito/ORI antar bank  | Tidak ada         |
| Simulasi "what if"                         | Tidak ada         |

## 14. Social & Collaborative Finance

| Fitur                                   | Status di ID          |
| --------------------------------------- | --------------------- |
| Shared account / joint wallet           | Tidak ada di consumer |
| Group savings goal (arisan, patungan)   | Tidak ada native      |
| Contact-based transaction history       | Tidak ada             |
| Approval workflow untuk transaksi besar | Enterprise only       |

## 15. Investment & Wealth

| Fitur                                             | Status di ID             |
| ------------------------------------------------- | ------------------------ |
| Unified portfolio view lintas instrumen           | Tidak ada, fragmentasi   |
| Auto-rebalancing portfolio                        | Tidak ada                |
| Investasi berbasis tujuan dengan tracking         | Wondr BNI mulai, dangkal |
| Tax-loss harvesting / laporan gain-loss untuk SPT | Tidak ada                |
| Fractional bond/SBN (mulai Rp1.000)               | Tidak ada, min Rp1jt     |

## 16. Infrastructure / Developer Layer

| Fitur                                          | Status di ID                    |
| ---------------------------------------------- | ------------------------------- |
| Webhook real-time transaksi                    | Tidak ada untuk personal/UMKM   |
| Personal API token (integrasi Notion, n8n)     | Tidak ada                       |
| Read-only OAuth untuk third-party (aggregator) | SNAP ada, implementasi terbatas |
| Sandbox publik untuk developer                 | Hampir tidak ada yang serius    |

## 17. Regulatory-Adjacent

| Fitur                                            | Status di ID        |
| ------------------------------------------------ | ------------------- |
| SLIK/BI Checking mandiri dari app                | Masih manual ke OJK |
| e-KTP verification self-service                  | Mayoritas ke cabang |
| User-controlled data sharing (untuk KPR/leasing) | Tidak ada           |
| Notif jatuh tempo kewajiban dari semua sumber    | Tidak ada agregasi  |

## 18. Accessibility & Inclusivity

| Fitur                                     | Status di ID                |
| ----------------------------------------- | --------------------------- |
| Voice banking (tunanetra/lansia)          | Tidak ada                   |
| Screen reader proper (TalkBack/VoiceOver) | Mayoritas gagal audit dasar |
| High contrast / large text mode           | Hampir tidak ada            |
| Mode lansia (UI disederhanakan)           | Tidak ada                   |
| Bahasa daerah                             | Tidak ada                   |

## 19. Lifecycle & Edge Cases

| Fitur                                       | Status di ID                                  |
| ------------------------------------------- | --------------------------------------------- |
| Inheritance/estate handling digital         | Tidak ada, manual ke cabang                   |
| Beneficiary designation in-app              | Tidak ada                                     |
| Dormant account self-reactivation           | Ke cabang                                     |
| Account closure self-service                | Hampir semua tidak izinkan (friksi disengaja) |
| Data export saat pindah bank (portabilitas) | Tidak ada, locked-in by design                |
| Account recovery tanpa kartu fisik          | Sangat buruk                                  |

## 20. Sharia-Specific

| Fitur                                        | Status di ID     |
| -------------------------------------------- | ---------------- |
| Zakat calculator + auto-payment              | Sebagian ada     |
| Pemisahan dana halal/syubhat dengan tracking | Tidak ada        |
| Akad transparency per produk                 | Tidak ada        |
| Qurban/wakaf scheduling                      | Tidak ada native |

## 21. CBDC / Crypto / Future Rails

| Fitur                                               | Status di ID                         |
| --------------------------------------------------- | ------------------------------------ |
| Rupiah Digital (CBDC) wallet                        | PoC BI (Proyek Garuda), belum di app |
| Stablecoin/crypto custody                           | Dilarang regulasi saat ini           |
| Programmable money (dana terkategori, misal bansos) | Tidak ada                            |

## 22. Engagement & Retention

| Fitur                                           | Status di ID                    |
| ----------------------------------------------- | ------------------------------- |
| Savings challenge (52-week, no-spend streak)    | Hampir tidak ada                |
| Cashback/rewards unified dengan poin transparan | Fragmentasi, expiry tidak jelas |
| Referral dengan tracking real-time              | Ada, UX buruk                   |
| Financial education kontekstual                 | Tidak ada                       |

## 23. Cash & Physical Layer

| Fitur                                | Status di ID                      |
| ------------------------------------ | --------------------------------- |
| Cardless withdrawal QR/kode dinamis  | Sebagian (BRImo), tidak universal |
| Setor tunai via agen dengan tracking | Terbatas                          |
| ATM locator dengan status real-time  | Locator ada, status tidak         |
| Cash delivery nominal besar          | Tidak ada                         |

## 24. Reliability & Trust

| Aspek                                                | Status di ID               |
| ---------------------------------------------------- | -------------------------- |
| Status page publik (uptime transparan)               | Tidak ada                  |
| Maintenance window diumumkan sebelumnya              | Tidak ada                  |
| Idempotency benar (refresh ≠ double charge)          | Double-debit masih terjadi |
| Graceful degradation (fitur X down ≠ app mati total) | Tidak ada                  |
| In-app incident notification                         | Tidak ada                  |

## 25. Support & Resolution

| Fitur                                     | Status di ID                    |
| ----------------------------------------- | ------------------------------- |
| In-app chat support dengan riwayat        | Chatbot dangkal, eskalasi buruk |
| Ticket tracking dengan SLA visible        | Tidak ada                       |
| Callback request (bank yang telpon balik) | Tidak ada                       |
| Co-browsing (CS lihat layar user)         | Tidak ada                       |

---

## Root Cause — Tiga Pola Akar Masalah

**1. Gap yang bank tidak mau tutup (insentif bertentangan)**
Transparansi fee, FX spread, credit score, portabilitas data, account closure. Bukan masalah teknis — keputusan bisnis. Tidak akan terisi oleh bank itu sendiri.

**2. Gap yang bank tidak mampu tutup cepat (legacy + kultur)**
Open API, webhook, real-time analytics, idempotency, status page. Terhambat core banking tua (Temenos, Finacle) dan tim yang IT-driven, bukan product-driven.

**3. Gap yang regulasi belum jelas**
CBDC, crypto custody, programmable money, identity provider. Menunggu BI/OJK.

### Faktor struktural pendukung

- Insentif terbalik — fitur transparency merugikan revenue
- Warisan legacy core banking sulit iterasi cepat
- Regulasi dipakai sebagai tameng untuk tidak implement
- Oligopoli 4 bank besar → tidak ada urgensi inovasi radikal
- Kultur tim produk lemah, tidak ada "ship fast, iterate"

---

## Implikasi untuk Builder

Kategori (1) dan (2) adalah peluang fintech murni: bangun di atas SNAP API dan isi gap yang bank sengaja atau terpaksa tinggalkan. Model bisnis Flip, Pluang, Finantier, Brick.

**Paling defensible:** agregasi + transparansi + automation — tiga hal yang bank secara struktural tidak akan pernah prioritaskan.

**Paling realistis dibangun di luar bank:** unified portfolio view, recurring payment manager, tax export, request money.

**Gap paling painful (harian):** recurring payment visibility, virtual card per-merchant, dispute in-app.

**Paling underrated tapi high-impact:** Login with Bank (potensi SSO finansial nasional yang lebih trusted dari Google Login).
