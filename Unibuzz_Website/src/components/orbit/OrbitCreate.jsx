import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { 
    Rocket, Target, Briefcase, MapPin, DollarSign, Clock, 
    Send, User, ChevronRight, Sparkles 
} from 'lucide-react';
import { useUser } from '../../context/UserContext';
import Navbar from '../home/Navbar';

const OrbitCreate = () => {
    const navigate = useNavigate();
    const { addListing, currentUser } = useUser();
    
    // Default to empty strings to avoid uncontrolled input warnings
    const [formData, setFormData] = useState({
        companyName: currentUser?.name || '',
        recruiterName: '',
        roleTitle: '',
        location: '',
        stipend: '',
        description: '',
    });

    const [activeType, setActiveType] = useState('internship');

    const roleTypes = [
        { id: 'internship', label: 'Internship', icon: Clock },
        { id: 'fulltime', label: 'Full Time', icon: Briefcase },
        { id: 'freelance', label: 'Freelance', icon: Sparkles },
        { id: 'project', label: 'Project', icon: Target },
    ];

    const handleSubmit = (e) => {
        e.preventDefault();
        const newOpportunity = {
            id: Date.now(),
            ...formData,
            type: activeType,
            category: 'orbit',
            date: new Date().toLocaleDateString(),
            status: 'Active'
        };
        addListing(newOpportunity); 
        navigate('/orbit');
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
                        <Rocket className="animate-pulse" />
                        <span className="font-mono tracking-widest uppercase text-sm">Orbit Launchpad</span>
                    </div>
                    
                    <h1 className="text-5xl md:text-7xl font-black tracking-tighter leading-[0.9] mb-8">
                        LAUNCH <br/>
                        YOUR <br/>
                        <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet">MISSION.</span>
                    </h1>

                    <p className="text-gray-400 text-lg leading-relaxed mb-8 border-l-4 border-ubLime pl-6">
                        Scout the best talent. We connect your opportunities with the most ambitious students in the ecosystem.
                    </p>

                    <div className="hidden md:block p-6 rounded-3xl bg-white/5 border border-white/10 backdrop-blur-md">
                        <h3 className="font-bold text-xl mb-4 text-white">Why Launch here?</h3>
                        <ul className="space-y-4">
                            <li className="flex items-start gap-3">
                                <div className="mt-1 w-2 h-2 rounded-full bg-ubLime" />
                                <div className="flex flex-col">
                                    <span className="text-white font-bold text-sm">Top 1% Talent</span>
                                    <span className="text-gray-400 text-xs">Access pre-vetted student developers.</span>
                                </div>
                            </li>
                            <li className="flex items-start gap-3">
                                <div className="mt-1 w-2 h-2 rounded-full bg-ubViolet" />
                                <div className="flex flex-col">
                                    <span className="text-white font-bold text-sm">AI Matching</span>
                                    <span className="text-gray-400 text-xs">Our algorithms find the perfect fit.</span>
                                </div>
                            </li>
                            <li className="flex items-start gap-3">
                                <div className="mt-1 w-2 h-2 rounded-full bg-cyan-400" />
                                <div className="flex flex-col">
                                    <span className="text-white font-bold text-sm">Fast Track</span>
                                    <span className="text-gray-400 text-xs">Close positions in under 48 hours.</span>
                                </div>
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
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Organization</label>
                                    <div className="relative group">
                                        <Briefcase className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="text" 
                                            value={formData.companyName}
                                            onChange={(e) => setFormData({...formData, companyName: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="Company Name"
                                        />
                                    </div>
                                </div>
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Recruiter Name</label>
                                    <div className="relative group">
                                        <User className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="text" 
                                            value={formData.recruiterName}
                                            onChange={(e) => setFormData({...formData, recruiterName: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="Your Name"
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* Section 2: Role Details */}
                        <div className="mb-12">
                            <h2 className="text-2xl font-bold mb-6 flex items-center gap-3">
                                <span className="flex items-center justify-center w-8 h-8 rounded-full bg-white/10 text-sm font-mono">02</span>
                                The Role
                            </h2>
                            
                            {/* Type Selection */}
                            <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1 mb-4 block">Engagement Type</label>
                            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-8">
                                {roleTypes.map((type) => (
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

                            <div className="grid md:grid-cols-2 gap-6 mb-6">
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Role Title</label>
                                    <div className="relative group">
                                        <Target className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="text" 
                                            value={formData.roleTitle}
                                            onChange={(e) => setFormData({...formData, roleTitle: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="Ex: Frontend Engineer"
                                        />
                                    </div>
                                </div>
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Location</label>
                                    <div className="relative group">
                                        <MapPin className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                        <input 
                                            required
                                            type="text" 
                                            value={formData.location}
                                            onChange={(e) => setFormData({...formData, location: e.target.value})}
                                            className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                            placeholder="Remote, Bangalore..."
                                        />
                                    </div>
                                </div>
                            </div>

                            <div className="space-y-2">
                                <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Stipend / CTC</label>
                                <div className="relative group">
                                    <DollarSign className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-ubLime transition-colors" size={18} />
                                    <input 
                                        required
                                        type="text" 
                                        value={formData.stipend}
                                        onChange={(e) => setFormData({...formData, stipend: e.target.value})}
                                        className="w-full bg-black/40 border border-white/10 rounded-2xl py-4 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700"
                                        placeholder="Ex: 20k/month or 12LPA"
                                    />
                                </div>
                            </div>
                        </div>

                        {/* Section 3: Description */}
                        <div className="mb-12">
                             <h2 className="text-2xl font-bold mb-6 flex items-center gap-3">
                                <span className="flex items-center justify-center w-8 h-8 rounded-full bg-white/10 text-sm font-mono">03</span>
                                The Details
                            </h2>
                            <div className="space-y-2">
                                <label className="text-xs font-bold text-gray-500 uppercase tracking-wider pl-1">Job Description</label>
                                <textarea 
                                    required
                                    rows={5}
                                    value={formData.description}
                                    onChange={(e) => setFormData({...formData, description: e.target.value})}
                                    className="w-full bg-black/40 border border-white/10 rounded-2xl p-4 text-white font-medium focus:outline-none focus:border-ubLime focus:ring-1 focus:ring-ubLime transition-all placeholder:text-gray-700 resize-none"
                                    placeholder="Describe the role, requirements, and perks..."
                                />
                            </div>
                        </div>

                        {/* Submit Actions */}
                        <div className="flex items-center justify-between pt-8 border-t border-white/10">
                            <button 
                                type="button" 
                                onClick={() => navigate('/orbit')}
                                className="text-gray-500 hover:text-white font-medium transition-colors"
                            >
                                Cancel
                            </button>
                            <motion.button 
                                whileHover={{ scale: 1.05 }}
                                whileTap={{ scale: 0.95 }}
                                type="submit"
                                className="bg-ubLime text-black px-8 py-4 rounded-xl font-bold flex items-center gap-2 hover:bg-ubLime/90 transition-colors shadow-[0_0_20px_rgba(198,255,51,0.4)]"
                            >
                                Launch Opportunity <Send size={18} />
                            </motion.button>
                        </div>

                    </form>
                </motion.div>
            </div>
        </div>
    );
};

export default OrbitCreate;
