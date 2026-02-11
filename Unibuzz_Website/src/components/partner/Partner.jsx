import React, { useEffect } from 'react';
import { useUser } from '../../context/UserContext';
import Navbar from '../home/Navbar';
import PartnerOrganizer from './PartnerOrganizer';
import PartnerStudent from './PartnerStudent';
import PartnerCorporate from './PartnerCorporate';
import { motion, AnimatePresence } from 'framer-motion';

const Partner = () => {
  const { currentUser } = useUser();

  // Determine user type (Default to student if not logged in or unknown)
  // Safely access user type with optional chaining
  const userType = currentUser?.type || 'student';

  const renderContent = () => {
    switch (userType) {
      case 'organizer':
        return <PartnerOrganizer />;
      case 'corporate':
      case 'sponsor':
        return <PartnerCorporate />;
      case 'student':
      default:
        return <PartnerStudent />;
    }
  };

  return (
    <>
      <Navbar />
      <AnimatePresence mode="wait">
        <motion.div
           key={userType} // Force re-render on type change
           initial={{ opacity: 0 }}
           animate={{ opacity: 1 }}
           exit={{ opacity: 0 }}
           transition={{ duration: 0.5 }}
        >
          {renderContent()}
        </motion.div>
      </AnimatePresence>
    </>
  );
};

export default Partner;
