# KonsulIn

Sistem Informasi Pengajuan dan Penjadwalan Konsultasi Akademik Mahasiswa Berbasis Web.

Proyek tugas kuliah Rekayasa Perangkat Lunak, Program Studi Ilmu Komputer, FMIPA, Universitas Halu Oleo. Dosen pengampu: Ilham Julian Efendi, S.T., M.T.

## Tentang proyek

KonsulIn membantu mahasiswa melihat informasi dan jadwal dosen, mengajukan konsultasi akademik, serta memantau status dan riwayat konsultasi. Dosen mengelola jadwal dan merespons pengajuan. Admin mengelola data dan akun, serta memantau aktivitas sistem.

| Peran | Yang boleh dilakukan |
|---|---|
| Mahasiswa | Melihat informasi dan jadwal dosen, mengajukan konsultasi, melihat status, menerima notifikasi, melihat riwayat |
| Dosen | Mengelola jadwal, melihat pengajuan, menerima/menolak pengajuan, memberi alternatif jadwal, melihat riwayat |
| Admin | Mengelola data mahasiswa, data dosen, akun pengguna, dan memantau aktivitas sistem (tidak menyetujui konsultasi) |

Acuan kebutuhan: dokumen RPL 1.docx (KF-01 sampai KF-16, UC-01 sampai UC-15).

## Teknologi

- Python Flask
- HTML, CSS, JavaScript
- MySQL
- Git dan GitHub
- Tema antarmuka: hitam, putih, dan abu-abu

## Tim

| Nama | Peran |
|---|---|
| Muh Fikri Ar Rayyan | Scrum Master |
| Israwati | Product Owner |
| Marwa Faiqatuizzihni Alya.S | Developer 1 (login, logout, register, reset kata sandi) |
| La Ode Subun | Developer 2 (data mahasiswa/dosen, akun admin, monitoring, jadwal dan info dosen) |
| Ni Made Santi Wardani | Developer 3 (pengajuan, persetujuan, alternatif jadwal, notifikasi, riwayat) |

## Cara menjalankan di komputer sendiri

Prasyarat: Python 3, Git, dan MySQL (bisa lewat Laragon).

1. Clone repository:

   ```bash
   git clone https://github.com/fikriarrayyan/TUBES_RPL.git
   cd TUBES_RPL
   ```

2. Buat dan aktifkan virtual environment:

   ```bash
   python -m venv venv
   venv\Scripts\activate
   ```

   (Mac/Linux: `source venv/bin/activate`)

3. Pasang dependensi:

   ```bash
   pip install -r requirements.txt
   ```

4. Siapkan database MySQL dan atur konfigurasi lewat file `.env` (nama variabel mengikuti `config.py` / `.env.example`). **Jangan commit file `.env`.**

5. Jalankan aplikasi:

   ```bash
   python app.py
   ```

   Lalu buka alamat yang tampil di terminal (umumnya http://127.0.0.1:5000).

> Catatan: langkah 4 akan dilengkapi setelah skema database disepakati tim.

## Alur kerja Git

Jangan commit langsung ke `main`. Setiap fitur memakai branch sendiri dan masuk lewat Pull Request.

```bash
git switch main
git pull origin main
git switch -c feature/nama-fitur
# kerjakan dan uji fitur
git add .
git commit -m "feat: deskripsi singkat"
git push -u origin feature/nama-fitur
```

Lalu buat Pull Request ke `main` dan jelaskan: ID KF/UC yang dikerjakan, ringkasan perubahan, cara menjalankan, dan hasil pengujian. Product Owner atau reviewer memeriksa sebelum digabung.

Contoh nama branch: `feature/auth-register-nim`, `feature/auth-login`, `feature/admin-data-mahasiswa`, `feature/konsultasi-pengajuan`, `fix/validasi-jadwal`.

## Aturan keamanan

- Jangan commit `.env`, password database, password SMTP, secret key, atau token.
- Jangan memasukkan data pribadi mahasiswa sungguhan ke repository.
- Kata sandi pengguna disimpan sebagai hash, bukan teks biasa.

## Dokumentasi

Daftar pekerjaan (backlog) dan acceptance criteria dikelola di tab **Issues** repository ini, satu issue untuk satu user story (US-01 sampai US-19).

## Status

Dalam pengembangan.
