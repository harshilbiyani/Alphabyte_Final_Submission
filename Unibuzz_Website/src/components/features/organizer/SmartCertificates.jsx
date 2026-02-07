import React, { useState } from 'react';
import Navbar from '../../home/Navbar';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { Award, Send, Edit, Check, Search, Layout, Type, Image as ImageIcon, PlusCircle, ArrowLeft, Save, ExternalLink } from 'lucide-react';


const EVENTS = [
  { id: 1, title: 'HackOverflow 2.0', status: 'Completed', recipients: 450, template: 'hackathon_v1' },
  { id: 2, title: 'Neon Nights Concert', status: 'Completed', recipients: 1200, template: 'concert_v2' },
  { id: 3, title: 'RoboWars', status: 'Pending', recipients: 80, template: 'default' },
];

const TEMPLATES = [
    { id: 1, name: "Modern Cyber", bg: "bg-zinc-900", border: "border-blue-500", text: "text-blue-500" },
    { id: 2, name: "Gold Prestige", bg: "bg-white", border: "border-yellow-500", text: "text-yellow-600" },
    { id: 3, name: "Minimalist", bg: "bg-zinc-100", border: "border-black", text: "text-black" },
];

const SmartCertificates = () => {
  const navigate = useNavigate();
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [activeTab, setActiveTab] = useState('templates'); // templates, text, graphics
  const [currentTemplate, setCurrentTemplate] = useState(TEMPLATES[0]);
  const [customText, setCustomText] = useState("CERTIFICATE OF EXCELLENCE");

  const handleSendAll = () => {
    // Logic to send certificates
  };

  return (
    <div className="min-h-screen bg-black text-white selection:bg-yellow-500/30">
      <Navbar />

      <div className="pt-32 px-6 container mx-auto pb-20">
        
        <AnimatePresence mode="wait">
        {!selectedEvent ? (
            <motion.div 
                key="dashboard"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                exit={{ opacity: 0, x: -50 }}
            >
                <div className="flex flex-col md:flex-row justify-between items-end mb-12 gap-6">
                    <div>
                        <span className="px-3 py-1 rounded-full bg-yellow-500/10 border border-yellow-500/20 text-yellow-500 text-xs font-bold uppercase tracking-widest mb-4 inline-block">
                            Credentials Engine
                        </span>
                        <h1 className="text-5xl font-black mb-2 bg-gradient-to-r from-yellow-400 to-orange-500 bg-clip-text text-transparent flex items-center gap-3">
                            <Award className="text-yellow-500" size={48} /> Cert Studio
                        </h1>
                        <p className="text-zinc-400">Design, customize, and issue blockchain-verified certificates.</p>
                    </div>
                    
                    <div className="relative w-full md:w-96">
                        <Search className="absolute left-4 top-1/2 -translate-y-1/2 text-zinc-500" size={18} />
                        <input 
                            type="text" 
                            placeholder="Search events..." 
                            className="w-full bg-zinc-900 border border-zinc-800 rounded-xl pl-12 pr-6 py-4 text-white focus:outline-none focus:border-yellow-500 transition-colors font-medium"
                        />
                    </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {EVENTS.map((event, index) => (
                        <motion.div
                            key={event.id}
                            initial={{ y: 20, opacity: 0 }}
                            animate={{ y: 0, opacity: 1 }}
                            transition={{ delay: index * 0.1 }}
                            onClick={() => setSelectedEvent(event)}
                            className="bg-zinc-900 border border-zinc-800 p-8 rounded-3xl cursor-pointer hover:border-yellow-500 transition-all group hover:-translate-y-2 relative overflow-hidden"
                        >
                             <div className="absolute inset-0 bg-gradient-to-br from-yellow-500/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                            
                            <div className="flex justify-between items-start mb-6">
                                <span className={`px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-widest border ${event.status === 'Completed' ? 'bg-zinc-800 border-zinc-700 text-zinc-400' : 'bg-yellow-500/10 border-yellow-500/20 text-yellow-500'}`}>
                                    {event.status}
                                </span>
                                <Edit size={18} className="text-zinc-500 group-hover:text-yellow-500 transition-colors" />
                            </div>

                            <h3 className="text-2xl font-bold mb-2 text-white">{event.title}</h3>
                            <p className="text-zinc-500 text-sm font-medium mb-6">
                                Total Recipients: <span className="text-white">{event.recipients}</span>
                            </p>

                            <div className="flex -space-x-3">
                                {[1,2,3,4].map(i => (
                                    <div key={i} className="w-8 h-8 rounded-full bg-zinc-800 border-2 border-zinc-900 flex items-center justify-center text-[10px] text-zinc-400">
                                        P{i}
                                    </div>
                                ))}
                                <div className="w-8 h-8 rounded-full bg-yellow-500 text-black border-2 border-zinc-900 flex items-center justify-center text-[10px] font-bold">
                                    +{event.recipients - 4}
                                </div>
                            </div>
                        </motion.div>
                    ))}
                </div>
            </motion.div>
        ) : (
            <motion.div
                key="studio"
                initial={{ opacity: 0, x: 50 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0 }}
                className="h-[calc(100vh-140px)] flex flex-col"
            >
                {/* Header */}
                <div className="flex justify-between items-center mb-6">
                    <button 
                         onClick={() => setSelectedEvent(null)}
                         className="flex items-center gap-2 text-zinc-400 hover:text-white transition-colors font-bold uppercase tracking-wide text-sm"
                    >
                        <ArrowLeft size={16} /> Exit Studio
                    </button>
                    <div className="flex gap-4">
                        <button 
                            onClick={() => navigate('/features/smart-cert-studio')}
                            className="px-6 py-2 bg-zinc-800 text-white rounded-lg font-bold hover:bg-zinc-700 transition-colors flex items-center gap-2 border border-white/10"
                        >
                             <ExternalLink size={16} /> Open Advanced Studio
                        </button>
                        <button className="px-6 py-2 bg-zinc-800 text-white rounded-lg font-bold hover:bg-zinc-700 transition-colors flex items-center gap-2">
                             <Save size={16} /> Save to Templates
                        </button>
                        <button className="px-6 py-2 bg-yellow-500 text-black rounded-lg font-bold hover:bg-yellow-400 transition-colors flex items-center gap-2">
                             <Send size={16} /> Issue Certificates
                        </button>
                    </div>
                </div>

                <div className="flex flex-1 gap-6 overflow-hidden">
                    {/* Sidebar Tools */}
                    <div className="w-80 bg-zinc-900 border border-zinc-800 rounded-3xl p-6 flex flex-col">
                        <div className="flex gap-2 mb-8 bg-black p-1 rounded-xl">
                            {['templates', 'text', 'graphics'].map(tab => (
                                <button
                                    key={tab}
                                    onClick={() => setActiveTab(tab)}
                                    className={`flex-1 py-2 rounded-lg text-xs font-bold uppercase tracking-wider transition-all ${
                                        activeTab === tab ? 'bg-zinc-800 text-white' : 'text-zinc-500 hover:text-zinc-300'
                                    }`}
                                >
                                    {tab}
                                </button>
                            ))}
                        </div>

                        <div className="flex-1 overflow-y-auto pr-2 space-y-4">
                            {activeTab === 'templates' && TEMPLATES.map(t => (
                                <div 
                                    key={t.id}
                                    onClick={() => setCurrentTemplate(t)}
                                    className={`p-4 rounded-xl border-2 cursor-pointer transition-all ${
                                        currentTemplate.id === t.id ? 'border-yellow-500 bg-zinc-800' : 'border-zinc-800 hover:border-zinc-700'
                                    }`}
                                >
                                    <div className={`h-20 w-full rounded-lg mb-2 ${t.bg} border ${t.border} flex items-center justify-center`}>
                                        <div className={`text-[8px] ${t.text}`}>PREVIEW</div>
                                    </div>
                                    <div className="text-sm font-bold">{t.name}</div>
                                </div>
                            ))}

                            {activeTab === 'text' && (
                                <div className="space-y-4">
                                    <div>
                                        <label className="text-xs text-zinc-500 uppercase font-bold mb-2 block">Header Text</label>
                                        <input 
                                            value={customText}
                                            onChange={(e) => setCustomText(e.target.value)}
                                            className="w-full bg-black border border-zinc-800 rounded-lg p-3 text-sm focus:border-yellow-500 focus:outline-none"
                                        />
                                    </div>
                                    {/* Size controls simulation */}
                                    <div className="grid grid-cols-2 gap-2">
                                        <button className="p-3 bg-zinc-800 rounded-lg text-sm font-bold hover:bg-zinc-700">Bold</button>
                                        <button className="p-3 bg-zinc-800 rounded-lg text-sm font-serif hover:bg-zinc-700">Serif</button>
                                    </div>
                                </div>
                            )}
                        </div>
                    </div>

                    {/* Canvas Area */}
                    <div className="flex-1 bg-zinc-950 rounded-3xl border border-zinc-800 relative flex items-center justify-center overflow-hidden">
                        <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20 pointer-events-none" />
                        
                        {/* Interactive Certificate */}
                        <motion.div 
                            layout
                            className={`w-[800px] h-[566px] shadow-2xl relative p-12 flex flex-col items-center text-center transition-colors duration-500 ${currentTemplate.bg} border-[16px] ${currentTemplate.border}`}
                        >
                            <div className="flex-1 flex flex-col items-center justify-center w-full border-4 border-double border-opacity-20 border-current p-8">
                                <motion.h1 layout className={`text-5xl font-serif font-black mb-8 ${currentTemplate.text}`}>
                                    {customText}
                                </motion.h1>
                                <p className={`text-lg mb-8 opacity-60 ${currentTemplate.text === 'text-black' ? 'text-zinc-600' : 'text-zinc-400'}`}>
                                    This certificate is proudly presented to
                                </p>
                                <h2 className={`text-6xl font-script font-bold mb-8 ${currentTemplate.text}`}>
                                    Jane Doe
                                </h2>
                                <p className={`text-lg max-w-lg mx-auto opacity-70 mb-12 ${currentTemplate.text === 'text-black' ? 'text-zinc-600' : 'text-zinc-400'}`}>
                                    For outstanding performance and dedication at <span className="font-bold">{selectedEvent.title}</span>. Your contribution has been verified on the blockchain.
                                </p>

                                <div className="flex justify-between w-full px-20 mt-auto">
                                    <div className="flex flex-col items-center gap-2">
                                        <div className={`w-32 h-[2px] ${currentTemplate.text.replace('text-', 'bg-')}`} />
                                        <span className={`text-xs font-bold uppercase tracking-widest ${currentTemplate.text === 'text-black' ? 'text-zinc-800' : 'text-zinc-500'}`}>Organizer</span>
                                    </div>
                                    <div className="w-20 h-20 border-4 border-current opacity-20 rounded-full flex items-center justify-center">
                                        <Award size={32} className={currentTemplate.text} />
                                    </div>
                                    <div className="flex flex-col items-center gap-2">
                                        <div className={`w-32 h-[2px] ${currentTemplate.text.replace('text-', 'bg-')}`} />
                                        <span className={`text-xs font-bold uppercase tracking-widest ${currentTemplate.text === 'text-black' ? 'text-zinc-800' : 'text-zinc-500'}`}>Director</span>
                                    </div>
                                </div>
                            </div>
                        </motion.div>

                        <div className="absolute bottom-8 right-8 bg-zinc-900 px-4 py-2 rounded-full text-xs text-zinc-500 font-mono border border-zinc-800">
                            Canvas Resolution: 1920x1080
                        </div>
                    </div>
                </div>
            </motion.div>
        )}
        </AnimatePresence>

      </div>
    </div>
  );
};

export default SmartCertificates;
