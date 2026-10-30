# RED Project — Web App Manajemen Usaha Live Streaming

Aplikasi web responsif berbahasa Indonesia untuk pemilik usaha live streaming. Frontend HTML/CSS/JavaScript, autentikasi dan database cloud memakai Supabase.

## Fitur
- Login dan pendaftaran akun email/password.
- Dashboard ringkasan proyek, klien, pemasukan, pengeluaran, dan saldo kas.
- CRUD jadwal/proyek, data klien, inventaris peralatan/tim, dan transaksi.
- Update status proyek langsung.
- Pencarian tabel, laporan ringkas, ekspor transaksi CSV, cetak laporan.
- Supabase Row Level Security (RLS): setiap pengguna hanya dapat mengakses baris miliknya.

## Prasyarat
- Akun Supabase.
- Hosting statis seperti Netlify, Vercel, GitHub Pages, atau server web sendiri.
- Browser modern dengan koneksi internet.

## Cara menjalankan
1. Buat proyek baru di https://supabase.com/.
2. Buka **SQL Editor** di dashboard Supabase, salin seluruh isi `schema.sql`, lalu jalankan.
3. Di **Project Settings → API** (atau bagian Data API), salin Project URL dan **anon/publishable key**. Jangan gunakan `service_role`/secret key di browser.
4. Jalankan lokal: buka folder ini di terminal dan jalankan `python -m http.server 8080`, lalu buka `http://localhost:8080`. Bisa juga buka `index.html` langsung, tetapi server lokal lebih disarankan.
5. Masukkan Project URL dan anon/publishable key pada layar awal aplikasi.
6. Buat akun, konfirmasi email jika diminta, lalu masuk. Data baru akan tersimpan di database cloud.
7. Untuk mengakses dari perangkat lain, deploy `index.html` ke hosting statis yang memakai HTTPS, lalu gunakan URL yang sama dari HP/laptop. Konfigurasi Supabase dimasukkan di browser masing-masing.

## Deploy statis
- **Netlify**: drag-and-drop folder berisi `index.html` ke Netlify Drop.
- **Vercel**: impor repo Git berisi `index.html`, gunakan preset static/other, tanpa build command.
- Unggah `index.html`; file `schema.sql` dan README tidak perlu dipublikasikan ke situs.

## Keamanan penting
- `anon`/publishable key memang dapat berada di frontend; keamanan harus ditegakkan oleh RLS. Jangan pernah memasukkan `service_role` key ke aplikasi browser.
- Schema mengaktifkan RLS dan membatasi CRUD berdasarkan `auth.uid()`.
- Supabase Auth email confirmation bisa aktif secara default. Jika aktif, konfirmasi email sebelum login.
- Lindungi akun dengan kata sandi kuat dan aktifkan kebijakan autentikasi sesuai kebutuhan.
- Untuk produksi, tambahkan backup terjadwal, kebijakan privasi, validasi server-side untuk aturan bisnis penting, log audit, dan pengujian akses lintas akun.

## Keterbatasan versi awal
Website RED Project
- Aplikasi ini adalah MVP siap dikembangkan, bukan sistem akuntansi bersertifikat.
- Data klien pada proyek disimpan sebagai teks nama klien; relasi foreign-key ke tabel klien dan histori kontrak dapat ditambahkan di iterasi berikutnya.
- Belum ada invoice PDF, tanda tangan kontrak, notifikasi WhatsApp/email, sinkronisasi Google Calendar, pembagian peran kru, unggah bukti transfer, atau multi-currency.
- Saldo kas dihitung dari transaksi yang dicatat; bukan laba akuntansi otomatis. Nilai kontrak tidak otomatis dianggap sebagai pemasukan sampai transaksi dicatat.
- Konfigurasi URL/key disimpan di localStorage tiap browser. Setiap perangkat perlu memasukkannya satu kali.
- Data contoh tidak disediakan. Buat akun dan masukkan data asli sendiri.
