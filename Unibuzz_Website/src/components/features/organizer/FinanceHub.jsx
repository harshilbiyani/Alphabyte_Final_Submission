import React, { useState } from 'react';
import Navbar from '../../home/Navbar';
import { motion, AnimatePresence } from 'framer-motion';
import { UploadCloud, FileText, CheckCircle, XCircle, DollarSign, ShieldCheck, Plus, ArrowLeft, Calendar, User, Eye, Download, X } from 'lucide-react';

const EVENTS = [
  { id: 1, title: 'HackOverflow', date: 'Feb 14, 2026', pendingBills: 3, pendingAmount: 45000, color: 'from-blue-500 to-cyan-500' },
  { id: 2, title: 'Debate Club Meet', date: 'Mar 01, 2026', pendingBills: 0, pendingAmount: 0, color: 'from-purple-500 to-pink-500' },
  { id: 3, title: 'Tech Symposium', date: 'Jan 20, 2026', pendingBills: 5, pendingAmount: 12000, color: 'from-emerald-500 to-green-500' },
];

const BILLS_DATA = {
    1: [
        { id: 101, title: 'Venue Decor Items', amount: 15000, submittedBy: 'Alex (Design Team)', date: 'Feb 10, 2026', status: 'approved', type: 'image', desc: 'Purchased 50m of LED strips and 20 banners.' },
        { id: 102, title: 'Catering Advance', amount: 20000, submittedBy: 'Sarah (Logistics)', date: 'Feb 12, 2026', status: 'pending', type: 'pdf', desc: '50% advance payment for lunch catering (300 pax).' },
        { id: 103, title: 'Sound Equipment', amount: 10000, submittedBy: 'Mike (Tech)', date: 'Feb 13, 2026', status: 'pending', type: 'pdf', desc: 'Rental for speakers and microphones.' },
    ],
    2: [],
    3: [
        { id: 301, title: 'Guest Speaker Travel', amount: 5000, submittedBy: 'Priya', date: 'Jan 15, 2026', status: 'pending', type: 'pdf', desc: 'Flight tickets for keynote speaker.' },
    ]
};

const FinanceHub = () => {
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [bills, setBills] = useState([]);
  const [selectedBill, setSelectedBill] = useState(null);
  
  const handleEventSelect = (event) => {
    setSelectedEvent(event);
    setBills(BILLS_DATA[event.id] || []);
  };

  const handleBillClick = (bill) => {
      setSelectedBill(bill);
  };

  const updateBillStatus = (status) => {
      if (!selectedBill) return;
      const updatedBills = bills.map(b => b.id === selectedBill.id ? {...b, status} : b);
      setBills(updatedBills);
      setSelectedBill(null); // Close modal
  };

  return (
    <div className="min-h-screen bg-black text-white selection:bg-emerald-500/30">
        <Navbar />
        
        {/* Bill Detail Modal */}
        <AnimatePresence>
            {selectedBill && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
                    <motion.div 
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="absolute inset-0 bg-black/80 backdrop-blur-md"
                        onClick={() => setSelectedBill(null)}
                    />
                    <motion.div 
                        layoutId={`bill-${selectedBill.id}`}
                        className="bg-zinc-900 border border-zinc-800 rounded-3xl w-full max-w-4xl relative z-10 overflow-hidden shadow-2xl flex flex-col md:flex-row h-[80vh] md:h-[600px]"
                    >
                        {/* Left: Preview */}
                        <div className="md:w-1/2 bg-zinc-950 p-8 flex items-center justify-center border-r border-zinc-800 relative">
                             {/* Mock Preview */}
                             <div className="w-full h-full bg-white/5 rounded-2xl border-2 border-dashed border-zinc-800 flex flex-col items-center justify-center text-zinc-500">
                                <FileText size={48} className="mb-4" />
                                <span className="font-mono text-sm uppercase">Preview Unavailable</span>
                                <span className="text-xs mt-2 text-zinc-600">({selectedBill.type} file)</span>
                             </div>
                             <div className="absolute top-4 left-4 bg-zinc-900 px-3 py-1 rounded-full text-xs font-mono text-zinc-500">
                                ID: BILL-{selectedBill.id}
                             </div>
                        </div>

                        {/* Right: Details */}
                        <div className="md:w-1/2 p-8 flex flex-col">
                            <div className="flex justify-between items-start mb-6">
                                <div>
                                    <h2 className="text-2xl font-bold mb-1">{selectedBill.title}</h2>
                                    <div className="flex items-center gap-2 text-sm text-zinc-400">
                                        <Calendar size={14} /> {selectedBill.date}
                                    </div>
                                </div>
                                <button onClick={() => setSelectedBill(null)} className="p-2 hover:bg-zinc-800 rounded-full transition-colors">
                                    <X size={20} />
                                </button>
                            </div>

                            <div className="mb-8">
                                <div className="text-4xl font-mono font-bold text-white mb-2">₹{selectedBill.amount.toLocaleString()}</div>
                                <div className={`inline-block px-3 py-1 rounded-full text-xs font-bold uppercase tracking-widest ${
                                    selectedBill.status === 'approved' ? 'bg-emerald-500/20 text-emerald-500' :
                                    selectedBill.status === 'rejected' ? 'bg-red-500/20 text-red-500' :
                                    'bg-yellow-500/20 text-yellow-500'
                                }`}>
                                    Status: {selectedBill.status}
                                </div>
                            </div>

                            <div className="space-y-6 mb-8 flex-1 overflow-y-auto">
                                <div className="bg-zinc-800/50 p-4 rounded-xl">
                                    <div className="text-xs text-zinc-500 uppercase tracking-widest mb-1">Submitted By</div>
                                    <div className="flex items-center gap-2 text-white font-medium">
                                        <div className="w-8 h-8 rounded-full bg-emerald-500/20 flex items-center justify-center text-emerald-500 text-xs">
                                            {selectedBill.submittedBy.charAt(0)}
                                        </div>
                                        {selectedBill.submittedBy}
                                    </div>
                                </div>
                                <div className="bg-zinc-800/50 p-4 rounded-xl">
                                    <div className="text-xs text-zinc-500 uppercase tracking-widest mb-1">Description</div>
                                    <p className="text-zinc-300 text-sm leading-relaxed">{selectedBill.desc}</p>
                                </div>
                            </div>

                            {/* Actions */}
                            {selectedBill.status === 'pending' ? (
                                <div className="grid grid-cols-2 gap-4">
                                     <button 
                                        onClick={() => updateBillStatus('rejected')}
                                        className="py-4 border border-zinc-700 hover:bg-red-500/20 hover:border-red-500 hover:text-red-500 rounded-xl font-bold transition-all"
                                     >
                                        DECLINE
                                     </button>
                                     <button 
                                        onClick={() => updateBillStatus('approved')}
                                        className="py-4 bg-white text-black hover:bg-emerald-400 hover:shadow-[0_0_20px_rgba(52,211,153,0.4)] rounded-xl font-bold transition-all"
                                     >
                                        APPROVE CLAIM
                                     </button>
                                </div>
                            ) : (
                                <div className="text-center p-4 bg-zinc-800 rounded-xl text-zinc-400 text-sm">
                                    Review completed on {new Date().toLocaleDateString()}
                                </div>
                            )}
                        </div>
                    </motion.div>
                </div>
            )}
        </AnimatePresence>

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
                        <span className="px-3 py-1 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-500 text-xs font-bold uppercase tracking-widest mb-4 inline-block">
                            Finance Protocol
                        </span>
                        <h1 className="text-6xl font-black mb-4 bg-gradient-to-r from-emerald-400 to-teal-600 bg-clip-text text-transparent">
                            Vault Access
                        </h1>
                        <p className="text-xl text-zinc-400">Select an event to access its ledger.</p>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                        {EVENTS.map((event, index) => (
                            <motion.div
                                key={event.id}
                                initial={{ y: 20, opacity: 0 }}
                                animate={{ y: 0, opacity: 1 }}
                                transition={{ delay: index * 0.1 }}
                                onClick={() => handleEventSelect(event)}
                                className="group cursor-pointer bg-zinc-900 border border-zinc-800 p-1 rounded-3xl relative overflow-hidden h-[300px] flex flex-col"
                            >
                                <div className={`absolute inset-0 bg-gradient-to-br ${event.color} opacity-0 group-hover:opacity-10 transition-opacity duration-500`} />
                                
                                <div className="bg-zinc-900 rounded-[22px] p-8 h-full flex flex-col relative z-10 transition-transform group-hover:scale-[0.98]">
                                    <div className={`w-12 h-12 rounded-full bg-gradient-to-br ${event.color} flex items-center justify-center text-white mb-auto shadow-lg`}>
                                        <DollarSign size={24} />
                                    </div>

                                    <div>
                                        <h3 className="text-2xl font-bold text-white mb-2">{event.title}</h3>
                                        <p className="text-zinc-500 mb-6">{event.date}</p>
                                        
                                        <div className="flex justify-between items-end border-t border-zinc-800 pt-6">
                                            <div>
                                                <div className="text-xs text-zinc-500 uppercase tracking-widest mb-1">Pending</div>
                                                <div className="text-xl font-bold text-white">₹{event.pendingAmount.toLocaleString()}</div>
                                            </div>
                                            <div className="w-10 h-10 rounded-full bg-zinc-800 flex items-center justify-center group-hover:bg-white group-hover:text-black transition-all">
                                                <ArrowLeft className="rotate-180" size={20} />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </motion.div>
                        ))}
                    </div>
                </motion.div>
            ) : (
                <motion.div
                    key="ledger"
                    initial={{ opacity: 0, x: 50 }}
                    animate={{ opacity: 1, x: 0 }}
                    exit={{ opacity: 0 }}
                >
                    <button 
                        onClick={() => setSelectedEvent(null)}
                        className="flex items-center gap-2 text-zinc-400 hover:text-white mb-8 transition-colors font-bold uppercase tracking-wide text-sm"
                    >
                        <ArrowLeft size={16} /> Back to Vault
                    </button>

                    <div className="flex flex-col md:flex-row gap-8">
                        {/* Summary Card */}
                        <div className="md:w-1/3">
                            <div className="bg-zinc-900 border border-zinc-800 rounded-3xl p-8 sticky top-32">
                                <h2 className="text-3xl font-bold mb-2">{selectedEvent.title}</h2>
                                <p className="text-zinc-500 mb-8">{selectedEvent.date}</p>

                                <div className="space-y-6">
                                    <div className="bg-zinc-950 p-6 rounded-2xl border border-zinc-800">
                                        <div className="text-xs text-zinc-500 uppercase tracking-widest mb-1">Total Budget</div>
                                        <div className="text-3xl font-mono font-bold text-white">₹1,00,000</div>
                                    </div>
                                    <div className="bg-emerald-900/10 p-6 rounded-2xl border border-emerald-500/20">
                                        <div className="text-xs text-emerald-500/70 uppercase tracking-widest mb-1">Remaining</div>
                                        <div className="text-3xl font-mono font-bold text-emerald-400">₹{(100000 - selectedEvent.pendingAmount).toLocaleString()}</div>
                                    </div>
                                </div>

                                <button className="w-full mt-8 py-4 bg-white text-black rounded-xl font-bold hover:bg-zinc-200 transition-colors flex items-center justify-center gap-2">
                                    <Plus size={18} /> Add Miscellaneous
                                </button>
                            </div>
                        </div>

                        {/* Transactions List */}
                        <div className="md:w-2/3 space-y-4">
                            {bills.map((bill, index) => (
                                <motion.div
                                    layoutId={`bill-${bill.id}`}
                                    key={bill.id}
                                    onClick={() => handleBillClick(bill)}
                                    initial={{ opacity: 0, y: 20 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: index * 0.1 }}
                                    className="bg-zinc-900 border border-zinc-800 p-6 rounded-2xl flex items-center justify-between cursor-pointer group hover:border-zinc-600 transition-all"
                                >
                                    <div className="flex items-center gap-6">
                                        <div className={`w-12 h-12 rounded-xl flex items-center justify-center ${
                                            bill.type === 'pdf' ? 'bg-red-500/10 text-red-500' : 'bg-blue-500/10 text-blue-500'
                                        }`}>
                                            <FileText size={24} />
                                        </div>
                                        <div>
                                            <h4 className="font-bold text-lg text-white group-hover:text-emerald-400 transition-colors">{bill.title}</h4>
                                            <div className="flex items-center gap-3 text-sm text-zinc-500 mt-1">
                                                <span>{bill.submittedBy}</span>
                                                <span>•</span>
                                                <span>{bill.date}</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div className="text-right">
                                        <div className="text-xl font-mono font-bold text-white">₹{bill.amount.toLocaleString()}</div>
                                        <div className={`text-xs font-bold uppercase tracking-wider mt-1 ${
                                            bill.status === 'approved' ? 'text-emerald-500' :
                                            bill.status === 'rejected' ? 'text-red-500' :
                                            'text-yellow-500'
                                        }`}>
                                            {bill.status}
                                        </div>
                                    </div>
                                </motion.div>
                            ))}
                            {bills.length === 0 && (
                                <div className="text-center py-20 text-zinc-500">
                                    No transactions found for this event.
                                </div>
                            )}
                        </div>
                    </div>
                </motion.div>
            )}
        </AnimatePresence>
      </div>
    </div>
  );
};

export default FinanceHub;
