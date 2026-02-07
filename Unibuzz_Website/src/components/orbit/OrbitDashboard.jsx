import React, { useState } from 'react';
import Navbar from '../home/Navbar';
import { motion, AnimatePresence } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { 
  Rocket, 
  Users, 
  Briefcase, 
  MoreVertical, 
  Search,
  PieChart,
  ArrowUpRight,
  Sparkles,
  Plus
} from 'lucide-react';

// Mock Data
const MOCK_OPPORTUNITIES = [
  { id: 1, title: 'Frontend Wizard', type: 'Internship', applicants: 142, status: 'Active', daysLeft: 5, salary: '₹15k - ₹25k' },
  { id: 2, title: 'Product Disruptor', type: 'Full-time', applicants: 89, status: 'Active', daysLeft: 12, salary: '₹8L - ₹12L' },
  { id: 3, title: 'Campus Ambassador', type: 'Program', applicants: 500, status: 'Closed', daysLeft: 0, salary: 'Performance Based' },
];

const OrbitDashboard = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-black text-white selection:bg-indigo-500/30">
      <Navbar />
      
      {/* Background Decor */}
      <div className="fixed inset-0 z-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[500px] h-[500px] bg-indigo-600/10 rounded-full blur-[120px]" />
        <div className="absolute bottom-0 left-0 w-[500px] h-[500px] bg-fuchsia-600/10 rounded-full blur-[120px]" />
      </div>

      <div className="relative z-10 pt-28 px-6 container mx-auto pb-20">
        
        {/* Header Section */}
        <div className="flex flex-col md:flex-row justify-between items-end mb-16 gap-6">
          <motion.div 
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
          >
            <div className="flex items-center gap-3 mb-2">
               <span className="px-3 py-1 rounded-full border border-indigo-500/30 bg-indigo-500/10 text-indigo-400 text-xs font-bold uppercase tracking-wider flex items-center gap-2">
                 <Rocket size={14} /> Corporate Nexus
               </span>
            </div>
            <h1 className="text-5xl md:text-7xl font-sans font-black tracking-tight leading-none bg-gradient-to-r from-white via-indigo-200 to-indigo-400 bg-clip-text text-transparent">
              Orbit<span className="text-indigo-500">.</span>
            </h1>
            <p className="text-zinc-500 text-lg mt-4 max-w-lg">
              Launch careers and scout top-tier talent from the university ecosystem.
            </p>
          </motion.div>

          <motion.button 
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={() => navigate('/orbit/create')}
            className="group px-8 py-4 bg-white text-black font-bold rounded-full shadow-[0_0_40px_-10px_rgba(255,255,255,0.3)] hover:shadow-[0_0_60px_-15px_rgba(255,255,255,0.5)] transition-all flex items-center gap-2"
          >
            <Sparkles className="text-indigo-600 group-hover:rotate-12 transition-transform" />
            <span>Launch Opportunity</span>
          </motion.button>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-16">
           {[
             { label: 'Total Reach', value: '45.2K', icon: Users, color: 'text-emerald-400', sub: '+12% this week' },
             { label: 'Active Pipeline', value: '231', icon: Briefcase, color: 'text-indigo-400', sub: 'Candidates in review' },
             { label: 'Conversion Rate', value: '4.8%', icon: PieChart, color: 'text-fuchsia-400', sub: 'Top 1% of industry' }
           ].map((stat, i) => (
             <motion.div
               key={i}
               initial={{ y: 20, opacity: 0 }}
               animate={{ y: 0, opacity: 1 }}
               transition={{ delay: i * 0.1 }}
               className="bg-zinc-900/40 border border-zinc-800 backdrop-blur-sm p-6 rounded-3xl hover:border-zinc-700 transition-colors group"
             >
                <div className="flex justify-between items-start mb-4">
                  <div className={`p-3 rounded-2xl bg-zinc-800/50 ${stat.color} group-hover:scale-110 transition-transform`}>
                    <stat.icon size={24} />
                  </div>
                  <ArrowUpRight className="text-zinc-600 group-hover:text-white transition-colors" />
                </div>
                <h3 className="text-4xl font-bold text-white mb-1">{stat.value}</h3>
                <div className="text-zinc-500 text-sm flex justify-between items-center">
                   <span>{stat.label}</span>
                   <span className="text-emerald-500/80 text-xs">{stat.sub}</span>
                </div>
             </motion.div>
           ))}
        </div>

        {/* Opportunities Deck */}
        <div className="mb-8 flex justify-between items-center">
            <h2 className="text-2xl font-bold text-white">Live Missions</h2>
            <div className="flex gap-2 text-zinc-500 hover:text-white cursor-pointer transition-colors text-sm">
                View Archived <ArrowUpRight size={16} />
            </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-6">
            {MOCK_OPPORTUNITIES.map((item, index) => (
                <motion.div
                    key={item.id}
                    layoutId={`card-${item.id}`}
                    onClick={() => navigate(`/orbit/applicants/${item.id}`)}
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ delay: 0.2 + (index * 0.1) }}
                    className="relative bg-zinc-900 border border-zinc-800 p-8 rounded-[2rem] cursor-pointer group hover:-translate-y-2 transition-transform duration-500 overflow-hidden"
                >
                    {/* Hover Glow */}
                    <div className="absolute inset-0 bg-gradient-to-br from-indigo-500/20 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
                    
                    <div className="relative z-10">
                        <div className="flex justify-between items-start mb-6">
                            <span className={`px-3 py-1 rounded-full text-xs font-bold border ${item.status === 'Active' ? 'bg-emerald-500/10 border-emerald-500/20 text-emerald-500' : 'bg-zinc-800 border-zinc-700 text-zinc-400'}`}>
                                {item.status === 'Active' ? '● LIVE' : 'ENDED'}
                            </span>
                            <MoreVertical onClick={(e) => {e.stopPropagation()}} className="text-zinc-600 hover:text-white transition-colors" />
                        </div>

                        <h3 className="text-2xl font-bold text-white mb-2 group-hover:text-indigo-400 transition-colors">{item.title}</h3>
                        <p className="text-zinc-500 mb-6 flex items-center gap-2">
                             {item.type} <span className="w-1 h-1 rounded-full bg-zinc-700" /> {item.salary}
                        </p>

                        <div className="flex items-center gap-4 pt-6 border-t border-zinc-800 group-hover:border-indigo-500/30 transition-colors">
                            <div className="flex -space-x-3">
                                {[1,2,3].map(i => (
                                    <div key={i} className="w-8 h-8 rounded-full border-2 border-zinc-900 bg-zinc-700 flex items-center justify-center text-[10px] text-zinc-300">
                                        UA
                                    </div>
                                ))}
                            </div>
                            <span className="text-white font-bold">{item.applicants} <span className="font-normal text-zinc-500">Applicants</span></span>
                        </div>
                    </div>
                </motion.div>
            ))}

            {/* Create New Card */}
            <motion.div
                onClick={() => navigate('/orbit/create')}
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ delay: 0.5 }}
                className="relative border-2 border-dashed border-zinc-800 rounded-[2rem] p-8 flex flex-col items-center justify-center text-zinc-600 hover:text-indigo-400 hover:border-indigo-500/50 hover:bg-indigo-500/5 cursor-pointer transition-all duration-300 min-h-[300px]"
            >
                <div className="w-16 h-16 rounded-full bg-zinc-900 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                    <Plus size={32} />
                </div>
                <h3 className="text-xl font-bold">New Mission</h3>
                <p className="text-sm opacity-60">Create Job or Internship</p>
            </motion.div>
        </div>

      </div>
    </div>
  );
};

export default OrbitDashboard;
