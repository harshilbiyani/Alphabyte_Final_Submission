import React from 'react';
import { motion } from 'framer-motion';
import { Radar, RadarChart, PolarGrid, PolarAngleAxis, ResponsiveContainer, Tooltip } from 'recharts';
import { Trophy, Zap, TrendingUp, Gift, Lock, Star } from 'lucide-react';
import Navbar from '../../home/Navbar';
import { useUser } from '../../../context/UserContext';

// --- MOCK DATA ---
const ORGANIZER_STATS = [
  { subject: 'Hype', A: 120, fullMark: 150 },
  { subject: 'Budget', A: 98, fullMark: 150 },
  { subject: 'Footfall', A: 86, fullMark: 150 },
  { subject: 'Ops', A: 99, fullMark: 150 },
  { subject: 'Innovation', A: 85, fullMark: 150 },
  { subject: 'Eco', A: 65, fullMark: 150 },
];

const REWARDS = [
  { id: 1, title: 'Domino’s Pizza Party', cost: 500, type: 'Food', img: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&q=80&w=400', locked: false },
  { id: 2, title: 'Canva Pro (3 Months)', cost: 800, type: 'Tech', img: 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?auto=format&fit=crop&q=80&w=400', locked: false },
  { id: 3, title: 'RedBull Crate (x24)', cost: 1200, type: 'Energy', img: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&q=80&w=400', locked: false },
  { id: 4, title: 'Marshall Bluetooth Speaker', cost: 5000, type: 'Gadget', img: 'https://images.unsplash.com/photo-1612144431180-2d67277955dd?auto=format&fit=crop&q=80&w=400', locked: true },
  { id: 5, title: 'WeWork Day Pass', cost: 750, type: 'Workspace', img: 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80&w=400', locked: false },
  { id: 6, title: 'Spotify Premium (Yearly)', cost: 1500, type: 'Music', img: 'https://images.unsplash.com/photo-1614680376593-902f74cf0d41?auto=format&fit=crop&q=80&w=400', locked: true },
];

const BuzzPerksPage = () => {
    const { currentUser } = useUser();

  return (
    <div className="min-h-screen bg-black text-white font-sans overflow-x-hidden selection:bg-ubViolet selection:text-white">
      <Navbar />

      <div className="pt-32 pb-20 px-6 max-w-7xl mx-auto">
        
        {/* --- HEADER: GAMIFIED --- */}
        <div className="flex flex-col md:flex-row justify-between items-end mb-16 gap-8">
          <div>
            <div className="flex items-center gap-2 mb-2">
                <span className="px-3 py-1 rounded-full border border-ubViolet/30 bg-ubViolet/10 text-ubViolet text-xs font-bold uppercase tracking-wider inline-block">
                Organizer Loyalty Program
                </span>
                <span className="px-3 py-1 rounded-full border border-ubLime/30 bg-ubLime/10 text-ubLime text-xs font-bold uppercase tracking-wider inline-block">
                Level 12
                </span>
            </div>
            <h1 className="text-6xl md:text-8xl font-black tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-white via-indigo-200 to-indigo-400">
              BUZZ<span className="text-ubViolet italic">COINS</span>
            </h1>
          </div>

          {/* TOTAL POINTS CARD */}
          <motion.div 
            whileHover={{ scale: 1.05 }}
            className="bg-zinc-900/80 backdrop-blur-xl border border-ubViolet/50 p-6 rounded-3xl flex items-center gap-6 shadow-[0_0_40px_rgba(125,57,235,0.2)]"
          >
            <div className="p-4 bg-ubViolet/20 rounded-2xl text-ubViolet border border-ubViolet/20">
              <Zap size={32} fill="currentColor" />
            </div>
            <div>
              <p className="text-zinc-400 text-xs font-bold uppercase tracking-widest">Available Balance</p>
              <p className="text-5xl font-black font-mono text-white tracking-tight">2,450 <span className="text-lg text-ubViolet font-sans font-bold">XP</span></p>
            </div>
          </motion.div>
        </div>

        {/* --- SECTION 1: THE HUD (Stats) --- */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-20">
          
          {/* LEFT: VISUALIZATION (Radar Chart) */}
          <div className="lg:col-span-2 bg-zinc-900/50 border border-zinc-800 rounded-[2rem] p-8 relative overflow-hidden group">
            <div className="absolute top-0 right-0 p-4 opacity-50">
                <Trophy size={120} className="text-zinc-800 rotate-12" />
            </div>
            <h3 className="text-2xl font-black mb-6 flex items-center gap-2 relative z-10">
              <TrendingUp className="text-ubLime" /> Performance Matrix
            </h3>
            
            <div className="h-[350px] w-full flex items-center justify-center relative z-10">
              <ResponsiveContainer width="100%" height="100%">
                <RadarChart cx="50%" cy="50%" outerRadius="75%" data={ORGANIZER_STATS}>
                  <PolarGrid stroke="#3f3f46" />
                  <PolarAngleAxis dataKey="subject" tick={{ fill: '#a1a1aa', fontSize: 12, fontWeight: 'bold' }} />
                  <Radar
                    name="Performance"
                    dataKey="A"
                    stroke="#7D39EB"
                    strokeWidth={4}
                    fill="#7D39EB"
                    fillOpacity={0.4}
                  />
                  <Tooltip 
                    contentStyle={{ backgroundColor: '#000', border: '1px solid #333' }}
                    itemStyle={{ color: '#C6FF33' }}
                  />
                </RadarChart>
              </ResponsiveContainer>
            </div>
            
            {/* Gen-Z Decoration */}
            <div className="absolute bottom-4 left-4 text-[10px] text-zinc-600 font-mono">
               SYS.ANALYSIS.V2 // OPTIMIZED
            </div>
          </div>

          {/* RIGHT: KPIS */}
          <div className="grid grid-rows-3 gap-4"> 
            {[
              { label: 'Events Executed', val: '12', sub: '+2 this month', color: 'text-cyan-400', border: 'border-cyan-400/20', bg: 'bg-cyan-400/5' },
              { label: 'Efficiency Score', val: '94%', sub: 'Budget Optimization', color: 'text-ubLime', border: 'border-ubLime/20', bg: 'bg-ubLime/5' },
              { label: 'Avg Brand Reach', val: '8.4k', sub: 'Impressions/event', color: 'text-pink-400', border: 'border-pink-400/20', bg: 'bg-pink-400/5' }
            ].map((stat, i) => (
              <motion.div 
                key={i}
                whileHover={{ x: 5 }}
                className={`bg-zinc-900 border ${stat.border} rounded-[2rem] p-6 flex flex-col justify-center relative overflow-hidden group transition-all hover:bg-zinc-800`}
              >
                <div className={`absolute -right-4 -top-4 w-24 h-24 ${stat.bg} rounded-full blur-2xl transition-all`} />
                <h4 className={`text-4xl font-black ${stat.color}`}>{stat.val}</h4>
                <p className="text-white font-bold text-lg">{stat.label}</p>
                <div className="flex items-center gap-2 mt-2">
                    <div className={`w-1.5 h-1.5 rounded-full ${stat.color.replace('text-', 'bg-')}`}></div>
                    <p className="text-xs text-zinc-500 font-mono uppercase tracking-wider">{stat.sub}</p>
                </div>
              </motion.div>
            ))}
          </div>
        </div>

        {/* --- SECTION 2: THE MARKETPLACE (Coupons) --- */}
        <div className="flex items-end gap-4 mb-10">
          <Gift className="text-ubViolet w-10 h-10" />
          <div>
            <h2 className="text-4xl font-black uppercase tracking-tight">Loot Stash</h2>
            <p className="text-zinc-500 font-medium">Redeem your hard-earned XP for real rewards.</p>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {REWARDS.map((item) => (
             <motion.div
               key={item.id}
               initial={{ opacity: 0, y: 20 }}
               whileInView={{ opacity: 1, y: 0 }}
               viewport={{ once: true }}
               whileHover={{ y: -10 }}
               className={`group relative bg-[#0A0A0A] rounded-[2rem] overflow-hidden border ${item.locked ? 'border-zinc-800' : 'border-zinc-800 hover:border-ubViolet'} transition-all duration-300 shadow-xl`}
             >
               {/* Image Area */}
               <div className="h-56 w-full relative overflow-hidden">
                 <img src={item.img} alt={item.title} className={`w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 ${item.locked ? 'grayscale' : ''}`} />
                 <div className="absolute inset-0 bg-gradient-to-t from-[#0A0A0A] via-transparent to-transparent" />
                 
                 {/* Type Badge */}
                 <div className="absolute top-4 left-4 bg-black/60 backdrop-blur-md px-3 py-1.5 rounded-xl text-xs font-bold text-white border border-white/10 flex items-center gap-1.5">
                   <Star size={10} className="text-ubLime" fill="#C6FF33" /> {item.type}
                 </div>

                 {/* Lock Overlay */}
                 {item.locked && (
                     <div className="absolute inset-0 bg-black/50 backdrop-blur-[2px] flex items-center justify-center">
                         <div className="bg-black/80 p-3 rounded-full border border-zinc-700">
                            <Lock size={24} className="text-zinc-500" />
                         </div>
                     </div>
                 )}
               </div>

               {/* Content */}
               <div className="p-8 pt-2">
                 <h3 className={`text-2xl font-bold leading-tight mb-4 ${item.locked ? 'text-zinc-500' : 'text-white group-hover:text-ubViolet transition-colors'}`}>{item.title}</h3>
                 
                 <div className="flex items-center justify-between mt-auto pt-4 border-t border-zinc-800">
                    <div className={`flex items-center gap-1.5 font-mono font-bold text-lg ${item.locked ? 'text-zinc-600' : 'text-ubViolet'}`}>
                      <Zap size={18} fill="currentColor" />
                      {item.cost}
                    </div>

                    <button 
                      disabled={item.locked}
                      className={`px-6 py-2.5 rounded-xl font-bold text-xs uppercase tracking-wider transition-all ${
                        item.locked 
                        ? 'bg-zinc-900 text-zinc-600 cursor-not-allowed'
                        : 'bg-white text-black hover:bg-ubViolet hover:text-white shadow-lg shadow-ubViolet/20'
                      }`}
                    >
                      {item.locked ? 'Locked' : 'Clarim'}
                    </button>
                 </div>
               </div>
             </motion.div>
          ))}
        </div>

      </div>
    </div>
  );
};

export default BuzzPerksPage;