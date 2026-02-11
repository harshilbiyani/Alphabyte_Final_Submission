import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Calendar, MapPin, Users, Target, ArrowRight, Info, CheckCircle, X, QrCode, Printer } from 'lucide-react';
import Navbar from '../home/Navbar';

const SponsorEventsPage = () => {
    const [selectedRequirementEvent, setSelectedRequirementEvent] = useState(null);
    const [selectedSponsorEvent, setSelectedSponsorEvent] = useState(null);

    const events = [
        { 
            id: 1, 
            title: "HackNova 2024", 
            organizer: "ACM Student Chapter", 
            date: "March 15-16, 2024", 
            location: "Main Auditorium", 
            footfall: "500+", 
            tags: ["Tech", "Hackathon"], 
            image: "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=800&auto=format&fit=crop",
            type: "Technical Hackathon",
            sponsorshipType: "Monetary (Title Sponsor)",
            requirements: "₹50,000 Sponsorship Amount + 3 Judges",
            returns: "Logo on all banners, 15 min Speaker Slot, Social Media coverage (10k+ reach), Stall space.",
            promised: "Title Sponsor Status, Data of all participants, Keynote Session."
        },
        { 
            id: 2, 
            title: "Rhythm Gala", 
            organizer: "Music Club", 
            date: "April 2, 2024", 
            location: "Open Air Theatre", 
            footfall: "1200+", 
            tags: ["Cultural", "Music"], 
            image: "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=800&auto=format&fit=crop",
            type: "Cultural Music Fest",
            sponsorshipType: "In-Kind (Sound Equipment)",
            requirements: "Professional Sound Setup for 4 hours",
            returns: "Anchoring mentions every hour, Banner on stage, VIP Seating for executives.",
            promised: "Exclusive Audio Partner branding, Live mentions."
        },
        { 
            id: 3, 
            title: "RoboWars", 
            organizer: "Robotics Club", 
            date: "April 10, 2024", 
            location: "Sports Complex", 
            footfall: "800+", 
            tags: ["Tech", "Robotics"], 
            image: "https://images.unsplash.com/photo-1535378437348-92484a974fc4?q=80&w=800&auto=format&fit=crop",
            type: "Robotics Competition",
            sponsorshipType: "Prize Pool Sponsor",
            requirements: "₹30,000 for Winners",
            returns: "Product Demo Stall, Logo on Bot Arenas, T-shirt branding.",
            promised: "Associate Sponsor Tag, 1 hour Workshop slot."
        },
        { 
            id: 4, 
            title: "Art Exhibit", 
            organizer: "Fine Arts Society", 
            date: "March 20, 2024", 
            location: "Dept of Arts", 
            footfall: "300+", 
            tags: ["Art", "Exhibition"], 
            image: "https://images.unsplash.com/photo-1536924940846-227afb31e2a5?q=80&w=800&auto=format&fit=crop",
            type: "Art Exhibition",
            sponsorshipType: "Refreshments",
            requirements: "Snacks & Drinks for 300 guests",
            returns: "Branding on food counters, Thank you note in brochure.",
            promised: "Hospitality Partner Tag."
        },
        { 
            id: 5, 
            title: "E-Summit '24", 
            organizer: "E-Cell", 
            date: "May 5-6, 2024", 
            location: "Convention Center", 
            footfall: "2000+", 
            tags: ["Business", "Startup"], 
            image: "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?q=80&w=800&auto=format&fit=crop",
            type: "Entrepreneurship Summit",
            sponsorshipType: "Monetary (Gold Sponsor)",
            requirements: "₹1,00,000 Support",
            returns: "Keynote slot, Logo on huge backdrop, Networking dinner access.",
            promised: "Access to 50+ Starts, Investor Connect."
        },
        { 
            id: 6, 
            title: "Champions League", 
            organizer: "Sports Board", 
            date: "April 25-30, 2024", 
            location: "Main Stadium", 
            footfall: "5000+", 
            tags: ["Sports", "Fitness"], 
            image: "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?q=80&w=800&auto=format&fit=crop",
            type: "Inter-College Sports",
            sponsorshipType: "Merchandise (Jerseys)",
            requirements: "500 Jerseys + Energy Drinks",
            returns: "Logo on Jerseys, Banner on field boundary.",
            promised: "Naming rights for Man of the Match awards."
        },
    ];

    const handlePrint = () => {
        window.print();
    };

    return (
        <div className="min-h-screen bg-black text-white font-sans selection:bg-ubLime selection:text-black">
            <Navbar />
            
            <div className="pt-32 pb-20 px-6 md:px-12 max-w-7xl mx-auto">
                {/* Header */}
                <motion.div 
                    initial={{ opacity: 0, y: 30 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="mb-16 relative text-center md:text-left"
                >
                    <h1 className="text-5xl md:text-7xl font-black mb-4">
                        Sponsorship <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet">Opportunities</span>
                    </h1>
                    <p className="text-xl text-gray-400 max-w-3xl font-medium">
                        Connect your brand with the most impactful campus events.
                    </p>
                </motion.div>

                {/* Events Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    {events.map((event, index) => (
                        <motion.div
                            key={event.id}
                            initial={{ opacity: 0, y: 30 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            transition={{ duration: 0.5, delay: index * 0.1 }}
                            className="bg-zinc-900/50 border border-white/5 rounded-3xl overflow-hidden hover:border-ubLime/50 transition-all group flex flex-col h-full"
                        >
                            {/* Image Section */}
                            <div className="relative h-48 overflow-hidden">
                                <img 
                                    src={event.image} 
                                    alt={event.title} 
                                    className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700" 
                                />
                                <div className="absolute top-4 left-4 flex gap-2">
                                    {event.tags.map(tag => (
                                        <span key={tag} className="px-3 py-1 bg-black/60 backdrop-blur-md rounded-full text-xs font-bold text-ubLime uppercase tracking-wider border border-white/10">
                                            {tag}
                                        </span>
                                    ))}
                                </div>
                            </div>

                            {/* Content Section */}
                            <div className="p-6 flex-1 flex flex-col">
                                <h3 className="text-2xl font-black text-white mb-2">{event.title}</h3>
                                <p className="text-sm font-medium text-gray-400 mb-6 flex items-center gap-2">
                                    <Target size={14} className="text-ubViolet" /> {event.organizer}
                                </p>

                                <div className="space-y-3 mb-8 flex-1">
                                    <div className="flex items-center gap-3 text-sm text-gray-300">
                                        <Calendar size={16} className="text-gray-500" />
                                        <span>{event.date}</span>
                                    </div>
                                    <div className="flex items-center gap-3 text-sm text-gray-300">
                                        <MapPin size={16} className="text-gray-500" />
                                        <span>{event.location}</span>
                                    </div>
                                    <div className="flex items-center gap-3 text-sm text-gray-300">
                                        <Users size={16} className="text-gray-500" />
                                        <span>{event.footfall} Expected</span>
                                    </div>
                                </div>

                                {/* Buttons */}
                                <div className="grid grid-cols-2 gap-3 mt-auto">
                                    <button 
                                        onClick={() => setSelectedRequirementEvent(event)}
                                        className="px-4 py-3 rounded-xl border border-white/10 text-gray-300 hover:bg-white/5 hover:text-white font-bold text-sm transition-colors flex items-center justify-center gap-2"
                                    >
                                        <Info size={16} /> details
                                    </button>
                                    <button 
                                        onClick={() => setSelectedSponsorEvent(event)}
                                        className="px-4 py-3 rounded-xl bg-ubLime text-black font-bold text-sm hover:bg-ubLime/90 transition-colors shadow-lg shadow-ubLime/20 flex items-center justify-center gap-2"
                                    >
                                        Sponsor <ArrowRight size={16} />
                                    </button>
                                </div>
                            </div>
                        </motion.div>
                    ))}
                </div>
            </div>

            {/* MODALS */}
            <AnimatePresence>
                {/* 1. Requirements Modal */}
                {selectedRequirementEvent && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
                        <motion.div 
                            initial={{ opacity: 0 }} 
                            animate={{ opacity: 1 }} 
                            exit={{ opacity: 0 }}
                            onClick={() => setSelectedRequirementEvent(null)}
                            className="absolute inset-0 bg-black/80 backdrop-blur-sm" 
                        />
                        <motion.div 
                            initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                            className="relative w-full max-w-lg bg-zinc-900 border border-white/10 rounded-3xl p-8 md:p-10 shadow-2xl overflow-hidden"
                        >
                            <button 
                                onClick={() => setSelectedRequirementEvent(null)}
                                className="absolute top-6 right-6 p-2 rounded-full bg-white/5 hover:bg-white/10 text-gray-400 hover:text-white transition-colors"
                            >
                                <X size={20} />
                            </button>

                            <div className="mb-6">
                                <span className="text-ubLime font-mono text-xs uppercase tracking-widest mb-2 block">Event Requirements</span>
                                <h2 className="text-3xl font-black text-white">{selectedRequirementEvent.title}</h2>
                                <p className="text-gray-500">{selectedRequirementEvent.type}</p>
                            </div>

                            <div className="space-y-6">
                                <div className="bg-white/5 p-4 rounded-2xl border border-white/5">
                                    <h4 className="flex items-center gap-2 font-bold mb-2 text-white">
                                        <Target className="text-ubViolet" size={18} />
                                        Sponsorship Type
                                    </h4>
                                    <p className="text-gray-300 text-sm">{selectedRequirementEvent.sponsorshipType}</p>
                                </div>

                                <div className="bg-white/5 p-4 rounded-2xl border border-white/5">
                                    <h4 className="flex items-center gap-2 font-bold mb-2 text-white">
                                        <Info className="text-blue-400" size={18} />
                                        What is Required
                                    </h4>
                                    <p className="text-gray-300 text-sm">{selectedRequirementEvent.requirements}</p>
                                </div>

                                <div className="bg-white/5 p-4 rounded-2xl border border-white/5">
                                    <h4 className="flex items-center gap-2 font-bold mb-2 text-white">
                                        <CheckCircle className="text-ubLime" size={18} />
                                        What You Get (ROI)
                                    </h4>
                                    <p className="text-gray-300 text-sm">{selectedRequirementEvent.returns}</p>
                                </div>

                                <div className="grid grid-cols-3 gap-2 mt-4 pt-4 border-t border-white/10">
                                    <div className="text-center">
                                        <div className="text-xs text-gray-500 uppercase font-bold">Footfall</div>
                                        <div className="font-bold text-white text-lg">{selectedRequirementEvent.footfall}</div>
                                    </div>
                                    <div className="text-center border-l border-white/10">
                                        <div className="text-xs text-gray-500 uppercase font-bold">Date</div>
                                        <div className="font-bold text-white text-lg">{selectedRequirementEvent.date.split(',')[0]}</div>
                                    </div>
                                    <div className="text-center border-l border-white/10">
                                        <div className="text-xs text-gray-500 uppercase font-bold">Loc</div>
                                        <div className="font-bold text-white text-lg truncate px-1">{selectedRequirementEvent.location.split(' ')[0]}</div>
                                    </div>
                                </div>
                            </div>
                        </motion.div>
                    </div>
                )}

                {/* 2. Sponsor Modal (QR & Contract) */}
                {selectedSponsorEvent && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4">
                        <motion.div 
                            initial={{ opacity: 0 }} 
                            animate={{ opacity: 1 }} 
                            exit={{ opacity: 0 }}
                            onClick={() => setSelectedSponsorEvent(null)}
                            className="absolute inset-0 bg-black/80 backdrop-blur-sm" 
                        />
                         <motion.div 
                             initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                             className="relative w-full max-w-4xl bg-zinc-900 border border-white/10 rounded-3xl overflow-hidden shadow-2xl flex flex-col md:flex-row min-h-[500px]"
                         >
                            <button 
                                onClick={() => setSelectedSponsorEvent(null)}
                                className="absolute top-6 right-6 z-10 p-2 rounded-full bg-black/20 hover:bg-black/40 text-gray-400 hover:text-white transition-colors"
                            >
                                <X size={24} />
                            </button>

                            {/* Left: QR Code Section */}
                            <div className="w-full md:w-5/12 bg-ubLime p-8 flex flex-col items-center justify-center text-center relative overflow-hidden">
                                <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-40 mix-blend-multiply" />
                                <div className="relative z-10">
                                    <h3 className="text-black font-black text-2xl mb-2">Scan to Chat</h3>
                                    <p className="text-black/70 font-bold text-sm mb-6">Connect directly with {selectedSponsorEvent.organizer}</p>
                                    
                                    <div className="bg-white p-4 rounded-3xl shadow-xl mx-auto max-w-[220px]">
                                        <div className="aspect-square bg-white flex items-center justify-center">
                                           {/* Simulated QR Code */}
                                            <QrCode size={160} className="text-black" />
                                        </div>
                                    </div>

                                    <div className="mt-6 flex items-center justify-center gap-2 text-black/60 font-mono text-xs font-bold">
                                        <span className="w-2 h-2 bg-green-600 rounded-full animate-pulse" />
                                        Organizer is Online
                                    </div>
                                </div>
                            </div>

                            {/* Right: Contract/Requirements Summary */}
                            <div className="w-full md:w-7/12 p-8 md:p-12 flex flex-col">
                                <div className="mb-6">
                                    <h2 className="text-3xl font-black text-white mb-2">Sponsorship Terms</h2>
                                    <p className="text-gray-400">Review the deliverables before proceeding.</p>
                                </div>

                                <div className="flex-1 space-y-6">
                                     <div className="space-y-4">
                                        <div className="flex justify-between border-b border-white/10 pb-4">
                                            <span className="text-gray-500 font-medium">Event</span>
                                            <span className="text-white font-bold">{selectedSponsorEvent.title}</span>
                                        </div>
                                        <div className="flex justify-between border-b border-white/10 pb-4">
                                            <span className="text-gray-500 font-medium">Agreement Type</span>
                                            <span className="text-white font-bold">{selectedSponsorEvent.sponsorshipType}</span>
                                        </div>
                                     </div>

                                     <div className="bg-zinc-800/50 p-6 rounded-2xl border border-white/5">
                                         <h4 className="text-sm font-bold text-gray-400 uppercase tracking-widest mb-3">Promised Deliverables</h4>
                                         <ul className="space-y-3">
                                             {selectedSponsorEvent.promised.split(', ').map((item, i) => (
                                                 <li key={i} className="flex items-start gap-3 text-sm text-gray-200">
                                                     <CheckCircle size={16} className="text-ubLime mt-0.5 shrink-0" />
                                                     <span>{item}</span>
                                                 </li>
                                             ))}
                                         </ul>
                                     </div>
                                </div>

                                <div className="mt-8 pt-6 border-t border-white/10">
                                    <button 
                                        onClick={handlePrint}
                                        className="w-full py-4 rounded-xl bg-white text-black font-bold text-lg hover:bg-gray-200 transition-colors flex items-center justify-center gap-3"
                                    >
                                        <Printer size={20} />
                                        Print Agreement
                                    </button>
                                </div>
                            </div>

                         </motion.div>
                    </div>
                )}
            </AnimatePresence>
        </div>
    );
};

export default SponsorEventsPage;

