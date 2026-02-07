import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import {
    ArrowRight, Mail, Lock, Target, Award, BarChart2,
    Calendar, Briefcase, Megaphone, ChevronLeft, User, Building, DollarSign, Zap
} from 'lucide-react';
import { useUser } from '../../context/UserContext';
import logo from '../../assets/mylogo.png';

const GenZBackground = () => (
   <div className="absolute inset-0 overflow-hidden pointer-events-none">
       {/* Animated Gradient Blobs */}
       <motion.div 
         animate={{ 
             scale: [1, 1.2, 1],
             rotate: [0, 90, 0],
             opacity: [0.3, 0.5, 0.3]
         }}
         transition={{ duration: 10, repeat: Infinity, ease: "linear" }}
         className="absolute -top-1/2 -left-1/2 w-[100%] h-[100%] bg-ubViolet/30 rounded-full blur-[100px]"
       />
       <motion.div 
         animate={{ 
             scale: [1, 1.5, 1],
             x: [0, 100, 0],
             opacity: [0.2, 0.4, 0.2]
         }}
         transition={{ duration: 15, repeat: Infinity, ease: "easeInOut" }}
         className="absolute bottom-0 right-0 w-[80%] h-[80%] bg-ubLime/20 rounded-full blur-[120px]"
       />

       {/* Floating Elements */}
       {[...Array(5)].map((_, i) => (
           <motion.div
                key={i}
                initial={{ y: "110vh", x: Math.random() * 100 + "%", rotate: 0 }}
                animate={{ y: "-10vh", rotate: 360 }}
                transition={{ 
                    duration: Math.random() * 10 + 20, 
                    repeat: Infinity, 
                    ease: "linear",
                    delay: Math.random() * 5
                }}
                className="absolute text-7xl opacity-10 font-black text-white mix-blend-overlay select-none"
           >
               {['⚡', '🌐', '🚀', '🔥', '💎'][i]}
           </motion.div>
       ))}
   </div>
);

const LoginPage = () => {
    const navigate = useNavigate();
    const { login } = useUser();
    const [selectedRole, setSelectedRole] = useState(null); // 'organizer', 'corporate', 'sponsor'

    const handleLogin = (e) => {
        e.preventDefault();
        // Simulating login data - in real app would come from form
        login({ type: selectedRole, name: 'Demo User' });
        navigate('/home');
    };

    const roles = [
        {
            id: 'organizer',
            title: 'Organizer',
            subtitle: 'For Clubs & Universities',
            description: 'Manage events, track attendance & issue certificates.',
            icon: Calendar,
            color: 'text-ubLime',
            borderColor: 'group-hover:border-ubLime',
            gradient: 'from-ubLime/20 to-transparent'
        },
        {
            id: 'corporate',
            title: 'Corporate',
            subtitle: 'For Businesses & Recruiters',
            description: 'Connect with top talent & host hackathons.',
            icon: Briefcase,
            color: 'text-ubViolet',
            borderColor: 'group-hover:border-ubViolet',
            gradient: 'from-ubViolet/20 to-transparent'
        },
        {
            id: 'sponsor',
            title: 'Sponsors',
            subtitle: 'For Brands & Partners',
            description: 'Boost brand visibility & sponsor campus events.',
            icon: Megaphone,
            color: 'text-cyan-400',
            borderColor: 'group-hover:border-cyan-400',
            gradient: 'from-cyan-400/20 to-transparent'
        }
    ];

    return (
        <div className="min-h-screen flex bg-black font-sans overflow-hidden relative">

            {/* --- CENTRAL LIGHTNING DIVIDER --- */}
            <div className="hidden lg:flex absolute left-1/2 top-0 bottom-0 w-[1px] bg-zinc-800 -translate-x-1/2 z-50 items-center justify-center">
                <div className="relative">
                    <div className="absolute inset-0 bg-ubLime/50 blur-xl rounded-full"></div>
                    <div className="bg-black p-4 rounded-full border-2 border-ubLime relative z-10 shadow-[0_0_30px_rgba(198,255,51,0.3)]">
                        <Zap size={40} className="text-ubLime animate-pulse" fill="currentColor" />
                    </div>
                    {/* Vertical Thunder Line Extension */}
                    <div className="absolute top-full left-1/2 -translate-x-1/2 w-0.5 h-[50vh] bg-gradient-to-b from-ubLime to-transparent opacity-50"></div>
                    <div className="absolute bottom-full left-1/2 -translate-x-1/2 w-0.5 h-[50vh] bg-gradient-to-t from-ubLime to-transparent opacity-50"></div>
                </div>
            </div>

            {/* --- Left Side (50%) - Brand and Animation --- */}
            <div className="hidden lg:flex w-1/2 relative flex-col justify-center items-center p-16 bg-[#050505] overflow-hidden">

                {/* Background Animation */}
                <GenZBackground />

                <div className="relative z-10 flex flex-col items-center text-center">

                    {/* Logo Animation */}
                    <div className="relative mb-8 flex flex-col items-center">
                        <motion.div
                            initial={{ scale: 0.8, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            className="w-40 h-40 bg-zinc-900 rounded-3xl border border-white/10 flex items-center justify-center relative z-20 shadow-2xl overflow-hidden mb-6"
                        >
                            <img src={logo} alt="UniBuzz Logo" className="w-full h-full object-cover" />
                        </motion.div>

                        {/* UniBuzz Text */}
                        <motion.h1 
                            initial={{ y: 20, opacity: 0 }}
                            animate={{ y: 0, opacity: 1 }}
                            className="text-4xl font-black tracking-tighter text-white"
                        >
                            UniBuzz
                        </motion.h1>

                        <motion.div
                            animate={{ rotate: 360 }}
                            transition={{ duration: 10, repeat: Infinity, ease: "linear" }}
                            className="absolute top-20 left-1/2 -translate-x-1/2 -translate-y-1/2 w-56 h-56 border border-dashed border-white/20 rounded-full z-10 pointer-events-none"
                        />
                        <motion.div
                            animate={{ rotate: -360 }}
                            transition={{ duration: 15, repeat: Infinity, ease: "linear" }}
                            className="absolute top-20 left-1/2 -translate-x-1/2 -translate-y-1/2 w-72 h-72 border border-white/5 rounded-full z-0 pointer-events-none"
                        />
                    </div>

                    <h1 className="text-5xl font-bold text-white mb-2 leading-tight">
                        <span className="text-ubLime">Unified</span> Campus
                    </h1>
                    <h1 className="text-5xl font-bold text-white mb-6 leading-tight">
                        Events <span className="text-ubViolet">Fabric</span>
                    </h1>

                    <p className="text-gray-400 text-lg mb-12 max-w-md">
                        The ultimate ecosystem connecting Organizers, Corporates, and Sponsors.
                    </p>

                    <div className="flex gap-4">
                        <Badge icon={Target} text="Precise Targeting" />
                        <Badge icon={Award} text="Top Talent" />
                        <Badge icon={BarChart2} text="Real ROI" />
                    </div>
                </div>
            </div>

            {/* --- Right Side (50%) - Role Selection & Forms --- */}
            <div className="w-full lg:w-1/2 flex flex-col justify-center px-8 lg:px-24 relative bg-black">
                <div className="max-w-md w-full mx-auto relative min-h-[500px]">
                    <AnimatePresence mode="wait">

                        {/* VIEW 1: ROLE SELECTION */}
                        {!selectedRole ? (
                            <motion.div
                                key="selection"
                                initial={{ opacity: 0, x: 20 }}
                                animate={{ opacity: 1, x: 0 }}
                                exit={{ opacity: 0, x: -20 }}
                                className="w-full"
                            >
                                <h2 className="text-3xl font-bold text-white mb-2">Who are you?</h2>
                                <p className="text-gray-500 mb-8">Choose your role to access the portal.</p>

                                <div className="space-y-4">
                                    {roles.map((role) => (
                                        <motion.div
                                            key={role.id}
                                            whileHover={{ scale: 1.02, x: 5 }}
                                            whileTap={{ scale: 0.98 }}
                                            onClick={() => setSelectedRole(role.id)}
                                            className={`group relative p-6 bg-zinc-900/50 border border-white/10 rounded-2xl cursor-pointer transition-all hover:bg-zinc-900 overflow-hidden`}
                                        >
                                            <div className={`absolute inset-0 bg-gradient-to-r ${role.gradient} opacity-0 group-hover:opacity-100 transition-opacity duration-500`} />
                                            <div className="relative flex items-center gap-5">
                                                <div className={`w-12 h-12 rounded-xl bg-black/50 border border-white/10 flex items-center justify-center ${role.color} shadow-lg`}>
                                                    <role.icon size={24} />
                                                </div>
                                                <div className="flex-1">
                                                    <h3 className="text-xl font-bold text-white mb-1 flex items-center gap-2">
                                                        {role.title} <ArrowRight size={16} className={`opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all ${role.color}`} />
                                                    </h3>
                                                    <p className="text-xs font-bold uppercase tracking-wider text-gray-500 mb-1">{role.subtitle}</p>

                                                </div>
                                            </div>
                                        </motion.div>
                                    ))}
                                </div>
                            </motion.div>
                        ) : (

                            /* VIEW 2: LOGIN/SIGNUP FORMS */
                            <motion.div
                                key="form"
                                initial={{ opacity: 0, x: 20 }}
                                animate={{ opacity: 1, x: 0 }}
                                exit={{ opacity: 0, x: -20 }}
                                className="w-full"
                            >
                                {/* Back Button */}
                                <button
                                    onClick={() => setSelectedRole(null)}
                                    className="flex items-center gap-2 text-gray-500 hover:text-white mb-6 transition-colors group"
                                >
                                    <ChevronLeft size={18} className="group-hover:-translate-x-1 transition-transform" />
                                    <span className="text-sm font-bold uppercase tracking-wide">Change Role</span>
                                </button>

                                <div className="mb-8">
                                    <h2 className="text-3xl font-bold text-white mb-2 flex items-center gap-3">
                                        Log in as <span className={`${roles.find(r => r.id === selectedRole).color}`}>{roles.find(r => r.id === selectedRole).title}</span>
                                    </h2>
                                    <p className="text-gray-500">Enter your credentials to access the dashboard.</p>
                                </div>

                                <form onSubmit={handleLogin} className="space-y-5">

                                    {/* Email */}
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-500 uppercase tracking-wider">Email Address</label>
                                        <div className="relative group">
                                            <Mail className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-white transition-colors" size={20} />
                                            <input
                                                type="email"
                                                className="w-full bg-zinc-900 border border-white/10 rounded-xl py-3.5 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubViolet focus:ring-1 focus:ring-ubViolet transition-all placeholder:text-gray-600"
                                                placeholder="name@organization.com"
                                            />
                                        </div>
                                    </div>

                                    {/* Conditional Fields based on Role (simulated 'Signup' flow merge for demo) */}
                                    {selectedRole === 'organizer' && (
                                        <div className="space-y-2">
                                            <label className="text-xs font-bold text-gray-500 uppercase tracking-wider">University / Club Name</label>
                                            <div className="relative group">
                                                <User className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-white transition-colors" size={20} />
                                                <input type="text" className="w-full bg-zinc-900 border border-white/10 rounded-xl py-3.5 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubViolet focus:ring-1 focus:ring-ubViolet transition-all placeholder:text-gray-600" placeholder="Ex: ACM Student Chapter" />
                                            </div>
                                        </div>
                                    )}

                                    {selectedRole === 'corporate' && (
                                        <div className="space-y-2">
                                            <label className="text-xs font-bold text-gray-500 uppercase tracking-wider">Company Name</label>
                                            <div className="relative group">
                                                <Building className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-white transition-colors" size={20} />
                                                <input type="text" className="w-full bg-zinc-900 border border-white/10 rounded-xl py-3.5 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubViolet focus:ring-1 focus:ring-ubViolet transition-all placeholder:text-gray-600" placeholder="Ex: Tech Solutions Inc." />
                                            </div>
                                        </div>
                                    )}

                                    {selectedRole === 'sponsor' && (
                                        <div className="space-y-2">
                                            <label className="text-xs font-bold text-gray-500 uppercase tracking-wider">Brand Name</label>
                                            <div className="relative group">
                                                <DollarSign className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-white transition-colors" size={20} />
                                                <input type="text" className="w-full bg-zinc-900 border border-white/10 rounded-xl py-3.5 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubViolet focus:ring-1 focus:ring-ubViolet transition-all placeholder:text-gray-600" placeholder="Ex: Red Bull" />
                                            </div>
                                        </div>
                                    )}

                                    {/* Password */}
                                    <div className="space-y-2">
                                        <div className="flex justify-between items-center">
                                            <label className="text-xs font-bold text-gray-500 uppercase tracking-wider">Password</label>
                                            <a href="#" className="text-xs text-ubViolet font-bold hover:text-white transition-colors">Forgot?</a>
                                        </div>
                                        <div className="relative group">
                                            <Lock className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 group-focus-within:text-white transition-colors" size={20} />
                                            <input
                                                type="password"
                                                className="w-full bg-zinc-900 border border-white/10 rounded-xl py-3.5 pl-12 pr-4 text-white font-medium focus:outline-none focus:border-ubViolet focus:ring-1 focus:ring-ubViolet transition-all placeholder:text-gray-600"
                                                placeholder=""
                                            />
                                        </div>
                                    </div>

                                    {/* Sign In Button */}
                                    <button
                                        type="submit"
                                        className="w-full py-4 bg-white hover:bg-ubLime hover:text-black text-black font-bold rounded-xl text-lg flex items-center justify-center gap-2 transition-all hover:scale-[1.02] shadow-lg mt-4"
                                    >
                                        Log In <ArrowRight size={20} />
                                    </button>
                                </form>

                                <div className="mt-8 text-center text-sm">
                                    <p className="text-gray-500">New here? <span className="text-white font-bold cursor-pointer hover:underline">Create an Organization Account</span></p>
                                </div>
                            </motion.div>
                        )}
                    </AnimatePresence>
                </div>
            </div>
        </div>
    );
};

const Badge = ({ icon: Icon, text }) => (
    <div className="flex items-center gap-2 px-4 py-2 bg-white/5 rounded-full border border-white/10 backdrop-blur-sm">
        <Icon size={14} className="text-gray-400" />
        <span className="text-xs font-bold text-gray-300">{text}</span>
    </div>
);

export default LoginPage;
