import React, { useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { motion, useScroll, useTransform } from 'framer-motion';
import { 
    ChevronLeft, Calendar, Users, Trophy, Target, 
    Instagram, Twitter, Linkedin, Globe, Zap, 
    ExternalLink, ArrowUpRight, Terminal, Cpu, Flag
} from 'lucide-react';
import Navbar from '../home/Navbar';

// --- MOCK DATABASE (Simulating Backend) ---
const CLUBS_DATA = {
    "1": { // AIMSA
        name: "AIMSA",
        fullName: "AIML Student's Association",
        type: "Tech",
        theme: "violet",
        cover: "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=1600&q=80",
        logo: "https://api.dicebear.com/7.x/bottts/svg?seed=AIMSA",
        description: "Decrypted Log: We are the neural network of the campus. Exploring the frontiers of Artificial Intelligence and Machine Learning. From deploying LLMs to training reinforcement agents, we bridge the gap between theory and code.",
        founded: "2018",
        stats: [
            { label: "Models Trained", value: "45+", prefix: "" },
            { label: "Active Nodes", value: "145", prefix: "" }, // Members
            { label: "Hackathons Won", value: "12", prefix: "🏆" },
            { label: "Workshops", value: "28", prefix: "" }
        ],
        signatureEvent: {
            title: "NEURAL HACK 3.0",
            image: "https://images.unsplash.com/photo-1544197150-b99a580bb7f8?w=800&q=80",
            description: "Our flagship 36-hour non-stop AI hackathon. 500+ participants, industry judges, and tasks ranging from Computer Vision to Generative AI. The ultimate test of coding endurance.",
            date: "March 15, 2024"
        },
        events: [
            { title: "Intro to GANs", date: "Feb 10, 2024", image: "https://images.unsplash.com/photo-1617791160505-6f00504e3519?w=600&q=80" },
            { title: "AI Ethics Seminar", date: "Jan 22, 2024", image: "https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=600&q=80" },
            { title: "Kaggle Face-off", date: "Dec 05, 2023", image: "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=600&q=80" }
        ],
        leadership: [
            { name: "Arjun Verma", role: "President", img: "https://api.dicebear.com/9.x/micah/svg?seed=Arjun&backgroundColor=b6e3f4" },
            { name: "Sana Khan", role: "Vice President", img: "https://api.dicebear.com/9.x/micah/svg?seed=Sana&backgroundColor=ffdfbf" }
        ]
    },
    "2": { // ACM Student Chapter
        name: "ACM",
        fullName: "ACM Student Chapter",
        type: "Tech",
        theme: "blue",
        cover: "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=1600&q=80",
        logo: "https://api.dicebear.com/7.x/bottts/svg?seed=ACM",
        description: "Decrypted Log: Advancing computing as a science and profession. We are the largest computing society's student chapter, focusing on theoretical computer science, algorithms, and global competitions.",
        founded: "2015",
        stats: [
            { label: "Algorithms Solved", value: "500+", prefix: "" },
            { label: "Active Members", value: "210", prefix: "" },
            { label: "ICP Finalists", value: "3", prefix: "🏆" },
            { label: "Tech Talks", value: "40", prefix: "" }
        ],
        signatureEvent: {
            title: "CODE WARS",
            image: "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&q=80",
            description: "An intense competitive programming battleground. 24 hours of grueling algorithmic challenges that test logic, speed, and optimization skills.",
            date: "October 10, 2024"
        },
        events: [
            { title: "Graph Theory Workshop", date: "Sep 15, 2024", image: "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=600&q=80" },
            { title: "Placement Bootcamp", date: "Aug 20, 2024", image: "https://images.unsplash.com/photo-1531482615713-2afd69097998?w=600&q=80" },
            { title: "Open Source Day", date: "July 12, 2024", image: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=600&q=80" }
        ],
        leadership: [
            { name: "Rahul Mehta", role: "President", img: "https://api.dicebear.com/9.x/micah/svg?seed=Rahul&backgroundColor=c0aede" },
            { name: "Priya Sharma", role: "Vice President", img: "https://api.dicebear.com/9.x/micah/svg?seed=Priya&backgroundColor=ffdfbf" }
        ]
    },    
    // Default fallback for others to prevent crashes, customized slightly by ID
    "default": {
        name: "CLUB PROTOCOL",
        fullName: "Student Activity Center",
        type: "General",
        theme: "lime",
        cover: "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?w=1600&q=80",
        logo: "https://api.dicebear.com/7.x/shapes/svg?seed=Default",
        description: "System Log: A collective of passionate individuals pushing boundaries. We organize events, foster community, and create impact.",
        founded: "2020",
        stats: [
            { label: "Events", value: "20+", prefix: "" },
            { label: "Members", value: "100+", prefix: "" },
            { label: "Impact", value: "High", prefix: "⚡" },
            { label: "Reach", value: "5k+", prefix: "" }
        ],
        signatureEvent: {
            title: "CAMPUS FIESTA",
            image: "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800&q=80",
            description: "The biggest annual gathering on campus. Music, food, and vibes that resonate across the city.",
            date: "April 20, 2024"
        },
        events: [
            { title: "Workshop Series", date: "Month 1", image: "https://images.unsplash.com/photo-1515187029135-18ee286d815b?w=600&q=80" },
            { title: "Community Meetup", date: "Month 2", image: "https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=600&q=80" },
            { title: "Tech Talk", date: "Month 3", image: "https://images.unsplash.com/photo-1505373877841-8d43f703fb8f?w=600&q=80" }
        ],
        leadership: [
            { name: "Leader One", role: "President", img: "https://api.dicebear.com/9.x/micah/svg?seed=L1&backgroundColor=c0aede" },
            { name: "Leader Two", role: "Vice President", img: "https://api.dicebear.com/9.x/micah/svg?seed=L2&backgroundColor=d1d4f9" }
        ]
    }
};

// --- HELPER FOR THEMES ---
const getThemeStyles = (type) => {
    switch (type) {
        case 'Tech': return {
            bg: "bg-[#050510]",
            accent: "text-cyan-400",
            border: "border-cyan-500/30",
            gradient: "from-cyan-500/20 to-blue-600/10",
            button: "bg-cyan-400 text-black hover:bg-cyan-300",
            font: "font-mono"
        };
        case 'Motorsports': return {
            bg: "bg-[#0F0F0F]",
            accent: "text-red-500",
            border: "border-red-500/30",
            gradient: "from-red-600/20 to-orange-600/10",
            button: "bg-red-500 text-white hover:bg-red-600",
            font: "font-sans uppercase"
        };
        case 'Cultural': return {
            bg: "bg-[#1a051a]",
            accent: "text-pink-400",
            border: "border-pink-500/30",
            gradient: "from-pink-500/20 to-purple-600/10",
            button: "bg-pink-400 text-black hover:bg-pink-300",
            font: "font-serif"
        };
        default: return {
            bg: "bg-black",
            accent: "text-ubLime",
            border: "border-ubLime/30",
            gradient: "from-ubLime/20 to-green-600/10",
            button: "bg-ubLime text-black hover:bg-white",
            font: "font-sans"
        };
    }
};

const ClubPortfolioPage = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    const { scrollYProgress } = useScroll();
    
    // Select data (fallback to ID 1 or default if missing for demo)
    const rawData = CLUBS_DATA[id] || { ...CLUBS_DATA["default"], name: `Club ${id}`, fullName: `Club ${id} Official` };
    if (CLUBS_DATA[id]) {
        // use exact match
    } else {
        // Customize fallback slightly
        rawData.theme = ["Tech", "Motorsports", "Cultural", "Robotics"][id % 4] || "General";
    }

    const theme = getThemeStyles(rawData.type);
    
    // Scroll Parallax for Hero
    const yHero = useTransform(scrollYProgress, [0, 1], ["0%", "50%"]);
    const opacityHero = useTransform(scrollYProgress, [0, 0.5], [1, 0]);

    useEffect(() => {
        window.scrollTo(0, 0);
    }, []);

    return (
        <div className={`min-h-screen ${theme.bg} text-white selection:bg-white/30`}>
            <Navbar />
            
            {/* 1. HERO SECTION */}
            <header className="relative h-[80vh] overflow-hidden flex items-end pb-20 px-6 md:px-12 border-b border-white/10">
                <motion.div style={{ y: yHero, opacity: opacityHero }} className="absolute inset-0 z-0">
                    <div className={`absolute inset-0 bg-gradient-to-t ${theme.bg} via-transparent to-transparent z-10`} />
                    <img src={rawData.cover} alt="Cover" className="w-full h-full object-cover opacity-60" />
                    <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20 mix-blend-overlay" />
                </motion.div>

                <div className="relative z-20 max-w-7xl w-full mx-auto flex flex-col md:flex-row items-end justify-between gap-8">
                    <div>
                        <motion.div 
                            initial={{ opacity: 0, y: 50 }}
                            animate={{ opacity: 1, y: 0 }}
                            className="flex items-center gap-3 mb-4"
                        >
                            <span className={`px-3 py-1 rounded-full border ${theme.border} bg-black/50 backdrop-blur-md text-xs font-bold uppercase tracking-widest ${theme.accent}`}>
                                {rawData.type} Division
                            </span>
                            <span className="text-gray-400 text-xs font-mono">EST. {rawData.founded}</span>
                        </motion.div>

                        <motion.h1 
                            initial={{ opacity: 0, scale: 0.9 }}
                            animate={{ opacity: 1, scale: 1 }}
                            transition={{ delay: 0.1 }}
                            className={`text-6xl md:text-9xl font-black leading-none tracking-tighter mb-2 ${theme.font} uppercase`}
                        >
                            {rawData.name}
                        </motion.h1>
                        <p className="text-xl md:text-3xl text-gray-300 font-light max-w-2xl">
                            {rawData.fullName}
                        </p>
                    </div>

                    <motion.div 
                        initial={{ opacity: 0, x: 50 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.3 }}
                        className="flex gap-4"
                    >
                        <button className={`${theme.button} px-8 py-4 rounded-xl font-bold uppercase tracking-wider transition-transform hover:scale-105 shadow-[0_0_30px_rgba(255,255,255,0.1)]`}>
                            Join Network
                        </button>
                        <div className="flex gap-2">
                             {[Instagram, Twitter, Linkedin, Globe].map((Icon, i) => (
                                 <button key={i} className="p-4 bg-white/5 border border-white/10 rounded-xl hover:bg-white hover:text-black transition-all">
                                     <Icon size={20} />
                                 </button>
                             ))}
                        </div>
                    </motion.div>
                </div>
            </header>

            <div className="max-w-7xl mx-auto px-6 md:px-12 py-20">
                <div className="grid grid-cols-1 lg:grid-cols-12 gap-12">
                    
                    {/* LEFT COLUMN: Lore & Stats */}
                    <div className="lg:col-span-8 space-y-20">
                        {/* 2. THE LORE */}
                        <section>
                            <div className="flex items-center gap-2 mb-6 opacity-50">
                                <Terminal size={16} />
                                <span className="font-mono text-sm uppercase tracking-widest">System_Log: About</span>
                            </div>
                            <h2 className="text-3xl md:text-5xl font-bold leading-tight mb-8">
                                {rawData.description}
                            </h2>
                            
                            {/* 3. HUD STATS */}
                            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                                {rawData.stats.map((stat, i) => (
                                    <div key={i} className={`p-6 bg-white/5 border ${theme.border} rounded-2xl relative overflow-hidden group hover:bg-white/10 transition-colors`}>
                                        <p className="text-xs text-gray-500 uppercase tracking-wider mb-2">{stat.label}</p>
                                        <p className={`text-4xl font-black ${theme.accent} flex items-baseline gap-1`}>
                                            {stat.value}
                                            <span className="text-lg text-white opacity-50">{stat.prefix}</span>
                                        </p>
                                        <div className={`absolute bottom-0 left-0 h-1 bg-${theme.accent.split('-')[1]}-500 w-0 group-hover:w-full transition-all duration-700`} />
                                    </div>
                                ))}
                            </div>
                        </section>

                        {/* 4. SIGNATURE EVENT */}
                        <section>
                            <div className="flex items-center justify-between mb-8">
                                <div className="flex items-center gap-2 opacity-50">
                                    <Flag size={16} />
                                    <span className="font-mono text-sm uppercase tracking-widest">Flagship_Protocol</span>
                                </div>
                            </div>
                            
                            <motion.div 
                                whileHover={{ scale: 1.01 }}
                                className={`flex flex-col md:flex-row bg-[#111] border ${theme.border} rounded-[2rem] overflow-hidden shadow-2xl`}
                            >
                                <div className="md:w-1/2 h-64 md:h-auto relative overflow-hidden group">
                                    <img 
                                        src={rawData.signatureEvent.image} 
                                        alt={rawData.signatureEvent.title} 
                                        className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                                    />
                                    <div className="absolute inset-0 bg-black/20 group-hover:bg-transparent transition-colors" />
                                    {/* Signature Badge */}
                                    <div className="absolute top-4 left-4 bg-yellow-400 text-black px-3 py-1 text-xs font-black uppercase tracking-wider rounded-md">
                                        Signature Event
                                    </div>
                                </div>
                                <div className="md:w-1/2 p-8 md:p-12 flex flex-col justify-center relative">
                                    <div className={`absolute top-0 right-0 p-32 bg-gradient-radial ${theme.gradient} blur-[80px] opacity-30`} />
                                    
                                    <h3 className="text-3xl md:text-5xl font-black mb-4 uppercase leading-none">
                                        {rawData.signatureEvent.title}
                                    </h3>
                                    <p className="text-gray-400 mb-8 leading-relaxed">
                                        {rawData.signatureEvent.description}
                                    </p>
                                    
                                    <div className="flex items-center justify-between mt-auto pt-8 border-t border-white/10">
                                        <div className="flex items-center gap-2">
                                            <Calendar className={theme.accent} size={18} />
                                            <span className="font-bold">{rawData.signatureEvent.date}</span>
                                        </div>
                                        <button className="flex items-center gap-2 text-sm font-bold hover:text-white text-gray-400 transition-colors">
                                            View Archive <ArrowUpRight size={16} />
                                        </button>
                                    </div>
                                </div>
                            </motion.div>
                        </section>

                        {/* 5. EVENTS GALLERY */}
                        <section>
                             <div className="flex items-center gap-2 mb-8 opacity-50">
                                <Calendar size={16} />
                                <span className="font-mono text-sm uppercase tracking-widest">Event_Operations_Log</span>
                            </div>
                            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                                {rawData.events.map((event, i) => (
                                    <div key={i} className="group cursor-pointer">
                                        <div className="h-48 rounded-2xl overflow-hidden mb-4 relative">
                                            <img src={event.image} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" alt={event.title} />
                                            <div className="absolute inset-0 bg-black/40 group-hover:bg-transparent transition-colors" />
                                        </div>
                                        <h4 className="text-xl font-bold group-hover:text-ubLime transition-colors">{event.title}</h4>
                                        <p className="text-sm text-gray-500">{event.date}</p>
                                    </div>
                                ))}
                            </div>
                        </section>
                    </div>

                    {/* RIGHT COLUMN: Leadership (High Command) */}
                    <div className="lg:col-span-4 space-y-8">
                        <div className="lg:sticky lg:top-32">
                             <div className="flex items-center gap-2 mb-8 opacity-50">
                                <Users size={16} />
                                <span className="font-mono text-sm uppercase tracking-widest">High_Command</span>
                            </div>
                            
                            <div className="space-y-6">
                                {rawData.leadership.map((leader, i) => (
                                    <motion.div 
                                        key={i}
                                        whileHover={{ y: -5 }}
                                        className="relative bg-zinc-900 border border-white/5 rounded-3xl p-6 overflow-hidden group"
                                    >
                                        <div className="flex items-center gap-4 mb-4">
                                            <div className="w-16 h-16 rounded-full overflow-hidden border-2 border-white/10 group-hover:border-ubLime transition-colors">
                                                <img src={leader.img} alt={leader.name} className="w-full h-full object-cover" />
                                            </div>
                                            <div>
                                                <h4 className="text-xl font-black">{leader.name}</h4>
                                                <p className={`text-xs font-bold uppercase tracking-wider ${i === 0 ? theme.accent : 'text-gray-500'}`}>
                                                    {leader.role}
                                                </p>
                                            </div>
                                        </div>
                                        <div className="h-[1px] w-full bg-white/5 mb-4" />
                                        <div className="flex justify-between items-center opacity-0 group-hover:opacity-100 transition-opacity">
                                            <span className="text-xs text-gray-500">Contact</span>
                                            <div className="flex gap-2">
                                                <Linkedin size={14} className="hover:text-ubLime cursor-pointer" />
                                                <Twitter size={14} className="hover:text-ubLime cursor-pointer" />
                                            </div>
                                        </div>
                                        {/* Background Glow */}
                                        <div className={`absolute -bottom-10 -right-10 w-24 h-24 bg-gradient-to-br ${theme.gradient} blur-[40px] opacity-20 group-hover:opacity-50 transition-opacity`} />
                                    </motion.div>
                                ))}
                                
                                {/* Info Box */}
                                <div className="p-6 rounded-3xl bg-white/5 border border-dashed border-white/10 mt-12">
                                    <h5 className="font-bold flex items-center gap-2 mb-2">
                                        <Target size={18} /> Join Forces
                                    </h5>
                                    <p className="text-sm text-gray-400 mb-4">
                                        Want to collaborate or join the {rawData.name} team?
                                    </p>
                                    <button className="w-full py-3 rounded-xl border border-white/20 hover:bg-white hover:text-black transition-all text-sm font-bold uppercase">
                                        Aplply for Core
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <button 
                onClick={() => navigate(-1)} 
                className="fixed bottom-8 left-8 p-4 bg-black/50 backdrop-blur-md rounded-full border border-white/10 hover:bg-white hover:text-black transition-all z-50 text-white"
            >
                <ChevronLeft size={24} />
            </button>
        </div>
    );
};

export default ClubPortfolioPage;
