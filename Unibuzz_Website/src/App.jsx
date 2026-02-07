import React, { useState } from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { UserProvider } from './context/UserContext';
import SplashScreen from './components/auth/SplashScreen';
import LoginPage from './components/auth/LoginPage';
import HomePage from './components/home/HomePage';
import FeaturesPage from './components/features/FeaturesPage';
import RequirementListingPage from './components/features/RequirementListingPage';
import ClubsPage from './components/features/ClubsPage';
import ClubPortfolioPage from './components/features/ClubPortfolioPage';
import SponsorEventsPage from './components/features/SponsorEventsPage';
import OrganizerDashboard from './components/features/OrganizerDashboard';
import CertificateManagement from './components/features/CertificateManagement';
import ProfilePage from './components/features/ProfilePage';
import AboutPage from './components/home/AboutPage';
import ReportGenerator from './components/features/organizer/ReportGenerator';
import CsvIntelligence from './components/features/organizer/CsvIntelligence';
import FinanceHub from './components/features/organizer/FinanceHub';
import LiveLifecycle from './components/features/organizer/LiveLifecycle';
import SmartCertificates from './components/features/organizer/SmartCertificates';
import SmartCertStudio from './components/features/organizer/SmartCertStudio';
import BuzzPerksPage from './components/features/organizer/BuzzPerksPage'; // Added

import OrbitDashboard from './components/orbit/OrbitDashboard';
import OrbitCreate from './components/orbit/OrbitCreate';
import OrbitApplicants from './components/orbit/OrbitApplicants';
import Partner from './components/partner/Partner';

function App() {
  const [loading, setLoading] = useState(true);

  if (loading) {
    return <SplashScreen onComplete={() => setLoading(false)} />;
  }

  return (
    <UserProvider>
      <Router>
        <Routes>
          <Route path="/" element={<Navigate to="/login" replace />} />
          <Route path="/login" element={<LoginPage />} />
          <Route path="/home" element={<HomePage />} />
          <Route path="/features" element={<FeaturesPage />} />
          <Route path="/features/report-generator" element={<ReportGenerator />} />
          <Route path="/features/csv-intelligence" element={<CsvIntelligence />} />
          <Route path="/features/finance-hub" element={<FinanceHub />} />
          <Route path="/features/live-lifecycle" element={<LiveLifecycle />} />
          <Route path="/features/smart-certificates" element={<SmartCertificates />} />
          <Route path="/features/smart-cert-studio" element={<SmartCertStudio />} />
          
          {/* Orbit Routes (Corporate Only) */}
          <Route path="/orbit" element={<OrbitDashboard />} />
          <Route path="/orbit/create" element={<OrbitCreate />} />
          <Route path="/orbit/applicants/:id" element={<OrbitApplicants />} />

          {/* Partner Route */}
          <Route path="/partner" element={<Partner />} />
          
          <Route path="/partner" element={<HomePage />} />
          <Route path="/requirements" element={<RequirementListingPage />} />
          <Route path="/clubs" element={<ClubsPage />} />
          <Route path="/clubs/:id" element={<ClubPortfolioPage />} />
          <Route path="/sponsor-events" element={<SponsorEventsPage />} />
          <Route path="/organizer-dashboard" element={<OrganizerDashboard />} />
          <Route path="/certificates" element={<CertificateManagement />} />
          {/* BuzzPerks Route */}
          <Route path="/buzz-perks" element={<BuzzPerksPage />} />
          <Route path="/profile" element={<ProfilePage />} />
          <Route path="/about" element={<AboutPage />} />
        </Routes>
      </Router>
    </UserProvider>
  );
}

export default App;
