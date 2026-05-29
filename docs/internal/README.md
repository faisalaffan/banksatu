# Dokumen Internal

Folder ini dienkripsi via git-crypt. Hanya collaborator dengan GPG key terdaftar yang bisa membaca isinya.

## Yang disimpan di sini

- Product requirements & keputusan arsitektur
- Analisis kompetitor & strategi diferensiasi
- Roadmap detail dengan timeline spesifik
- Strategi go-to-market yang belum publik
- Data early user (sebelum anonimisasi)
- Kontrak & dokumen legal

## Yang TIDAK disimpan di sini

- Secrets & credentials → `.env` (gitignored)
- Dokumen publik → `docs/` (tidak dienkripsi)

## Setup untuk collaborator baru

```bash
# 1. Kirim GPG public key ke repo owner
gpg --armor --export your@email.com > pubkey.asc

# 2. Owner menambahkan key
git-crypt add-gpg-user [KEY_ID]

# 3. Collaborator unlock setelah clone
git-crypt unlock
```

## Verifikasi

```bash
git-crypt status
# docs/internal/* → encrypted ✓
```
