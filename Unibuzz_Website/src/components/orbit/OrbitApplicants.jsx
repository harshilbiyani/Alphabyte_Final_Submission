import React, { useState } from 'react';
import Navbar from '../home/Navbar';
import { motion, AnimatePresence } from 'framer-motion';
import { ArrowLeft, Check, X, Star, Github, Linkedin, Mail, FileText, MoreHorizontal, Download } from 'lucide-react';
import { useNavigate, useParams } from 'react-router-dom';

const APPLICANTS = [
    { id: 1, name: "Arjun Reddy", role: "Frontend Dev", match: 92, skills: ["React", "Three.js", "Tailwind"], github: "arjuncode", portfolio: "arjun.dev" },
    { id: 2, name: "Sophia Li", role: "UI/UX Designer", match: 85, skills: ["Figma", "Spline", "Prototyping"], github: "sophdes", portfolio: "sophia.design" },
    { id: 3, name: "Rohan Das", role: "Backend Engineer", match: 78, skills: ["Node.js", "Postgres", "AWS"], github: "rohandev", portfolio: "rohan.tech" },
];

const OrbitApplicants = () => {
    const navigate = useNavigate();
    const { id } = useParams();
    const [currentIndex, setCurrentIndex] = useState(0);
    const [direction, setDirection] = useState(0);

    const handleSwipe = (dir) => {
        setDirection(dir);
        setTimeout(() => {
            setCurrentIndex(prev => prev + 1);
            setDirection(0);
        }, 300);
    };

    const currentApplicant = APPLICANTS[currentIndex];

    return (
        <div className="min-h-screen bg-black text-white selection:bg-indigo-500/30 overflow-hidden">
            <Navbar />
            
            <div className="pt-24 px-6 container mx-auto h-[calc(100vh-100px)] flex flex-col">
                
                {/* Header */}
                <div className="flex justify-between items-center mb-8">
                    <button onClick={() => navigate('/orbit')} className="flex items-center gap-2 text-zinc-500 hover:text-white transition-colors">
                        <ArrowLeft size={20} /> Back to Dashboard
                    </button>
                    <div className="flex gap-3">
                        <button className="px-4 py-2 bg-zinc-900 border border-zinc-800 rounded-full text-zinc-400 hover:text-white transition-colors text-sm font-bold flex items-center gap-2">
                            <Download size={16} /> Export CSV
                        </button>
                    </div>
                </div>

                {/* Main Content Area */}
                <div className="flex-1 flex flex-col items-center justify-center relative">
                    
                    {currentIndex < APPLICANTS.length ? (
                        <div className="relative w-full max-w-md h-[600px] -mt-20">
                            <AnimatePresence>
                                <motion.div
                                    key={currentApplicant.id}
                                    initial={{ scale: 0.95, opacity: 0, y: 20 }}
                                    animate={{ 
                                        scale: 1, 
                                        opacity: 1, 
                                        y: 0, 
                                        x: direction * 500, 
                                        rotate: direction * 20 
                                    }}
                                    exit={{ opacity: 0, scale: 0.9 }}
                                    transition={{ duration: 0.4 }}
                                    className="absolute inset-0 bg-zinc-900 border border-zinc-800 rounded-[3rem] p-8 shadow-2xl flex flex-col items-center text-center overflow-hidden"
                                >
                                    {/* Match Score Badge */}
                                    <div className="absolute top-8 right-8 w-12 h-12 rounded-full border-4 border-zinc-800 flex items-center justify-center font-bold text-xs bg-emerald-500/20 text-emerald-400">
                                        {currentApplicant.match}%
                                    </div>

                                    <div className="w-32 h-32 rounded-full bg-gradient-to-br from-indigo-500 to-fuchsia-500 mb-6 p-1">
                                        <div className="w-full h-full bg-black rounded-full flex items-center justify-center text-3xl font-bold">
                                            {currentApplicant.name.charAt(0)}
                                        </div>
                                    </div>

                                    <h2 className="text-3xl font-black mb-1">{currentApplicant.name}</h2>
                                    <p className="text-zinc-500 font-medium mb-6">{currentApplicant.role}</p>

                                    <div className="flex gap-2 mb-8 flex-wrap justify-center">
                                        {currentApplicant.skills.map(skill => (
                                            <span key={skill} className="px-3 py-1 rounded-full bg-zinc-800 text-zinc-300 text-xs font-bold border border-zinc-700">
                                                {skill}
                                            </span>
                                        ))}
                                    </div>

                                    <div className="flex gap-4 mb-4 w-full justify-center">
                                        <button className="w-12 h-12 rounded-full bg-zinc-800 flex items-center justify-center hover:bg-white hover:text-black transition-colors"><Github size={20}/></button>
                                        <button className="w-12 h-12 rounded-full bg-zinc-800 flex items-center justify-center hover:bg-[#0077b5] hover:text-white transition-colors"><Linkedin size={20}/></button>
                                        <button className="w-12 h-12 rounded-full bg-zinc-800 flex items-center justify-center hover:bg-zinc-700"><Mail size={20}/></button>
                                    </div>

                                    <div className="mb-6">
                                        <button className="px-6 py-2 rounded-full bg-zinc-800 border border-zinc-700 hover:bg-white hover:text-black transition-all flex items-center gap-2 text-sm font-bold">
                                            <FileText size={16} /> View Resume
                                        </button>
                                    </div>

                                    <div className="mt-auto grid grid-cols-3 gap-6 w-full">
                                        <button 
                                            onClick={() => handleSwipe(-1)}
                                            className="h-16 rounded-2xl bg-zinc-800 text-red-500 flex items-center justify-center hover:bg-red-500 hover:text-white transition-all border border-zinc-700"
                                        >
                                            <X size={28} />
                                        </button>
                                        <button className="h-16 rounded-2xl bg-zinc-800 text-yellow-500 flex items-center justify-center hover:bg-yellow-500 hover:text-black transition-all border border-zinc-700">
                                            <Star size={28} />
                                        </button>
                                        <button 
                                            onClick={() => handleSwipe(1)}
                                            className="h-16 rounded-2xl bg-white text-black flex items-center justify-center hover:scale-105 transition-all shadow-[0_0_20px_rgba(255,255,255,0.3)]"
                                        >
                                            <Check size={28} strokeWidth={3} />
                                        </button>
                                    </div>

                                </motion.div>
                            </AnimatePresence>
                        </div>
                    ) : (
                        <div className="text-center">
                            <div className="w-20 h-20 rounded-full bg-zinc-900 mx-auto flex items-center justify-center mb-4">
                                <Check size={32} className="text-emerald-500" />
                            </div>
                            <h2 className="text-2xl font-bold mb-2">You're all caught up!</h2>
                            <p className="text-zinc-500">No more applicants to review for this role.</p>
                            <button onClick={() => navigate('/orbit')} className="mt-6 text-indigo-400 hover:underline">Return to Dashboard</button>
                        </div>
                    )}

                </div>
            </div>
        </div>
    );
};

export default OrbitApplicants;
