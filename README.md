# UniBuzz: The Unified Campus Events Fabric

## 🚀 Project Overview
**Unibuzz** is a next-generation campus engagement platform designed to bridge the gap between student organizers and the student body. It serves as a digital nervous system for campus life, streamlining event creation, discovery, participation, and certification.

We address the fragmentation in campus activities where students miss out on opportunities and organizers struggle with logistics, attendance, and verifying achievements.

## 💡 Core Solution
Our platform provides two distinct but integrated experiences:
1.  **For Organizers (Web Dashboard):** A powerful command center to manage the entire lifecycle of an event—from creation and team formation to live attendance tracking and automated blockchain-verified certificate issuance.
2.  **For Students (Mobile App & Web):** A seamless interface to discover events, register with one click, form teams, and build a verified portfolio of co-curricular achievements.

---

## ✨ Key Features by User Segment

### 🎓 For Students (The "Buzz" Experience)
*   **One-Tap Registration:** No more repetitive Google Forms. Sign up instantly with your profile.
*   **Team Formation:** Find teammates for hackathons or group events dynamically.
*   **Live Event Feed:** A Gen-Z styled, high-energy feed of what's happening now (Marquee, Circular Carousel).
*   **Smart Portfolio:** All certificates and participation records are stored in a digital wallet.
*   **Mobile App:** A dedicated mobile application focused purely on the student experience for real-time updates and QR check-ins.

### 🏛️ For Organizers & Clubs (The "Command Center")
*   **Event Lifecycle Management:** rigorous control over scheduling, registration deadlines, and venue management.
*   **Smart Cert Studio:** Drag-and-drop certificate designer that auto-generates PDFs for thousands of participants.
*   **Attendance Tracking:** Integrated QR code scanner and manual attendance fallback.
*   **Analytics Dashboard:** Real-time insights on registration numbers, attendance rates, and team compositions.
*   **Pre-Event Validation:** Built-in checks (e.g., Team Size restrictions, mandatory fields) to ensure smooth operations.

---

## 🛠️ Tech Stack

### Frontend & Design
*   **Framework:** React 18 (Vite)
*   **Styling:** Tailwind CSS (Custom "Neo-Brutalist" & "Dark Mode" Theme)
*   **Animations:** Framer Motion (Complex scroll animations, marquees, transitions)
*   **Icons:** Lucide React

### Core Utilities
*   **Certificate Generation:** `html2canvas`, `jspdf`
*   **Routing:** React Router DOM
*   **State Management:** React Context API (UserContext)

### Mobile App (Student Focused)
*   **Platform:** Dedicated mobile experience ensuring students have their event passes in their pocket.

---

## 📂 Project Structure Summary

```
Alphabyte_final_website-/
├── src/
│   ├── components/
│   │   ├── auth/           # Login & Splash Screens
│   │   ├── common/         # Reusable UI (Marquees, Buttons)
│   │   ├── features/       # Core Logic modules
│   │   │   ├── organizer/  # Dashboard, Smart Cert Studio, Analytics
│   │   │   └── ...         # Feature landing pages
│   │   ├── home/           # Landing Page Components (Hero, Carousel)
│   │   └── orbit/          # Community/Space features
│   ├── context/            # Global State (User Roles)
│   └── assets/             # Static Assets
├── index.html              # Entry point
├── tailwind.config.js      # Design Token Configuration
└── vite.config.js          # Build Configuration
```

---

## 🔮 Future Roadmap (Supabase Integration)
We are transitioning to a robust backend using Supabase. Please refer to `SUPABASE_README.md` for the architectural blueprint of our database, storage, and security policies.


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
