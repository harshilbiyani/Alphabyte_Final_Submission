import React from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { 
    Users, Code, PenTool, Music, Cpu, Globe, ArrowUpRight, 
    Zap, Target, Wrench, Car, Bot, Terminal, Shield, MessageSquare, 
    Rocket, Swords, Mic2 
} from 'lucide-react';
import Navbar from '../home/Navbar';

const ClubsPage = () => {
    const navigate = useNavigate();
    const [activeCategory, setActiveCategory] = React.useState("All");

  const container = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  };

  const item = {
    hidden: { opacity: 0, y: 50 },
    show: { opacity: 1, y: 0, transition: { type: "spring", stiffness: 50 } }
  };

  const clubs = [
    { 
        id: 1, 
        name: "AIMSA", 
        full: "AIML Student's Association", 
        type: "Tech", 
        members: 145, 
        icon: Bot, 
        color: "text-purple-400", 
        bg: "bg-purple-900/20", 
        border: "border-purple-500/20",
        image: "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=800&q=80" 
    },
    { 
        id: 2, 
        name: "ACM Student Chapter", 
        full: "Assoc. for Computing Machinery", 
        type: "Tech", 
        members: 210, 
        icon: Terminal, 
        color: "text-blue-400", 
        bg: "bg-blue-900/20", 
        border: "border-blue-500/20",
        image: "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&q=80" 
    },
    { 
        id: 3, 
        name: "CRESA", 
        full: "Civil & Robotics Eng. SA", 
        type: "Engineering", 
        members: 95, 
        icon: Wrench, 
        color: "text-orange-400", 
        bg: "bg-orange-900/20", 
        border: "border-orange-500/20",
        image: "https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=800&q=80" 
    },
    { 
        id: 4, 
        name: "ITSA", 
        full: "IT Student Association", 
        type: "Tech", 
        members: 180, 
        icon: Code, 
        color: "text-cyan-400", 
        bg: "bg-cyan-900/20", 
        border: "border-cyan-500/20",
        image: "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800&q=80" 
    },
    { 
        id: 5, 
        name: "ETSA", 
        full: "Electronics & Telecom SA", 
        type: "Tech", 
        members: 130, 
        icon: Cpu, 
        color: "text-yellow-400", 
        bg: "bg-yellow-900/20", 
        border: "border-yellow-500/20",
        image: "https://images.unsplash.com/photo-1518770660439-4636190af475?w=800&q=80" 
    },
    { 
        id: 6, 
        name: "MLSC", 
        full: "Microsoft Learn Student Club", 
        type: "Tech", 
        members: 300, 
        icon: Rocket, 
        color: "text-blue-500", 
        bg: "bg-blue-900/20", 
        border: "border-blue-500/20",
        image: "https://images.unsplash.com/photo-1517430816045-df4b7de8db98?w=800&q=80" 
    },
    { 
        id: 7, 
        name: "GDGC", 
        full: "Google Developer Groups", 
        type: "Tech", 
        members: 250, 
        icon: Globe, 
        color: "text-green-400", 
        bg: "bg-green-900/20", 
        border: "border-green-500/20",
        image: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&q=80" 
    },
    { 
        id: 8, 
        name: "Team Red Baron", 
        full: "Off-Road Racing", 
        type: "Motorsports", 
        members: 45, 
        icon: Car, 
        color: "text-red-500", 
        bg: "bg-red-900/20", 
        border: "border-red-500/20",
        image: "https://images.unsplash.com/photo-1541896916-d39b8aa75924?w=800&q=80" 
    },
    { 
        id: 9, 
        name: "Team Solarium", 
        full: "Solar Electric Vehicle", 
        type: "Motorsports", 
        members: 40, 
        icon: Zap, 
        color: "text-yellow-300", 
        bg: "bg-yellow-900/20", 
        border: "border-yellow-500/20",
        image: "https://images.unsplash.com/photo-1532906619279-a79b29a957d3?w=800&q=80" 
    },
    { 
        id: 10, 
        name: "Team Kratos", 
        full: "All-Terrain Vehicle", 
        type: "Motorsports", 
        members: 50, 
        icon: Shield, 
        color: "text-gray-200", 
        bg: "bg-gray-800/20", 
        border: "border-gray-500/20",
        image: "https://images.unsplash.com/photo-1552309322-c28e93297a7a?w=800&q=80" 
    },
    { 
        id: 11, 
        name: "Team Ambush", 
        full: "Tactical Sports", 
        type: "Sports", 
        members: 60, 
        icon: Target, 
        color: "text-emerald-400", 
        bg: "bg-emerald-900/20", 
        border: "border-emerald-500/20",
        image: "https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?w=800&q=80" 
    },
    { 
        id: 12, 
        name: "Team Automatons", 
        full: "Robotics & Automation", 
        type: "Robotics", 
        members: 75, 
        icon: Bot, 
        color: "text-pink-500", 
        bg: "bg-pink-900/20", 
        border: "border-pink-500/20",
        image: "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&q=80" 
    },
    { 
        id: 13, 
        name: "Team Maverick", 
        full: "Go-Karting Racing", 
        type: "Motorsports", 
        members: 35, 
        icon: Car, 
        color: "text-indigo-400", 
        bg: "bg-indigo-900/20", 
        border: "border-indigo-500/20",
        image: "https://images.unsplash.com/photo-1550508016-527e532a264a?w=800&q=80" 
    },
    { 
        id: 14, 
        name: "Debating Society", 
        full: "Literary & Debate", 
        type: "Cultural", 
        members: 80, 
        icon: MessageSquare, 
        color: "text-white", 
        bg: "bg-white/10", 
        border: "border-white/20",
        image: "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&q=80" 
    },
    { 
        id: 15, 
        name: "Dance Crew", 
        full: "Hip-Hop & Contemporary", 
        type: "Cultural", 
        members: 110, 
        icon: Music, 
        color: "text-rose-400", 
        bg: "bg-rose-900/20", 
        border: "border-rose-500/20",
        image: "https://images.unsplash.com/photo-1547153760-18fc86324498?w=800&q=80" 
    },
  ];

  return (
    <div className="min-h-screen bg-black text-white font-sans selection:bg-ubLime selection:text-black overflow-x-hidden">
      <Navbar />
      
      <div className="pt-32 pb-20 px-6 md:px-12 max-w-7xl mx-auto">
        {/* Animated Header */}
        <motion.div 
          initial={{ opacity: 0, y: 50 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, ease: "easeOut" }}
          className="mb-20 text-center relative"
        >
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-ubLime/10 rounded-full blur-[120px] pointer-events-none animate-pulse" />
            <div className="absolute top-0 right-20 w-32 h-32 bg-ubViolet/20 rounded-full blur-[80px] pointer-events-none" />

            <h1 className="text-6xl md:text-8xl font-black mb-6 tracking-tighter relative z-10">
                THE <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet">CLOUT</span> LIST
            </h1>
            <p className="text-xl md:text-2xl text-gray-400 max-w-2xl mx-auto font-medium leading-relaxed">
                Connect with the <span className="text-white font-bold">Powerhouses</span> of Campus Culture. 
                <br />From Tech Wizards to Track Dominators.
            </p>
        </motion.div>

        {/* Categories Scroller (Horizontal) */}
        <motion.div 
            initial={{ opacity: 0, x: -100 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.5 }}
            className="flex gap-4 overflow-x-auto pb-8 mb-8 no-scrollbar touch-pan-x justify-center"
        >
            {["All", "Tech", "Motorsports", "Robotics", "Cultural"].map((cat, i) => (
                <button 
                    key={i} 
                    onClick={() => setActiveCategory(cat)}
                    className={`px-6 py-2 rounded-full border transition-all font-bold uppercase tracking-wider whitespace-nowrap 
                        ${activeCategory === cat 
                            ? 'bg-ubLime text-black border-ubLime' 
                            : 'border-white/10 bg-white/5 hover:bg-ubLime hover:text-black hover:border-ubLime'
                        }`}
                >
                    {cat}
                </button>
            ))}
        </motion.div>

        {/* Clubs Grid with New "Logo/Image" Layout */}
        <motion.div 
            variants={container}
            initial="hidden"
            whileInView="show"
            viewport={{ once: true, margin: "-100px" }}
            className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8"
        >
            {clubs.filter(club => activeCategory === "All" || club.type === activeCategory).map((club) => (
                <motion.div
                    key={club.id}
                    onClick={() => navigate(`/clubs/${club.id}`)}
                    layout // Add layout prop for smooth reordering animation
                    variants={item}
                    whileHover={{ y: -10, scale: 1.01 }}
                    className={`group relative h-[28rem] rounded-[2rem] border ${club.border} bg-[#0A0A0A] overflow-hidden flex flex-col cursor-pointer`}
                >
                    {/* Top Image Section (50%) */}
                    <div className="relative h-1/2 overflow-hidden">
                        <div className="absolute inset-0 bg-gray-900 animate-pulse z-0" /> {/* Placeholder loading skeleton */}
                        <img 
                            src={club.image} 
                            alt={club.name}
                            className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 relative z-10"
                        />
                        {/* Gradient Overlay for text readability at merge point */}
                        <div className="absolute inset-x-0 bottom-0 h-20 bg-gradient-to-t from-[#0A0A0A] to-transparent z-20" />
                        
                        {/* Type Badge - Top Right */}
                         <div className="absolute top-4 right-4 px-3 py-1.5 rounded-full bg-black/60 backdrop-blur-md border border-white/10 z-30">
                            <span className="text-[10px] font-black uppercase tracking-[0.2em] text-gray-300">{club.type}</span>
                        </div>
                    </div>

                    {/* Bottom Content Section (50%) */}
                    <div className="h-1/2 p-6 pt-10 flex flex-col justify-between relative bg-[#0A0A0A]">
                        
                        {/* Floating Logo Overlay */}
                        <div className={`absolute -top-10 left-6 w-20 h-20 rounded-2xl bg-[#0A0A0A] border-4 border-[#0A0A0A] shadow-xl overflow-hidden z-30 flex items-center justify-center ${club.bg}`}>
                            <club.icon size={32} className={club.color} />
                        </div>

                        <div className="mt-4">
                            <h3 className="text-2xl font-black text-white leading-tight mb-2 tracking-tight group-hover:text-transparent group-hover:bg-clip-text group-hover:bg-gradient-to-r group-hover:from-white group-hover:to-gray-400 transition-all">
                                {club.name}
                            </h3>
                            <p className="text-sm font-medium text-gray-500 line-clamp-2">{club.full}</p>
                        </div>
                        
                        {/* Footer Info */}
                        <div className="flex items-center justify-between border-t border-white/5 pt-4 mt-auto">
                            <div className="flex items-center gap-2">
                                <Users size={16} className="text-ubLime" />
                                <span className="text-sm font-bold text-gray-300">{club.members} Members</span>
                            </div>
                            <motion.button 
                                whileHover={{ x: 5 }}
                                className={`w-10 h-10 rounded-full bg-white/5 ${club.color} border border-white/5 flex items-center justify-center hover:bg-white hover:text-black transition-colors`}
                            >
                                <ArrowUpRight size={20} strokeWidth={2.5} />
                            </motion.button>
                        </div>
                    </div>

                    {/* Experimental "Noise" Overlay for Gen-Z feel */}
                    <div className="absolute inset-0 opacity-[0.03] pointer-events-none bg-[url('https://grainy-gradients.vercel.app/noise.svg')]" />
                </motion.div>
            ))}
        </motion.div>
      </div>
    </div>
  );
};

export default ClubsPage;
