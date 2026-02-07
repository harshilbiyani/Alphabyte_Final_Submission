import { Menu, X, Zap, User, Settings, LogOut, Edit3, Rocket } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { Link, useNavigate } from 'react-router-dom';
import { useUser } from '../../context/UserContext';
import React, { useState } from 'react';

const Navbar = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [showProfile, setShowProfile] = useState(false);
  const { currentUser, logout, listings } = useUser();
  const navigate = useNavigate();

  const handleLogout = () => {
      logout();
      navigate('/login');
  };

  // Determine nav links based on role
  let navLinks = [];

  if (currentUser?.type === 'sponsor') {
    navLinks = [
        { name: 'Home', href: '/home' },
        { name: 'About UniBuzz', href: '/about' },
        { name: 'Events', href: '/sponsor-events' },
        { name: 'Clubs', href: '/clubs' },
        { name: 'Requirement Listing', href: '/requirements' },
        { name: 'Partner with Us', href: '/partner' },
    ];
  } else if (currentUser?.type === 'corporate') {
     navLinks = [
         { name: 'Home', href: '/home' },
         { name: 'About UniBuzz', href: '/about' },
         { name: 'Orbit', href: '/orbit', icon: Rocket },
         { name: 'Clubs', href: '/clubs' },
         { name: 'Partner with Us', href: '/partner' },
     ];
  } else if (currentUser?.type === 'organizer') {
    navLinks = [
        { name: 'Home', href: '/home' },
        { name: 'About UniBuzz', href: '/about' },
        { name: 'My Events', href: '/organizer-dashboard' },
        { name: 'Clubs', href: '/clubs' },
        { name: 'BuzzPerks', href: '/buzz-perks', special: true }, // Added BuzzPerks
        { name: 'Features', href: '/features' },
        { name: 'Partner with Us', href: '/partner' },
    ];
  } else {
    navLinks = [
        { name: 'Home', href: '/home' },
        { name: 'About UniBuzz', href: '/about' },
        { name: 'Events', href: '#events' },
        { name: 'Features', href: '/features' },
        { name: 'Partner with Us', href: '/partner' },
    ];
  }

  const getProfileImage = () => {
      // Different seeds based on role for fun
      const seed = currentUser?.type === 'corporate' ? 'Business' : currentUser?.type === 'sponsor' ? 'Brand' : 'Felix';
      return `https://api.dicebear.com/7.x/avataaars/svg?seed=${seed}`;
  };

  return (
    <>
        <nav className="fixed top-0 left-0 w-full z-50 px-6 py-6 md:px-10">
        <div className="max-w-7xl mx-auto">
            <div className="bg-ubBlack/80 backdrop-blur-xl border border-white/10 rounded-3xl px-8 py-4 flex items-center justify-between shadow-[0_8px_32px_rgba(0,0,0,0.5)]">
            
            {/* Logo (Top Left) */}
            <div className="flex items-center gap-2">
                <div className="bg-ubLime text-black p-1.5 rounded-lg -rotate-6 shadow-[0_0_15px_rgba(198,255,51,0.5)]">
                    <Zap size={22} fill="black" /> 
                </div>
                <span className="text-white font-black text-2xl tracking-tighter">Uni<span className="text-ubViolet">Buzz</span></span>
            </div>

            {/* Desktop Nav Links (Center) */}
            <div className="hidden md:flex items-center space-x-8">
                {navLinks.map((link) => (
                    link.href.startsWith('#') ? (
                        <a 
                            key={link.name} 
                            href={link.href}
                            className="text-white/70 hover:text-ubLime font-semibold text-sm uppercase tracking-wide transition-all hover:scale-110"
                        >
                            {link.name}
                        </a>
                    ) : (
                        <Link 
                            key={link.name} 
                            to={link.href}
                            className={`font-semibold text-sm uppercase tracking-wide transition-all hover:scale-110 flex items-center gap-1.5 ${link.special ? 'text-ubViolet font-bold animate-pulse' : 'text-white/70 hover:text-ubLime'}`}
                        >
                            {link.special && <Zap size={14} className="fill-current" />}
                            {link.name}
                        </Link>
                    )
                ))}
            </div>

            {/* Right Side: Profile Icon */}
            <div className="flex items-center gap-4 relative">
                {/* Mobile Menu Toggle */}
                <div className="md:hidden">
                    <button 
                    onClick={() => setIsOpen(!isOpen)}
                    className="text-white hover:text-ubLime transition-colors p-2"
                    >
                    {isOpen ? <X size={28} /> : <Menu size={28} />}
                    </button>
                </div>

                {/* Profile Button */}
                <div className="relative">
                    <button 
                        onClick={() => setShowProfile(true)}
                        className="w-10 h-10 rounded-full bg-white/10 hover:bg-ubViolet hover:scale-105 transition-all flex items-center justify-center border border-white/20 overflow-hidden"
                    >
                        <img 
                            src={getProfileImage()} 
                            alt="Profile" 
                            className="w-full h-full object-cover"
                        />
                    </button>
                </div>
            </div>
            </div>
        </div>

        {/* Mobile Menu Dropdown */}
        <AnimatePresence>
            {isOpen && (
            <motion.div 
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: 'auto' }}
                exit={{ opacity: 0, height: 0 }}
                className="fixed top-24 left-6 right-6 z-40 md:hidden bg-ubBlack/90 backdrop-blur-md border border-white/10 rounded-2xl overflow-hidden"
            >
                <div className="p-6 flex flex-col space-y-4">
                    {navLinks.map((link) => (
                        link.href.startsWith('#') ? (
                            <a 
                                key={link.name} 
                                href={link.href}
                                className="text-white text-lg font-bold hover:text-ubLime transition-colors"
                                onClick={() => setIsOpen(false)}
                            >
                                {link.name}
                            </a>
                        ) : (
                          <Link
                              key={link.name}
                              to={link.href}
                              className={`text-lg font-bold transition-colors ${link.special ? 'text-ubViolet animate-pulse' : 'text-white hover:text-ubLime'}`}
                              onClick={() => setIsOpen(false)}
                          >
                             <div className="flex items-center gap-2">
                                {link.name}
                                {link.special && <Zap size={16} fill="currentColor" />}
                             </div>
                          </Link>
                        )
                    ))}
                </div>
            </motion.div>
            )}
        </AnimatePresence>
        </nav>

        {/* --- FULL SCREEN PROFILE MODAL --- */}
        <AnimatePresence>
            {showProfile && (
                <div className="fixed inset-0 z-[100] flex items-center justify-center px-4">
                    {/* Backdrop */}
                    <motion.div 
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        onClick={() => setShowProfile(false)}
                        className="absolute inset-0 bg-black/60 backdrop-blur-sm"
                    />

                    {/* Modal Content */}
                    <motion.div 
                        initial={{ opacity: 0, scale: 0.8, y: 50 }}
                        animate={{ opacity: 1, scale: 1, y: 0 }}
                        exit={{ opacity: 0, scale: 0.8, y: 50 }}
                        transition={{ type: "spring", damping: 25, stiffness: 300 }}
                        className="relative w-full max-w-lg bg-[#121212] border border-white/10 rounded-3xl shadow-[0_0_50px_rgba(125,57,235,0.3)] p-8 overflow-hidden"
                    >
                        {/* Close Button */}
                        <button 
                            onClick={() => setShowProfile(false)}
                            className="absolute top-4 right-4 text-gray-400 hover:text-white hover:bg-white/10 p-2 rounded-full transition-colors"
                        >
                            <X size={24} />
                        </button>

                        {/* Decorative Background blob */}
                        <div className="absolute -top-20 -right-20 w-64 h-64 bg-ubLime/10 rounded-full blur-[80px] pointer-events-none" />
                        <div className="absolute -bottom-20 -left-20 w-64 h-64 bg-ubViolet/10 rounded-full blur-[80px] pointer-events-none" />

                        <div className="relative z-10 flex flex-col items-center text-center">
                            <div className="relative">
                                <div className="w-32 h-32 mx-auto rounded-full p-1 border-4 border-ubLime border-dashed mb-6 shadow-lg shadow-ubLime/20">
                                    <img 
                                        src={getProfileImage()} 
                                        alt="User" 
                                        className="w-full h-full rounded-full bg-gray-800 object-cover"
                                    />
                                </div>
                                <div className="absolute bottom-6 right-2 bg-ubViolet text-white p-1.5 rounded-full border-2 border-[#121212]">
                                    <Zap size={16} fill="white" />
                                </div>
                            </div>
                            
                            <h3 className="text-3xl font-black text-white mb-1">{currentUser?.name || "Guest User"}</h3>
                            <p className="text-ubViolet font-mono text-sm tracking-wide mb-8 uppercase">
                                {currentUser?.type || "Explorer Mode"}
                            </p>
                            
                            <div className="grid grid-cols-3 gap-4 w-full mb-8">
                                <div className="bg-white/5 p-4 rounded-2xl hover:bg-white/10 transition-colors">
                                    <div className="text-2xl font-black text-white">12</div>
                                    <div className="text-xs text-gray-500 font-bold uppercase tracking-wider mt-1">Events</div>
                                </div>
                                <div className="bg-white/5 p-4 rounded-2xl hover:bg-white/10 transition-colors">
                                    <div className="text-2xl font-black text-white">850</div>
                                    <div className="text-xs text-gray-500 font-bold uppercase tracking-wider mt-1">Points</div>
                                </div>
                                <div className="bg-white/5 p-4 rounded-2xl hover:bg-white/10 transition-colors">
                                    <div className="text-2xl font-black text-ubLime">Top 5%</div>
                                    <div className="text-xs text-gray-500 font-bold uppercase tracking-wider mt-1">Rank</div>
                                </div>
                            </div>

                            {/* About User Segment */}
                            <div className="w-full text-left bg-white/5 border border-white/5 p-5 rounded-2xl mb-6 relative group overflow-hidden">
                                <div className="absolute top-0 left-0 w-1 h-full bg-ubLime/50 group-hover:bg-ubLime transition-colors"></div>
                                <h4 className="text-gray-400 text-xs font-bold uppercase tracking-widest mb-2 flex items-center gap-2">
                                    <span className="w-2 h-2 rounded-full bg-ubLime"></span> About Me
                                </h4>
                                <p className="text-gray-300 text-sm leading-relaxed font-medium">
                                    "Level 42. Building the future of campus culture. "
                                </p>
                            </div>

                            {/* Sponsor Listings (Only for Sponsors) */}
                            {currentUser?.type === 'sponsor' && listings && listings.length > 0 && (
                                <div className="w-full text-left mb-6">
                                    <h4 className="text-ubViolet text-xs font-bold uppercase tracking-widest mb-3">Your Listings</h4>
                                    <div className="space-y-2 max-h-40 overflow-y-auto pr-1 custom-scrollbar">
                                        {listings.map((item, idx) => (
                                            <div key={idx} className="bg-white/5 p-3 rounded-xl border border-white/5 flex items-center justify-between">
                                                <div>
                                                    <div className="text-sm font-bold text-white">{item.eventType}</div>
                                                    <div className="text-xs text-gray-500 capitalize">{item.sponsorshipType}</div>
                                                </div>
                                                <div className="px-2 py-1 bg-ubLime/20 text-ubLime text-[10px] font-bold rounded-lg border border-ubLime/30">
                                                    ACTIVE
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            )}

                            <Link 
                                to="/profile" 
                                onClick={() => setShowProfile(false)}
                                className="w-full py-4 bg-white text-black text-lg font-bold rounded-xl hover:bg-ubLime hover:scale-[1.02] transition-all flex items-center justify-center gap-2 mb-3 shadow-lg"
                            >
                                <User size={18} /> View Full Profile
                            </Link>
                            
                            <button 
                                onClick={handleLogout}
                                className="w-full py-4 bg-transparent border border-white/10 text-red-500 font-medium rounded-xl hover:bg-red-500/10 hover:border-red-500 transition-all flex items-center justify-center gap-2 text-sm"
                            >
                                <LogOut size={18} /> Sign Out
                            </button>
                        </div>
                    </motion.div>
                </div>
            )}
        </AnimatePresence>
    </>
  );
};

export default Navbar;
