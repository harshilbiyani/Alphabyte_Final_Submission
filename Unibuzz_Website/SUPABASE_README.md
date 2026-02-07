# Supabase Backend Architecture: UniBuzz

This document outlines the database schema, storage configuration, and security policies required to power the UniBuzz platform. This setup is designed to support the distinct roles of **Students** and **Organizers**.

## 🗄️ Database Schema

### 1. `profiles`
Stores user identity and role information. Linked to `auth.users`.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `uuid` | Primary Key, references `auth.users.id` |
| `full_name` | `text` | Display name |
| `role` | `text` | 'student' or 'organizer' |
| `avatar_url` | `text` | Path to image in storage |
| `college` | `text` | University/Organization name |
| `skills` | `text[]` | Array of skills (for students) |

### 2. `events`
Core event data managed by organizers.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `uuid` | Primary Key |
| `organizer_id` | `uuid` | FK to `profiles.id` |
| `title` | `text` | Event Name |
| `description` | `text` | |
| `start_time` | `timestamptz` | |
| `end_time` | `timestamptz` | |
| `mode` | `text` | 'Online', 'In-person', 'Hybrid' |
| `is_team_event` | `boolean` | |
| `min_team_size` | `int` | |
| `max_team_size` | `int` | |
| `status` | `text` | 'Draft', 'Published', 'Live', 'Completed' |

### 3. `registrations`
Tracks user participation in events.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `uuid` | Primary Key |
| `event_id` | `uuid` | FK to `events.id` |
| `user_id` | `uuid` | FK to `profiles.id` |
| `status` | `text` | 'Registered', 'Checked-in', 'Cancelled' |
| `check_in_time` | `timestamptz` | Timestamp of QR scan |
| `team_id` | `uuid` | FK to `teams.id` (Nullable) |

### 4. `teams`
Manages groups for team-based events.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `uuid` | Primary Key |
| `event_id` | `uuid` | FK to `events.id` |
| `name` | `text` | Team Name |
| `team_code` | `text` | Unique join code |
| `leader_id` | `uuid` | FK to `profiles.id` |

### 5. `certificates`
Stores metadata for issued certificates.

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `uuid` | Primary Key |
| `event_id` | `uuid` | FK to `events.id` |
| `recipient_id` | `uuid` | FK to `profiles.id` |
| `ipfs_hash` | `text` | Blockchain verification hash (Future) |
| `image_url` | `text` | URL to generated certificate image |
| `issued_at` | `timestamptz` | |

---

## 🪣 Storage Buckets

1.  **`event-covers`**:
    *   **Usage**: Stores banner images for event listings.
    *   **Public Access**: True.
2.  **`user-avatars`**:
    *   **Usage**: Profile pictures for students and club logos.
    *   **Public Access**: True.
3.  **`certificates`**:
    *   **Usage**: Stores the generated PDF/Image certificates.
    *   **Public Access**: True (Read-only for verified recipients).

---

## 🛡️ Row Level Security (RLS) Policies

### Profiles
*   **Public Read**: Anyone can read basic profile info.
*   **Self Update**: Users can only update their own profile.

### Events
*   **Public Read**: Everyone can see 'Published' events.
*   **Organizer Full Access**: Organizers can CRUD *their own* events (`auth.uid() == organizer_id`).

### Registrations
*   **Student Create**: Authenticated students can insert a registration for themselves.
*   **Organizer Read**: Organizers can view all registrations for their events.

---

## ⚡ Key Queries / Functions

### `get_organizer_stats(organizer_id)`
A database function to aggregate metrics for the dashboard:
*   Count total events.
*   Sum total registrations across all events.
*   Calculate average attendance rate.

### `verify_team_constraints()`
A trigger function on the `registrations` table to prevent joining a team if it exceeds `events.max_team_size`.
