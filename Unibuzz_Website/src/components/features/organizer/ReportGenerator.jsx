import React, { useState, useRef } from 'react';
import Navbar from '../../home/Navbar';
import { motion, AnimatePresence } from 'framer-motion';
import { ArrowLeft, Download, Users, DollarSign, Trophy, TrendingUp, Calendar, MapPin, ArrowRight, Activity, PieChart, Sparkles } from 'lucide-react';
import html2canvas from 'html2canvas';
import jsPDF from 'jspdf';

// Mock Data
const EVENTS = [
  {
    id: 1,
    title: "HackOverflow 2.0",
    date: "Feb 14, 2026",
    location: "Main Auditorium",
    registrations: 450,
    checkins: 412,
    revenue: 125000,
    budget: 80000,
    vibeScore: 98,
    demographics: {
      entc: 40,
      comp: 35,
      it: 15,
      other: 10
    },
    summary: "HackOverflow 2.0 was a massive success, exceeding attendance projections by 15%. The engagement levels peaked during the 12th hour of the hackathon, and sponsor satisfaction is at an all-time high."
  },
  {
    id: 2,
    title: "Neon Nights Concert",
    date: "Mar 01, 2026",
    location: "Sports Ground",
    registrations: 1200,
    checkins: 1150,
    revenue: 350000,
    budget: 200000,
    vibeScore: 100,
    demographics: {
      entc: 20,
      comp: 40,
      it: 30,
      other: 10
    },
    summary: "A spectacular evening of music and light. The Neon Nights Concert drew the largest crowd of the semester, generating record-breaking revenue for the student council."
  },
  {
    id: 3,
    title: "RoboWars Championship",
    date: "Jan 20, 2026",
    location: "Lab Complex",
    registrations: 80,
    checkins: 75,
    revenue: 40000,
    budget: 35000,
    vibeScore: 85,
    demographics: {
      entc: 60,
      comp: 10,
      it: 10,
      other: 20
    },
    summary: "Intense competition and technical brilliance marked the RoboWars Championship. While niche, the event attracted high-quality participation from engineering departments."
  }
];

const StatCard = ({ icon: Icon, label, value, color, delay }) => (
  <motion.div
    initial={{ scale: 0.8, opacity: 0 }}
    animate={{ scale: 1, opacity: 1 }}
    transition={{ delay, type: "spring" }}
    className="bg-zinc-900 border border-zinc-800 p-6 rounded-2xl flex flex-col items-center justify-center gap-2 group hover:border-zinc-700 transition-colors"
  >
    <div className={`p-3 rounded-full ${color} bg-opacity-20 group-hover:scale-110 transition-transform`}>
      <Icon className={`w-6 h-6 ${color.replace('bg-', 'text-')}`} />
    </div>
    <h4 className="text-zinc-400 text-sm font-medium uppercase tracking-wider">{label}</h4>
    <span className="text-3xl font-black">{value}</span>
  </motion.div>
);

const ProgressBar = ({ label, value, color, delay }) => (
  <div className="mb-6">
    <div className="flex justify-between mb-2">
      <span className="text-sm font-bold text-zinc-300">{label}</span>
      <span className="text-sm font-bold text-white">{value}%</span>
    </div>
    <div className="w-full bg-zinc-800 rounded-full h-3 overflow-hidden">
      <motion.div
        initial={{ width: 0 }}
        animate={{ width: `${value}%` }}
        transition={{ duration: 1.5, delay, ease: "easeOut" }}
        className={`h-3 rounded-full ${color} shadow-[0_0_10px_currentColor]`}
      />
    </div>
  </div>
);

const ReportGenerator = () => {
  const [selectedEvent, setSelectedEvent] = useState(null);
  const reportRef = useRef(null);

  const downloadPDF = async () => {
    if (!reportRef.current) return;
    
    const canvas = await html2canvas(reportRef.current, {
      scale: 2,
      backgroundColor: '#000000',
      logging: false,
      useCORS: true
    });

    const imgData = canvas.toDataURL('image/png');
    const pdf = new jsPDF('p', 'mm', 'a4');
    const pdfWidth = pdf.internal.pageSize.getWidth();
    const pdfHeight = (canvas.height * pdfWidth) / canvas.width;
    
    pdf.addImage(imgData, 'PNG', 0, 0, pdfWidth, pdfHeight);
    pdf.save(`${selectedEvent.title}_Report.pdf`);
  };

  return (
    <div className="min-h-screen bg-black text-white selection:bg-pink-500/30">
      <Navbar />

      <div className="pt-24 px-6 container mx-auto pb-20">
        <AnimatePresence mode='wait'>
          {!selectedEvent ? (
            <motion.div
              key="list"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0, x: -50 }}
              className='max-w-4xl mx-auto'
            >
              <div className="mb-12">
                  <span className="px-3 py-1 rounded-full bg-pink-500/10 border border-pink-500/20 text-pink-400 text-xs font-bold uppercase tracking-widest mb-4 inline-block">
                    Analytics Suite
                  </span>
                  <h1 className="text-6xl font-black mb-4 bg-gradient-to-r from-purple-400 to-pink-600 bg-clip-text text-transparent">
                    Report Center
                  </h1>
                  <p className="text-xl text-zinc-400">Transform raw data into hype-worthy visual stories.</p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {EVENTS.map((event, index) => (
                  <motion.div
                    key={event.id}
                    initial={{ y: 20, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    transition={{ delay: index * 0.1 }}
                    onClick={() => setSelectedEvent(event)}
                    className="group cursor-pointer bg-zinc-900 border border-zinc-800 hover:border-pink-500/50 p-8 rounded-3xl transition-all duration-300 hover:-translate-y-2 relative overflow-hidden"
                  >
                    <div className="absolute inset-0 bg-gradient-to-br from-purple-500/10 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                    
                    <h3 className="text-2xl font-bold mb-2 text-white group-hover:text-pink-400 transition-colors">{event.title}</h3>
                    <div className="flex items-center gap-4 text-zinc-400 text-sm mb-6">
                      <span className="flex items-center gap-1"><Calendar size={14}/> {event.date}</span>
                      <span className="flex items-center gap-1"><MapPin size={14}/> {event.location}</span>
                    </div>
                    
                    <div className="flex items-center justify-between mt-4">
                      <span className="text-zinc-500 font-bold text-xs uppercase tracking-widest group-hover:text-white transition-colors">Generate Report</span>
                      <div className="w-8 h-8 rounded-full bg-zinc-800 flex items-center justify-center group-hover:bg-pink-500 group-hover:text-white transition-all">
                        <ArrowRight size={16} className="-rotate-45 group-hover:rotate-0 transition-transform" />
                      </div>
                    </div>
                  </motion.div>
                ))}
              </div>
            </motion.div>
          ) : (
            <motion.div
              key="report"
              initial={{ opacity: 0, x: 50 }}
              animate={{ opacity: 1, x: 0 }}
              exit={{ opacity: 0 }}
            >
              {/* Header Controls */}
              <div className="mb-8 flex items-center justify-between">
                <button 
                  onClick={() => setSelectedEvent(null)}
                  className="flex items-center gap-2 text-zinc-400 hover:text-white transition-colors font-bold uppercase tracking-wide text-sm"
                >
                  <ArrowLeft size={16} /> Back to Events
                </button>
                <div className="flex gap-4">
                  <button 
                    onClick={downloadPDF}
                    className="flex items-center gap-2 px-6 py-3 bg-white text-black rounded-xl font-bold hover:bg-zinc-200 transition-all shadow-[0_0_20px_rgba(255,255,255,0.2)]"
                  >
                    <Download size={18} /> DOWNLOAD PDF REPORT
                  </button>
                </div>
              </div>

              {/* The Report (Target for PDF) */}
              <div ref={reportRef} className="bg-black p-12 rounded-[2rem] border border-zinc-800 shadow-2xl max-w-5xl mx-auto relative overflow-hidden">
                {/* Background Decor */}
                <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-purple-600/10 rounded-full blur-[120px] pointer-events-none" />
                <div className="absolute bottom-0 left-0 w-[400px] h-[400px] bg-pink-600/10 rounded-full blur-[100px] pointer-events-none" />
                
                {/* Report Header */}
                <div className="flex justify-between items-start mb-16 relative z-10 border-b border-zinc-800 pb-8">
                    <div>
                        <span className="inline-block px-3 py-1 rounded-full border border-zinc-700 bg-zinc-900 text-[10px] font-bold text-zinc-400 mb-4 tracking-widest uppercase">
                            Official Event Report
                        </span>
                        <h1 className="text-6xl font-black text-white mb-2 tracking-tight">
                            {selectedEvent.title}
                        </h1>
                        <p className="text-zinc-500 text-xl font-medium">{selectedEvent.date} • {selectedEvent.location}</p>
                    </div>
                    <div className="text-right">
                        <div className="text-5xl font-black text-transparent bg-clip-text bg-gradient-to-br from-purple-400 to-pink-500">
                            A+
                        </div>
                        <div className="text-xs font-bold text-zinc-500 uppercase tracking-widest mt-1">Impact Grade</div>
                    </div>
                </div>

                {/* Executive Summary */}
                <div className="mb-12 bg-zinc-900/40 p-8 rounded-3xl border border-zinc-800/50 relative overflow-hidden">
                    <div className="absolute top-0 left-0 w-1 h-full bg-gradient-to-b from-purple-500 to-pink-500" />
                    <h3 className="text-xl font-bold text-white mb-4 flex items-center gap-2">
                        <Sparkles className="text-yellow-400" size={20} /> Executive Summary
                    </h3>
                    <p className="text-zinc-300 leading-relaxed text-lg">
                        {selectedEvent.summary}
                    </p>
                </div>

                {/* KPI Grid */}
                <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
                  <StatCard 
                    icon={Users} 
                    label="Registrations" 
                    value={selectedEvent.registrations} 
                    color="text-purple-500" 
                    delay={0.2}
                  />
                  <StatCard 
                    icon={Activity} 
                    label="Turnout %" 
                    value={`${Math.round((selectedEvent.checkins/selectedEvent.registrations)*100)}%`} 
                    color="text-emerald-500" 
                    delay={0.3}
                  />
                  <StatCard 
                    icon={DollarSign} 
                    label="ROI" 
                    value={`${Math.round(((selectedEvent.revenue - selectedEvent.budget)/selectedEvent.budget)*100)}%`} 
                    color="text-blue-500" 
                    delay={0.4}
                  />
                  <StatCard 
                    icon={Trophy} 
                    label="Vibe Score" 
                    value={`${selectedEvent.vibeScore}/100`} 
                    color="text-pink-500" 
                    delay={0.5}
                  />
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-12">
                  {/* Demographics Section */}
                  <div className="bg-zinc-900/30 p-8 rounded-3xl border border-zinc-800/50">
                    <h3 className="text-2xl font-bold mb-8 flex items-center gap-2">
                      <PieChart className="text-purple-400" /> Participant Mix
                    </h3>
                    <ProgressBar label="ENTC Dept" value={selectedEvent.demographics.entc} color="bg-purple-500" delay={0.6} />
                    <ProgressBar label="Comp Dept" value={selectedEvent.demographics.comp} color="bg-blue-500" delay={0.7} />
                    <ProgressBar label="IT Dept" value={selectedEvent.demographics.it} color="bg-pink-500" delay={0.8} />
                    <ProgressBar label="External" value={selectedEvent.demographics.other} color="bg-zinc-500" delay={0.9} />
                  </div>

                  {/* Financials Pill */}
                  <div className="bg-zinc-900/30 p-8 rounded-3xl border border-zinc-800/50 flex flex-col justify-center">
                     <h3 className="text-2xl font-bold mb-8 flex items-center gap-2">
                      <TrendingUp className="text-emerald-400" /> Financial Impact
                    </h3>
                    <div className="space-y-6">
                      <div>
                        <div className="text-xs text-zinc-500 uppercase tracking-widest mb-1">Total Revenue</div>
                        <div className="text-5xl font-black text-white tracking-tight">₹{selectedEvent.revenue.toLocaleString()}</div>
                      </div>
                      <div>
                        <div className="text-xs text-zinc-500 uppercase tracking-widest mb-1">Budget Utilized</div>
                        <div className="text-4xl font-bold text-zinc-600">₹{selectedEvent.budget.toLocaleString()}</div>
                      </div>
                      <div className="pt-6 border-t border-zinc-800 mt-4">
                        <div className="flex justify-between items-center bg-emerald-500/10 p-5 rounded-2xl border border-emerald-500/20">
                          <span className="text-emerald-400 font-bold uppercase tracking-wide text-sm">Net Profit</span>
                          <span className="text-3xl font-black text-emerald-400">₹{(selectedEvent.revenue - selectedEvent.budget).toLocaleString()}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Footer */}
                <div className="mt-16 text-center border-t border-zinc-800 pt-8 opacity-40">
                  <p className="font-mono text-[10px] tracking-[0.5em] uppercase">Powered by UniBuzz Intelligence • Confidential Report</p>
                </div>
              </div>
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
};

export default ReportGenerator;
