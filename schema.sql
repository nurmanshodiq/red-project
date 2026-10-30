-- RED Project database schema for Supabase (PostgreSQL)
-- Jalankan di Supabase Dashboard > SQL Editor.
-- Semua tabel memiliki owner_id dan RLS agar tiap akun hanya mengakses datanya sendiri.

create extension if not exists pgcrypto;

create table if not exists public.clients (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 name text not null,
 organization text,
 phone text,
 email text,
 notes text,
 created_at timestamptz not null default now()
);

create table if not exists public.events (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 name text not null,
 client_name text,
 event_date date not null,
 start_time time,
 location text,
 status text not null default 'Terjadwal' check (status in ('Terjadwal','DP Dibayar','Berlangsung','Selesai','Dibatalkan','Lunas')),
 contract_value numeric(14,2) not null default 0 check (contract_value >= 0),
 notes text,
 created_at timestamptz not null default now()
);

create table if not exists public.equipment (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 name text not null,
 category text,
 quantity integer not null default 1 check (quantity >= 0),
 status text not null default 'Tersedia' check (status in ('Tersedia','Dipakai','Perawatan')),
 notes text,
 created_at timestamptz not null default now()
);

create table if not exists public.transactions (
 id uuid primary key default gen_random_uuid(),
 owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 kind text not null check (kind in ('Masuk','Keluar')),
 description text not null,
 category text,
 amount numeric(14,2) not null check (amount > 0),
 transaction_date date not null default current_date,
 project_name text,
 notes text,
 created_at timestamptz not null default now()
);

alter table public.clients enable row level security;
alter table public.events enable row level security;
alter table public.equipment enable row level security;
alter table public.transactions enable row level security;

-- Policy aman per pengguna. Jalankan ulang schema di proyek baru; jika mengulang pada tabel
-- lama, hapus policy bernama sama terlebih dahulu bila Supabase memberi duplicate-policy error.
create policy "clients_select_own" on public.clients for select to authenticated using (owner_id = auth.uid());
create policy "clients_insert_own" on public.clients for insert to authenticated with check (owner_id = auth.uid());
create policy "clients_update_own" on public.clients for update to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "clients_delete_own" on public.clients for delete to authenticated using (owner_id = auth.uid());

create policy "events_select_own" on public.events for select to authenticated using (owner_id = auth.uid());
create policy "events_insert_own" on public.events for insert to authenticated with check (owner_id = auth.uid());
create policy "events_update_own" on public.events for update to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "events_delete_own" on public.events for delete to authenticated using (owner_id = auth.uid());

create policy "equipment_select_own" on public.equipment for select to authenticated using (owner_id = auth.uid());
create policy "equipment_insert_own" on public.equipment for insert to authenticated with check (owner_id = auth.uid());
create policy "equipment_update_own" on public.equipment for update to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "equipment_delete_own" on public.equipment for delete to authenticated using (owner_id = auth.uid());

create policy "transactions_select_own" on public.transactions for select to authenticated using (owner_id = auth.uid());
create policy "transactions_insert_own" on public.transactions for insert to authenticated with check (owner_id = auth.uid());
create policy "transactions_update_own" on public.transactions for update to authenticated using (owner_id = auth.uid()) with check (owner_id = auth.uid());
create policy "transactions_delete_own" on public.transactions for delete to authenticated using (owner_id = auth.uid());

grant select, insert, update, delete on public.clients, public.events, public.equipment, public.transactions to authenticated;
