import React, { useState, useEffect } from 'react';
import Navbar from '../../home/Navbar';
import { motion, AnimatePresence, animate } from 'framer-motion';
import { 
    Plus, 
    Users, 
    Ticket,
    Flame,
    Zap,
    MoreVertical
} from 'lucide-react';

const EVENTS = [
  { id: 1, title: 'HackOverflow', status: 'live', registrations: 450, capacity: 500, budget: 100000, spent: 45000, stage: 3, onSpot: true },
  { id: 2, title: 'Debate Club Meet', status: 'planning', registrations: 0, capacity: 100, budget: 5000, spent: 200, stage: 1, onSpot: false },
  { id: 3, title: 'Tech Symposium', status: 'completed', registrations: 800, capacity: 800, budget: 200000, spent: 195000, stage: 4, onSpot: true },
];

const STAGES = ['Planning', 'Approval', 'Registration', 'Live', 'Post-Event'];

const Counter = ({ from, to }) => {
    const nodeRef = React.useRef();

    useEffect(() => {
        const node = nodeRef.current;
        const controls = animate(from, to, {
            duration: 1.5,
            onUpdate(value) {
                if (node) node.textContent = value.toFixed(0);
            }
        });
        return () => controls.stop();
    }, [from, to]);

    return <span ref={nodeRef} />;
};

const CircularProgress = ({ value, color, icon: Icon }) => {
    const circumference = 2 * Math.PI * 40;
    const strokeDashoffset = circumference - (value / 100) * circumference;

    return (
        <div className="relative w-24 h-24 flex items-center justify-center group/circle">
            <svg className="transform -rotate-90 w-full h-full">
                <circle cx="48" cy="48" r="40" stroke="currentColor" strokeWidth="8" fill="transparent" className="text-zinc-800" />
                <circle 
                    cx="48" cy="48" r="40" 
                    stroke="currentColor" 
                    strokeWidth="8" 
                    fill="transparent" 
                    strokeDasharray={circumference} 
                    strokeDashoffset={strokeDashoffset}
                    className={`${color} transition-all duration-1000 ease-out`}
                    strokeLinecap="round"
                />
            </svg>
            <div className="absolute inset-0 flex items-center justify-center text-white group-hover/circle:scale-110 transition-transform">
                <Icon size={24} />
            </div>
        </div>
    );
};

const CreateEventModal = ({ onClose }) => {
    const [isOnSpotAllowed, setIsOnSpotAllowed] = useState(false);

    return (
        <div className="fixed inset-0 bg-black/90 backdrop-blur-xl z-50 flex items-center justify-center p-4">
            <motion.div 
                initial={{ scale: 0.9, opacity: 0, y: 50 }}
                animate={{ scale: 1, opacity: 1, y: 0 }}
                className="bg-zinc-900 border border-zinc-800 p-8 rounded-3xl w-full max-w-lg shadow-[0_0_50px_rgba(59,130,246,0.2)] relative overflow-hidden"
            >
                <div className="absolute top-0 right-0 w-64 h-64 bg-blue-500/10 rounded-full blur-[80px] pointer-events-none" />
                
                <div className="flex justify-between items-center mb-8 relative z-10">
                    <h2 className="text-3xl font-black italic tracking-tighter bg-gradient-to-r from-blue-400 to-cyan-300 bg-clip-text text-transparent">
                        INITIATE PROTOCOL
                    </h2>
                    <button onClick={onClose} className="p-2 rounded-full hover:bg-zinc-800 transition-colors">
                        <Plus className="rotate-45 text-zinc-400" />
                    </button>
                </div>

                <div className="space-y-6 relative z-10">
                    <div className="group">
                        <label className="block text-blue-400 text-xs font-mono mb-2 uppercase tracking-widest">Operation Codename</label>
                        <input type="text" className="w-full bg-black/50 border border-zinc-800 rounded-xl p-4 text-white focus:outline-none focus:border-blue-500 transition-all font-bold text-lg" placeholder="HACKATHON_V2" />
                    </div>

                    <div className="grid grid-cols-2 gap-4">
                        <div>
                             <label className="block text-blue-400 text-xs font-mono mb-2 uppercase tracking-widest">T-Minus (Date)</label>
                             <input type="date" className="w-full bg-black/50 border border-zinc-800 rounded-xl p-4 text-white focus:outline-none focus:border-blue-500 transition-all" />
                        </div>
                        <div>
                             <label className="block text-blue-400 text-xs font-mono mb-2 uppercase tracking-widest">Sync Time</label>
                             <input type="time" className="w-full bg-black/50 border border-zinc-800 rounded-xl p-4 text-white focus:outline-none focus:border-blue-500 transition-all" />
                        </div>
                    </div>

                    <div className="bg-blue-900/10 border border-blue-500/20 p-4 rounded-xl flex items-center justify-between">
                        <div>
                            <h4 className="font-bold text-white flex items-center gap-2"><Zap size={16} className="text-yellow-400" /> On-Spot Gate</h4>
                            <p className="text-blue-200/50 text-xs mt-1">Allow walk-in signals?</p>
                        </div>
                        <button 
                            onClick={() => setIsOnSpotAllowed(!isOnSpotAllowed)}
                            className={`w-14 h-8 rounded-full p-1 transition-all duration-300 ${isOnSpotAllowed ? 'bg-blue-500 shadow-[0_0_15px_rgba(59,130,246,0.6)]' : 'bg-zinc-800'}`}
                        >
                            <motion.div 
                                animate={{ x: isOnSpotAllowed ? 24 : 0 }}
                                className="w-6 h-6 bg-white rounded-full shadow-lg"
                            />
                        </button>
                    </div>

                    <button 
                        onClick={onClose}
                        className="w-full py-4 bg-gradient-to-r from-blue-600 to-cyan-500 text-white font-black text-lg tracking-widest rounded-xl hover:shadow-[0_0_30px_rgba(6,182,212,0.4)] transition-all hover:scale-[1.02] mt-4 uppercase border border-white/10"
                    >
                        Start Sequence
                    </button>
                </div>
            </motion.div>
        </div>
    );
};

const LiveLifecycle = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);

  return (
    <div className="min-h-screen bg-[#050505] text-white selection:bg-cyan-500/30 font-sans">
      <Navbar />
      
      {isModalOpen && <CreateEventModal onClose={() => setIsModalOpen(false)} />}

      <div className="pt-32 px-6 container mx-auto pb-20">
        <div className="flex flex-col md:flex-row justify-between items-end mb-16 gap-6">
            <div>
                <motion.div 
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 text-xs font-mono mb-4"
                >
                    <span className="w-2 h-2 rounded-full bg-blue-500 animate-pulse" />
                    SYSTEM ONLINE
                </motion.div>
                <h1 className="text-5xl md:text-7xl font-black mb-2 bg-gradient-to-r from-white via-blue-200 to-blue-500 bg-clip-text text-transparent italic tracking-tighter">
                  MISSION CONTROL
                </h1>
                <p className="text-zinc-400 text-lg max-w-md">Oversee operational heartbeat. Track lifecycles in real-time.</p>
            </div>
            <button 
                onClick={() => setIsModalOpen(true)}
                className="px-8 py-4 bg-white text-black font-black uppercase tracking-wider rounded-xl hover:bg-blue-50 transition-all hover:shadow-[0_0_20px_white] flex items-center gap-2"
            >
                <Plus size={24} /> Initiate Event
            </button>
        </div>

        <div className="space-y-8">
            {EVENTS.map((event, index) => (
                <motion.div 
                    key={event.id}
                    initial={{ opacity: 0, y: 30 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: index * 0.1 }}
                    className="bg-[#0A0A0A] border border-white/5 rounded-[2rem] p-1 relative group overflow-hidden"
                >
                    {/* Living Gradient Check */}
                    <div className={`absolute inset-0 bg-gradient-to-r ${
                        event.status === 'live' ? 'from-blue-600 via-cyan-500 to-transparent' : 'from-zinc-800 to-transparent'
                    } opacity-0 group-hover:opacity-10 transition-opacity duration-500`} />
                    
                    {/* Content Container */}
                    <div className="bg-[#0A0A0A] rounded-[1.8rem] p-8 md:p-10 relative z-10 h-full flex flex-col md:flex-row gap-10">
                        {/* Left Info */}
                        <div className="flex-1">
                             <div className="flex items-start justify-between mb-8">
                                <div>
                                    <div className="flex items-center gap-3 mb-3">
                                        <h3 className="text-3xl font-bold text-white tracking-tight">{event.title}</h3>
                                        {event.status === 'live' && (
                                            <span className="flex items-center gap-1.5 px-3 py-1 rounded-full bg-blue-500 text-black text-[10px] font-black uppercase tracking-wider animate-pulse shadow-[0_0_10px_rgba(59,130,246,0.8)]">
                                                LIVE NOW
                                            </span>
                                        )}
                                    </div>
                                    <div className="flex gap-4 text-zinc-500 text-sm font-mono">
                                        <span className="flex items-center gap-2 bg-white/5 px-3 py-1 rounded-lg">
                                            <Ticket size={14} className="text-blue-400"/> ID: #{event.id}00X
                                        </span>
                                    </div>
                                </div>
                             </div>

                             {/* Timeline */}
                             <div className="relative pt-6 pb-2">
                                <div className="absolute top-[2.2rem] left-0 w-full h-[2px] bg-zinc-800 rounded-full" />
                                <motion.div 
                                    className="absolute top-[2.2rem] left-0 h-[2px] bg-blue-500 rounded-full box-shadow-[0_0_10px_blue]" 
                                    initial={{ width: 0 }}
                                    animate={{ width: `${(event.stage / (STAGES.length - 1)) * 100}%` }}
                                    transition={{ duration: 1.5, delay: 0.5 }}
                                />
                                
                                <div className="flex justify-between relative">
                                    {STAGES.map((stage, i) => {
                                        const isCompleted = i <= event.stage;
                                        const isCurrent = i === event.stage;
                                        
                                        return (
                                            <div key={stage} className="flex flex-col items-center gap-3 group/node">
                                                <div className={`w-3 h-3 rounded-full transition-all duration-500 relative z-10 ${
                                                    isCompleted 
                                                        ? 'bg-blue-400 shadow-[0_0_10px_rgba(96,165,250,0.8)]' 
                                                        : 'bg-zinc-800 border border-zinc-700'
                                                } ${isCurrent ? 'scale-150 ring-4 ring-blue-500/20' : ''}`} />
                                                <span className={`text-[10px] font-bold uppercase tracking-widest ${isCompleted ? 'text-blue-400' : 'text-zinc-700'} group-hover/node:text-white transition-colors`}>
                                                    {stage}
                                                </span>
                                            </div>
                                        );
                                    })}
                                </div>
                             </div>
                        </div>

                        {/* Right Stats (Circular Infographics) */}
                        <div className="w-full md:w-auto flex gap-6 items-center border-t md:border-t-0 md:border-l border-white/5 pt-8 md:pt-0 md:pl-10">
                             <div className="flex flex-col items-center gap-2">
                                <CircularProgress 
                                    value={(event.registrations / event.capacity) * 100} 
                                    color="text-emerald-400" 
                                    icon={Users}
                                />
                                <div className="text-center">
                                    <div className="text-2xl font-black text-white leading-none">
                                        <Counter from={0} to={event.registrations} />
                                    </div>
                                    <div className="text-[10px] uppercase font-bold text-zinc-500 mt-1">Sold</div>
                                </div>
                             </div>

                             <div className="flex flex-col items-center gap-2">
                                <CircularProgress 
                                    value={(event.spent / event.budget) * 100} 
                                    color="text-rose-500" 
                                    icon={Flame}
                                />
                                <div className="text-center">
                                    <div className="text-2xl font-black text-white leading-none">
                                        <Counter from={0} to={(event.spent/event.budget)*100} />%
                                    </div>
                                    <div className="text-[10px] uppercase font-bold text-zinc-500 mt-1">Burn</div>
                                </div>
                             </div>
                        </div>

                        {/* Action Tab */}
                        <div className="absolute top-8 right-8">
                             <button className="w-10 h-10 rounded-full bg-white/5 hover:bg-white/10 flex items-center justify-center transition-colors">
                                <MoreVertical size={18} className="text-zinc-400" />
                             </button>
                        </div>
                    </div>
                    
                    {/* Bottom Utility Bar */}
                    <div className="bg-[#0F0F0F] border-t border-white/5 p-4 flex gap-4">
                        <button className="flex-1 py-3 rounded-lg text-xs font-bold uppercase tracking-widest hover:bg-white/5 transition-colors text-zinc-400 hover:text-white">
                            View Logistics
                        </button>
                        <button className="flex-1 py-3 rounded-lg text-xs font-bold uppercase tracking-widest hover:bg-white/5 transition-colors text-zinc-400 hover:text-white">
                            Volunteer Map
                        </button>
                        {event.status === 'live' ? (
                            <button className="flex-1 py-3 rounded-lg bg-red-500/10 text-red-500 border border-red-500/20 text-xs font-bold uppercase tracking-widest hover:bg-red-500 hover:text-black transition-all">
                                Emergency Stop
                            </button>
                        ) : (
                             <button className="flex-1 py-3 rounded-lg bg-emerald-500/10 text-emerald-500 border border-emerald-500/20 text-xs font-bold uppercase tracking-widest hover:bg-emerald-500 hover:text-black transition-all">
                                Launch Ops
                            </button>
                        )}
                    </div>
                </motion.div>
            ))}
        </div>
      </div>
    </div>
  );
};

export default LiveLifecycle;
