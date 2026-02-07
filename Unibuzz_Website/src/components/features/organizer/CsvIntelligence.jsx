import React, { useState } from 'react';
import Navbar from '../../home/Navbar';
import { motion, AnimatePresence } from 'framer-motion';
import { FileSpreadsheet, Filter, Download, Mail, Search, ChevronDown, Check, ArrowLeft, Users, Database } from 'lucide-react';

const EVENTS = [
  { id: 1, title: 'HackOverflow', type: 'Hackathon', participants: 450, color: 'from-orange-500 to-red-500' },
  { id: 2, title: 'Debate Club Meet', type: 'Meetup', participants: 50, color: 'from-blue-500 to-indigo-500' },
  { id: 3, title: 'Tech Symposium', type: 'Seminar', participants: 800, color: 'from-emerald-500 to-teal-500' },
];

const INITIAL_DATA = [
  { id: 1, name: "Aarav Sharma", email: "aarav@example.com", dept: "ENTC", year: "TY", status: "Present" },
  { id: 2, name: "Sneha Patel", email: "sneha@example.com", dept: "COMP", year: "BE", status: "Absent" },
  { id: 3, name: "Rohan Gupta", email: "rohan@example.com", dept: "IT", year: "SY", status: "Present" },
  { id: 4, name: "Ishaan Kumar", email: "ishaan@example.com", dept: "ENTC", year: "TY", status: "Present" },
  { id: 5, name: "Priya Singh", email: "priya@example.com", dept: "COMP", year: "TE", status: "Present" },
  { id: 6, name: "Vivaan Shah", email: "vivaan@example.com", dept: "IT", year: "BE", status: "Present" },
  { id: 7, name: "Ananya Das", email: "ananya@example.com", dept: "ENTC", year: "SY", status: "Present" },
  { id: 8, name: "Kabir Mehta", email: "kabir@example.com", dept: "COMP", year: "TY", status: "Absent" },
];

const CsvIntelligence = () => {
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [data, setData] = useState(INITIAL_DATA);
  const [sortBy, setSortBy] = useState('global'); // global, dept, year

  const handleSort = (type) => {
    setSortBy(type);
    let sorted = [...data];
    if (type === 'dept') {
      sorted.sort((a, b) => a.dept.localeCompare(b.dept));
    } else if (type === 'year') {
      sorted.sort((a, b) => a.year.localeCompare(b.year));
    } else {
      sorted = INITIAL_DATA;
    }
    setData(sorted);
  };

  const getGroupedData = () => {
    if (sortBy === 'global') return { "All Participants": data };
    
    return data.reduce((acc, item) => {
      const key = sortBy === 'dept' ? item.dept : item.year;
      if (!acc[key]) acc[key] = [];
      acc[key].push(item);
      return acc;
    }, {});
  };

  const groupedData = getGroupedData();

  return (
    <div className="min-h-screen bg-black text-white selection:bg-orange-500/30">
      <Navbar />

      <div className="pt-32 px-6 container mx-auto pb-20">
        <AnimatePresence mode="wait">
            {!selectedEvent ? (
                <motion.div 
                    key="event-list"
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0, x: -50 }}
                >
                    <div className="mb-12">
                        <span className="px-3 py-1 rounded-full bg-orange-500/10 border border-orange-500/20 text-orange-500 text-xs font-bold uppercase tracking-widest mb-4 inline-block">
                            Data Alchemy
                        </span>
                        <h1 className="text-6xl font-black mb-4 bg-gradient-to-r from-orange-400 to-red-600 bg-clip-text text-transparent">
                            CSV Intelligence
                        </h1>
                        <p className="text-xl text-zinc-400">Select an event to run advanced sorting and analytics.</p>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                        {EVENTS.map((event, index) => (
                            <motion.div
                                key={event.id}
                                initial={{ y: 20, opacity: 0 }}
                                animate={{ y: 0, opacity: 1 }}
                                transition={{ delay: index * 0.1 }}
                                onClick={() => setSelectedEvent(event)}
                                className="group cursor-pointer bg-zinc-900 border border-zinc-800 p-8 rounded-[2rem] hover:border-orange-500/50 transition-all hover:-translate-y-2 relative overflow-hidden"
                            >
                                <div className={`absolute inset-0 bg-gradient-to-br ${event.color} opacity-0 group-hover:opacity-10 transition-opacity duration-500`} />
                                
                                <div className="mb-8">
                                    <div className={`w-14 h-14 rounded-2xl bg-gradient-to-br ${event.color} flex items-center justify-center text-white mb-6 shadow-lg`}>
                                        <Database size={24} />
                                    </div>
                                    <h3 className="text-3xl font-bold text-white mb-2">{event.title}</h3>
                                    <span className="px-3 py-1 rounded-md bg-zinc-800 text-zinc-400 text-xs font-mono uppercase tracking-widest">
                                        {event.type}
                                    </span>
                                </div>

                                <div className="flex justify-between items-center pt-8 border-t border-zinc-800">
                                    <div className="flex items-center gap-2 text-zinc-400">
                                        <Users size={16} />
                                        <span className="font-bold">{event.participants} Records</span>
                                    </div>
                                    <div className="w-10 h-10 rounded-full border border-zinc-700 flex items-center justify-center group-hover:bg-white group-hover:text-black transition-all">
                                        <Users size={16} />
                                    </div>
                                </div>
                            </motion.div>
                        ))}
                    </div>
                </motion.div>
            ) : (
                <motion.div
                    key="data-view"
                    initial={{ opacity: 0, x: 50 }}
                    animate={{ opacity: 1, x: 0 }}
                    exit={{ opacity: 0 }}
                >
                    {/* Header */}
                    <div className="flex flex-col md:flex-row justify-between items-start md:items-end mb-8 gap-4">
                        <div>
                            <button 
                                onClick={() => setSelectedEvent(null)}
                                className="flex items-center gap-2 text-zinc-400 hover:text-white mb-6 transition-colors font-bold uppercase tracking-wide text-sm"
                            >
                                <ArrowLeft size={16} /> Back to Events
                            </button>
                            <h2 className="text-4xl font-bold mb-2 flex items-center gap-4">
                                {selectedEvent.title} <span className="text-base font-normal text-zinc-500 bg-zinc-900 px-3 py-1 rounded-lg">DATA VIEW</span>
                            </h2>
                            <p className="text-zinc-400">Managing {selectedEvent.participants} participant records.</p>
                        </div>

                        <div className="flex gap-3">
                            <button className="px-6 py-3 bg-zinc-800 hover:bg-zinc-700 rounded-xl font-bold transition-all flex items-center gap-2">
                                <Mail size={18} /> Bulk Email
                            </button>
                            <button className="px-6 py-3 bg-white text-black hover:bg-orange-400 rounded-xl font-bold transition-all flex items-center gap-2 hover:shadow-lg">
                                <Download size={18} /> Export Processed CSV
                            </button>
                        </div>
                    </div>

                    {/* Toolbar */}
                    <div className="bg-zinc-900 border border-zinc-800 rounded-2xl p-4 mb-8 flex flex-col md:flex-row gap-4 justify-between items-center">
                        <div className="flex bg-black rounded-xl border border-zinc-800 p-1">
                            {['global', 'dept', 'year'].map((type) => (
                                <button
                                    key={type}
                                    onClick={() => handleSort(type)}
                                    className={`px-6 py-2 rounded-lg text-sm font-bold uppercase tracking-wider transition-all ${
                                        sortBy === type ? 'bg-orange-500 text-black shadow-lg' : 'text-zinc-500 hover:text-white'
                                    }`}
                                >
                                    By {type}
                                </button>
                            ))}
                        </div>
                        <div className="relative w-full md:w-auto">
                            <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-zinc-500" size={16} />
                            <input 
                                type="text" 
                                placeholder="Search records..." 
                                className="pl-10 pr-4 py-2 bg-black border border-zinc-800 rounded-lg text-sm text-white focus:outline-none focus:border-orange-500 w-full md:w-64"
                            />
                        </div>
                    </div>

                    {/* Dynamic Data Grid */}
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {Object.entries(groupedData).map(([groupName, groupItems], groupIndex) => (
                            <motion.div 
                                key={groupName}
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: groupIndex * 0.1 }}
                                className="bg-zinc-900/50 border border-zinc-800 rounded-3xl overflow-hidden flex flex-col h-[500px]"
                            >
                                <div className="p-6 bg-zinc-900 border-b border-zinc-800 flex justify-between items-center">
                                    <h3 className="text-lg font-bold text-white flex items-center gap-2">
                                        <div className="w-2 h-8 bg-orange-500 rounded-full" />
                                        {groupName}
                                    </h3>
                                    <span className="bg-zinc-800 px-2 py-1 rounded text-xs text-zinc-400 font-mono">{groupItems.length}</span>
                                </div>
                                
                                <div className="flex-1 overflow-y-auto p-4 space-y-2 custom-scrollbar">
                                    {groupItems.map((item, idx) => (
                                        <div key={item.id} className="bg-black/50 hover:bg-white/5 p-4 rounded-xl border border-zinc-800/50 transition-colors group">
                                            <div className="flex justify-between items-start mb-2">
                                                <div className="font-bold text-white">{item.name}</div>
                                                <div className={`w-2 h-2 rounded-full ${item.status === 'Present' ? 'bg-emerald-500' : 'bg-red-500'}`} />
                                            </div>
                                            <div className="text-xs text-zinc-500 font-mono mb-3">{item.email}</div>
                                            <div className="flex gap-2">
                                                <span className="bg-zinc-800 px-2 py-1 rounded text-[10px] text-zinc-400 uppercase">{item.dept}</span>
                                                <span className="bg-zinc-800 px-2 py-1 rounded text-[10px] text-zinc-400 uppercase">{item.year}</span>
                                            </div>
                                        </div>
                                    ))}
                                </div>

                                <div className="p-4 border-t border-zinc-800 bg-zinc-900/50">
                                    <button className="w-full py-3 bg-zinc-800 hover:bg-orange-500 hover:text-black rounded-xl text-xs font-bold uppercase tracking-widest transition-all">
                                        Export This Group
                                    </button>
                                </div>
                            </motion.div>
                        ))}
                    </div>
                </motion.div>
            )}
        </AnimatePresence>
      </div>
    </div>
  );
};

export default CsvIntelligence;
