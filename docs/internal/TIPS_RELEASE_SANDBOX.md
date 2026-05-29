Untuk rilis app perbankan (banking) di App Store dan Play Store meski backend-nya sandbox, ada beberapa constraint yang perlu kamu pahami sebelum lanjut.

---

## Risiko & Constraint Utama

### App Store (Apple)
- Apple **sangat ketat** untuk kategori Finance. Mereka akan mereview apakah app-mu bisa disalahgunakan untuk menipu user.
- Jika app *terlihat* seperti banking app nyata tapi datanya palsu/sandbox, Apple bisa reject dengan alasan **misleading users** (Guideline 4.3 — Spam, atau 5.2.1 — misleading functionality).
- Kamu harus jelas di deskripsi bahwa ini **demo/educational/open-source sandbox app**, bukan layanan finansial nyata.
- Category yang aman: **Finance > Personal Finance** atau bahkan **Developer Tools / Education**.

### Play Store (Google)
- Lebih longgar tapi tetap punya **Financial Services Policy**.
- App yang mensimulasikan banking tanpa lisensi OJK/BI bisa di-flag jika dianggap menyesatkan.
- Wajib ada **disclaimer jelas** bahwa ini bukan layanan finansial real.

---

## Yang Harus Kamu Lakukan

### 1. Branding & Deskripsi
- Jangan gunakan nama yang mirip bank sungguhan.
- Judul harus jelas: misal `"BankDemo - Open Source Sandbox"` atau `"[AppName] Banking Simulator"`.
- Deskripsi wajib menyebutkan: *"This app connects to a sandbox API. No real money or financial data is involved."*

### 2. UI Disclaimer
- Tampilkan **banner/watermark** di dalam app: `"SANDBOX MODE — Not a real banking service"`.
- Ini juga melindungi kamu secara legal jika ada user yang salah paham.

### 3. Tidak Ada Credential Nyata
- Pastikan app tidak meminta data perbankan nyata (nomor rekening nyata, PIN, dll).
- Jika ada flow login, gunakan test credential yang jelas fake.

### 4. Open Source Declaration
- Sertakan link ke repo GitHub di deskripsi store.
- Ini membantu reviewer memahami intent-nya: educational/demonstrasi.

---

## Risiko Legal (Indonesia)

- **OJK Regulation**: Kalau app kelihatan seperti layanan pembayaran/banking, bisa kena POJK tentang fintech. Sandbox + disclaimer yang jelas biasanya cukup untuk menghindari ini.
- **BI SNAP / PBI**: Tidak berlaku karena tidak ada transaksi nyata.

---

## Rekomendasi

| Aspek | Rekomendasi |
|---|---|
| App category | Education atau Finance (dengan disclaimer) |
| Nama app | Sertakan kata "Demo", "Sandbox", atau "OSS" |
| In-app | Watermark SANDBOX di setiap screen finansial |
| Backend | Pastikan endpoint sandbox tidak bisa diswitch ke production dari client |
| Privacy Policy | Wajib ada, meski sandbox — ini syarat kedua store |
| Age rating | 4+ / Everyone (karena tidak ada transaksi nyata) |

---

**Intinya bisa dirilis**, asal framing-nya jelas sebagai demo/educational/open-source tool, bukan layanan finansial. Masalah terbesar biasanya di review Apple, bukan Google. Kalau kamu mau, saya bisa bantu draft teks deskripsi store atau disclaimer in-app-nya.