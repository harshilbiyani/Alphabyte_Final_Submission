-- UniBuzz Supabase Schema Setup
-- Run this in the Supabase SQL Editor to set up your tables and triggers correctly.

-- 1. Create the public.users table
create table if not exists public.users (
  id uuid not null primary key references auth.users(id) on delete cascade,
  email_verified boolean default false,
  full_name text,
  prn text,
  program text,
  pass_out_year int,
  role text default 'student',
  interests text[], -- Storing interests as an array of strings
  bio text,
  avatar_url text,
  created_at timestamptz default now()
);

-- 2. Enable Row Level Security (RLS)
alter table public.users enable row level security;

-- 3. Create Policies
-- Allow users to view their own profile (and potentially others for social features)
create policy "Public profiles are viewable by everyone."
  on public.users for select
  using ( true );

-- Allow users to update their own profile
create policy "Users can insert their own profile."
  on public.users for insert
  with check ( auth.uid() = id );

create policy "Users can update own profile."
  on public.users for update
  using ( auth.uid() = id );

-- 4. Function to handle new user signup (Trigger)
-- This automatically inserts a row into public.users when a user signs up.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.users (
    id, 
    name, 
    prn, 
    dob, 
    mobile, 
    college_email, 
    personal_email, 
    department, 
    division, 
    current_semester, 
    pass_out_year, 
    role, 
    interests
  )
  values (
    new.id,
    new.raw_user_meta_data->>'name',
    new.raw_user_meta_data->>'prn',
    (new.raw_user_meta_data->>'dob')::date,
    new.raw_user_meta_data->>'mobile',
    new.raw_user_meta_data->>'college_email',
    new.raw_user_meta_data->>'personal_email',
    new.raw_user_meta_data->>'department',
    new.raw_user_meta_data->>'division',
    (new.raw_user_meta_data->>'current_semester')::int,
    (new.raw_user_meta_data->>'pass_out_year')::int,
    coalesce(new.raw_user_meta_data->>'role', 'student'),
    ARRAY(
      SELECT jsonb_array_elements_text(
        CASE
          WHEN jsonb_typeof(new.raw_user_meta_data->'interests') = 'array' 
          THEN new.raw_user_meta_data->'interests' 
          ELSE '[]'::jsonb 
        END
      )
    )
  );
  return new;
exception
  when others then
    -- Log the error to Postgres logs so we can debug
    raise warning 'handle_new_user trigger failed: %', SQLERRM;
    return new; 
end;
$$;

-- 5. Create the trigger
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
