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
