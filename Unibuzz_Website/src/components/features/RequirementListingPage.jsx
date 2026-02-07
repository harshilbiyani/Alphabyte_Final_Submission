import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { 
    Zap, DollarSign, Gift, Coffee, Pizza, Shirt, MapPin, Video, 
    Send, Briefcase, Calendar, Mail, User, ChevronRight 
} from 'lucide-react';
import { useUser } from '../../context/UserContext';
import Navbar from '../home/Navbar';

const RequirementListingPage = () => {
    const navigate = useNavigate();
    const { addListing, currentUser } = useUser();
    
    // Redirect if not sponsor (optional, but good UX)
    // if (currentUser?.type !== 'sponsor') return <Navigate to="/home" />;

    const [formData, setFormData] = useState({
        sponsorName: currentUser?.name || '',
        sponsorshipType: '',
        eventType: '',
        contactName: '',
        email: '',
        budget: '', // Optional extra
    });

    const [activeType, setActiveType] = useState(null);

    const sponsorshipTypes = [
        { id: 'monetary', label: 'Monetary', icon: DollarSign },
        { id: 'non-monetary', label: 'In-Kind', icon: Gift },
        { id: 'beverage', label: 'Beverage', icon: Coffee },
        { id: 'food', label: 'Food', icon: Pizza },
        { id: 'merch', label: 'Merch', icon: Shirt },
        { id: 'venue', label: 'Venue', icon: MapPin },
        { id: 'media', label: 'Media', icon: Video },
    ];

    const handleSubmit = (e) => {
        e.preventDefault();
        const newListing = {
            id: Date.now(),
            ...formData,
            sponsorshipType: activeType,
            date: new Date().toLocaleDateString(),
            status: 'Active'
        };
        addListing(newListing);
        // Show success or redirect? Let's just navigate to home or show profile
        // For now, let's navigate to home so they can open their profile
        navigate('/home'); 
        // Or optimally, trigger the profile modal open from context if we could, 
        // but for now simple navigation is safe.
    };

    return (
        <div className="min-h-screen bg-black text-white font-sans selection:bg-ubLime selection:text-black">
            <Navbar />
            
            <div className="relative pt-32 pb-20 px-6 max-w-7xl mx-auto flex flex-col md:flex-row gap-16 items-start">
                
                {/* Background Blobs */}
                <div className="fixed top-20 right-0 w-[500px] h-[500px] bg-ubViolet/20 rounded-full blur-[120px] pointer-events-none" />
                <div className="fixed bottom-0 left-0 w-[500px] h-[500px] bg-ubLime/10 rounded-full blur-[120px] pointer-events-none" />

                {/* Left Side: Header & Context */}
                <motion.div 
                    initial={{ opacity: 0, x: -50 }}
                    animate={{ opacity: 1, x: 0 }}
                    className="md:w-1/3 md:sticky md:top-32"
                >
                    <div className="flex items-center gap-3 text-ubLime mb-6">
                        <Zap className="animate-pulse" />
                        <span className="font-mono tracking-widest uppercase text-sm">Sponsor Protocol</span>
                    </div>
                    
                    <h1 className="text-5xl md:text-7xl font-black tracking-tighter leading-[0.9] mb-8">
                        DROP <br/>
                        YOUR <br/>
                        <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet">REQS.</span>
                    </h1>

                    <p className="text-gray-400 text-lg leading-relaxed mb-8 border-l-4 border-ubLime pl-6">
                        Define your terms. We match you with the highest impact campus events that align with your brand ethos.
                    </p>

                    <div className="hidden md:block p-6 rounded-3xl bg-white/5 border border-white/10 backdrop-blur-md">
                        <h3 className="font-bold text-xl mb-4 text-white">Why List?</h3>
                        <ul className="space-y-4">
                            <li className="flex items-start gap-3">
                                <div className="mt-1 w-2 h-2 rounded-full bg-ubLime" />
                                <span className="text-gray-400 text-sm">Direct access to 500+ University Clubs</span>
                            </li>
                            <li className="flex items-start gap-3">
                                <div className="mt-1 w-2 h-2 rounded-full bg-ubViolet" />
                                <span className="text-gray-400 text-sm">AI-Matched Event Proposals</span>
                            </li>
                            <li className="flex items-start gap-3">
                                <div className="mt-1 w-2 h-2 rounded-full bg-cyan-400" />
                                <span className="text-gray-400 text-sm">Automated ROI Tracking</span>
                            </li>
                        </ul>
                    </div>
                </motion.div>

                {/* Right Side: The Form */}
                <motion.div 
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.2 }}
                    className="md:w-2/3 w-full"
                >
                    <form onSubmit={handleSubmit} className="relative bg-zinc-900/40 backdrop-blur-xl border border-white/10 p-8 md:p-12 rounded-[2.5rem] shadow-[0_0_50px_rgba(0,0,0,0.5)] overflow-hidden">
                        
                        {/* Decorative shimmer */}
                        <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-ubLime via-ubViolet to-ubLime opacity-50" />

                        {/* Section 1: Basic Info */}
                        <div className="mb-12">
                            <h2 className="text-2xl font-bold mb-6 flex items-center gap-3">
                                <span className="flex items-center justify-center w-8 h-8 rounded-full bg-white/10 text-sm font-mono">01</span>
                                Identity
                            </h2>
                            <div className="grid md:grid-cols-2 gap-6">
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Sponsor Name</label>
                                    <div className="relative group">
                                        <Briefcase className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="text" 
                                            value={formData.sponsorName}
                                            onChange={(e) => setFormData({...formData, sponsorName: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="Your Brand Name"
                                        />
                                    </div>
                                </div>
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Authorized Contact</label>
                                    <div className="relative group">
                                        <User className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="text" 
                                            value={formData.contactName}
                                            onChange={(e) => setFormData({...formData, contactName: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="Who to call?"
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* Section 2: Sponsorship Details */}
                        <div className="mb-12">
                            <h2 className="text-2xl font-bold mb-6 flex items-center gap-3">
                                <span className="flex items-center justify-center w-8 h-8 rounded-full bg-white/10 text-sm font-mono">02</span>
                                The Offer
                            </h2>
                            
                            {/* Type Selection Grid */}
                            <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1 mb-4 block">Sponsorship Type</label>
                            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-8">
                                {sponsorshipTypes.map((type) => (
                                    <motion.button
                                        key={type.id}
                                        type="button"
                                        whileTap={{ scale: 0.95 }}
                                        onClick={() => setActiveType(type.id)}
                                        className={`relative p-4 rounded-2xl border flex flex-col items-center justify-center gap-2 transition-all duration-300 ${
                                            activeType === type.id 
                                            ? 'bg-ubLime/20 border-ubLime text-white shadow-[0_0_20px_rgba(198,255,51,0.2)]' 
                                            : 'bg-white/5 border-white/5 text-gray-400 hover:bg-white/10 hover:border-white/20'
                                        }`}
                                    >
                                        <type.icon size={24} className={activeType === type.id ? 'text-ubLime' : 'text-gray-500'} />
                                        <span className="text-xs font-bold">{type.label}</span>
                                    </motion.button>
                                ))}
                            </div>

                            <div className="grid md:grid-cols-2 gap-6">
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Ideally for Event Type</label>
                                    <div className="relative group">
                                        <Calendar className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="text" 
                                            value={formData.eventType}
                                            onChange={(e) => setFormData({...formData, eventType: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="Ex: Hackathon, Music Fest..."
                                        />
                                    </div>
                                </div>
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Email ID</label>
                                    <div className="relative group">
                                        <Mail className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="email" 
                                            value={formData.email}
                                            onChange={(e) => setFormData({...formData, email: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="official@brand.com"
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* Submit Action */}
                        <div className="pt-8 border-t border-white/10 flex items-center justify-between">
                            <p className="text-xs text-gray-500 max-w-[200px]">By submitting, you agree to our <span className="text-white underline cursor-pointer">Partner Terms</span>.</p>
                            <button 
                                type="submit"
                                disabled={!activeType || !formData.sponsorName}
                                className="px-8 py-4 bg-ubLime text-black font-black text-lg rounded-2xl hover:scale-105 hover:shadow-[0_0_30px_rgba(198,255,51,0.4)] disabled:opacity-50 disabled:hover:scale-100 transition-all flex items-center gap-2"
                            >
                                PUBLISH LISTING <Send size={20} />
                            </button>
                        </div>

                    </form>
                </motion.div>
            </div>
        </div>
    );
};

export default RequirementListingPage;
