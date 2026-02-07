import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
    Award, QrCode, Shield, Share2, Download, Upload,
    CheckCircle2, Clock, Users, Filter, Search,
    FileText, Eye, Send, Zap, AlertCircle, X,
    Calendar, Hash, Linkedin, ExternalLink, Copy,
    CheckCheck, Sparkles, TrendingUp
} from 'lucide-react';
import Navbar from '../home/Navbar';
import CertificateGenerator from './CertificateGenerator';
import CertificateTemplates from './CertificateTemplates';

const CertificateManagement = ({ isEmbedded = false }) => {
    const [activeTab, setActiveTab] = useState('overview'); // overview, generate, templates, verify
    const [selectedEvent, setSelectedEvent] = useState(null);
    const [showGenerator, setShowGenerator] = useState(false);
    const [showTemplates, setShowTemplates] = useState(false);
    const [filterStatus, setFilterStatus] = useState('all'); // all, pending, approved, issued
    const [searchQuery, setSearchQuery] = useState('');
    const [bulkUploadModal, setBulkUploadModal] = useState(false);
    const [verifyModal, setVerifyModal] = useState(false);
    const [verificationCode, setVerificationCode] = useState('');

    // Mock data for events
    const events = [
        {
            id: 'evt_001',
            title: 'AI Ethics Workshop',
            date: '2025-10-12',
            totalParticipants: 145,
            attendedCount: 128,
            certificatesIssued: 115,
            certificatesPending: 13,
            attendanceThreshold: 80,
            status: 'active',
            template: 'Modern Workshop'
        },
        {
            id: 'evt_002',
            title: 'CodeSprint 2025',
            date: '2025-11-05',
            totalParticipants: 230,
            attendedCount: 207,
            certificatesIssued: 0,
            certificatesPending: 207,
            attendanceThreshold: 75,
            status: 'pending',
            template: 'Hackathon Elite'
        },
        {
            id: 'evt_003',
            title: 'Cyber Security Summit',
            date: '2025-09-28',
            totalParticipants: 180,
            attendedCount: 165,
            certificatesIssued: 165,
            certificatesPending: 0,
            attendanceThreshold: 80,
            status: 'completed',
            template: 'Professional Seminar'
        }
    ];

    // Mock participants data
    const participants = [
        {
            id: 'p_001',
            name: 'Rahul Sharma',
            email: 'rahul.sharma@university.edu',
            eventId: 'evt_001',
            attendance: 95,
            certificateStatus: 'issued',
            certificateId: 'CERT-2025-AI-001',
            blockchainHash: '0x7a8f9b2c...',
            issuedDate: '2025-10-15',
            role: 'Participant'
        },
        {
            id: 'p_002',
            name: 'Priya Patel',
            email: 'priya.patel@university.edu',
            eventId: 'evt_001',
            attendance: 88,
            certificateStatus: 'approved',
            certificateId: null,
            blockchainHash: null,
            issuedDate: null,
            role: 'Participant'
        },
        {
            id: 'p_003',
            name: 'Arjun Kumar',
            email: 'arjun.kumar@university.edu',
            eventId: 'evt_002',
            attendance: 92,
            certificateStatus: 'pending',
            certificateId: null,
            blockchainHash: null,
            issuedDate: null,
            role: 'Winner'
        }
    ];

    const renderOverview = () => (
        <div className="space-y-8">
            {/* Stats Grid */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                    {
                        label: 'Total Certificates',
                        value: '280',
                        icon: Award,
                        color: 'text-ubLime',
                        bgColor: 'bg-ubLime/10',
                        change: '+12%'
                    },
                    {
                        label: 'Pending Approval',
                        value: '220',
                        icon: Clock,
                        color: 'text-yellow-400',
                        bgColor: 'bg-yellow-400/10',
                        change: '+45'
                    },
                    {
                        label: 'Blockchain Verified',
                        value: '280',
                        icon: Shield,
                        color: 'text-cyan-400',
                        bgColor: 'bg-cyan-400/10',
                        change: '100%'
                    },
                    {
                        label: 'LinkedIn Shares',
                        value: '156',
                        icon: Share2,
                        color: 'text-ubViolet',
                        bgColor: 'bg-ubViolet/10',
                        change: '+28%'
                    }
                ].map((stat, i) => (
                    <motion.div
                        key={i}
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: i * 0.1 }}
                        className="bg-zinc-900/50 border border-white/5 p-6 rounded-3xl hover:border-white/10 transition-all group"
                    >
                        <div className={`w-12 h-12 rounded-2xl ${stat.bgColor} flex items-center justify-center mb-4 group-hover:scale-110 transition-transform`}>
                            <stat.icon size={24} className={stat.color} />
                        </div>
                        <p className="text-gray-400 text-xs font-bold uppercase tracking-wider mb-1">{stat.label}</p>
                        <div className="flex items-end justify-between">
                            <h4 className="text-3xl font-black text-white">{stat.value}</h4>
                            <span className="text-ubLime text-xs font-bold flex items-center gap-1">
                                <TrendingUp size={14} /> {stat.change}
                            </span>
                        </div>
                    </motion.div>
                ))}
            </div>

            {/* Quick Actions */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                <motion.button
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                    onClick={() => setShowGenerator(true)}
                    className="group p-8 bg-gradient-to-br from-ubLime to-ubLime/80 rounded-3xl text-left relative overflow-hidden"
                >
                    <div className="absolute top-0 right-0 w-32 h-32 bg-black/10 rounded-full -mr-16 -mt-16" />
                    <Zap size={32} className="text-black mb-4 relative z-10" />
                    <h3 className="text-2xl font-black text-black mb-2 relative z-10">Generate Certificates</h3>
                    <p className="text-black/70 font-medium relative z-10">Issue verified certificates instantly</p>
                </motion.button>

                <motion.button
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                    onClick={() => setBulkUploadModal(true)}
                    className="group p-8 bg-zinc-900/50 border border-white/10 rounded-3xl text-left hover:border-ubViolet/50 transition-all"
                >
                    <Upload size={32} className="text-ubViolet mb-4" />
                    <h3 className="text-2xl font-black text-white mb-2">Bulk Upload</h3>
                    <p className="text-gray-400 font-medium">Upload attendance sheet for batch generation</p>
                </motion.button>

                <motion.button
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                    onClick={() => setShowTemplates(true)}
                    className="group p-8 bg-zinc-900/50 border border-white/10 rounded-3xl text-left hover:border-cyan-400/50 transition-all"
                >
                    <FileText size={32} className="text-cyan-400 mb-4" />
                    <h3 className="text-2xl font-black text-white mb-2">Template Library</h3>
                    <p className="text-gray-400 font-medium">Browse and customize certificate templates</p>
                </motion.button>
            </div>

            {/* Events List */}
            <div className="bg-zinc-900/50 border border-white/5 rounded-3xl p-8">
                <div className="flex items-center justify-between mb-6">
                    <h3 className="text-2xl font-black text-white">Events & Certificates</h3>
                    <div className="flex gap-3">
                        <div className="relative">
                            <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500" />
                            <input
                                type="text"
                                placeholder="Search events..."
                                value={searchQuery}
                                onChange={(e) => setSearchQuery(e.target.value)}
                                className="pl-12 pr-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white text-sm focus:outline-none focus:border-ubLime transition-colors"
                            />
                        </div>
                        <select
                            value={filterStatus}
                            onChange={(e) => setFilterStatus(e.target.value)}
                            className="px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white text-sm focus:outline-none appearance-none"
                        >
                            <option value="all" className="bg-black">All Status</option>
                            <option value="pending" className="bg-black">Pending</option>
                            <option value="active" className="bg-black">Active</option>
                            <option value="completed" className="bg-black">Completed</option>
                        </select>
                    </div>
                </div>

                <div className="space-y-4">
                    {events.map((event, i) => (
                        <motion.div
                            key={event.id}
                            initial={{ opacity: 0, y: 10 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: i * 0.05 }}
                            className="p-6 bg-white/5 border border-white/5 rounded-2xl hover:border-white/10 transition-all"
                        >
                            <div className="flex items-start justify-between mb-4">
                                <div className="flex-1">
                                    <div className="flex items-center gap-3 mb-2">
                                        <h4 className="text-lg font-bold text-white">{event.title}</h4>
                                        <span className={`px-3 py-1 rounded-full text-[10px] font-bold uppercase ${event.status === 'active' ? 'bg-ubLime/20 text-ubLime' :
                                            event.status === 'pending' ? 'bg-yellow-400/20 text-yellow-400' :
                                                'bg-ubViolet/20 text-ubViolet'
                                            }`}>
                                            {event.status}
                                        </span>
                                    </div>
                                    <div className="flex items-center gap-6 text-sm text-gray-400">
                                        <span className="flex items-center gap-2">
                                            <Calendar size={14} />
                                            {new Date(event.date).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
                                        </span>
                                        <span className="flex items-center gap-2">
                                            <Users size={14} />
                                            {event.totalParticipants} participants
                                        </span>
                                        <span className="flex items-center gap-2">
                                            <FileText size={14} />
                                            {event.template}
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div className="grid grid-cols-4 gap-4 mb-4">
                                <div className="p-4 bg-black/40 rounded-xl">
                                    <p className="text-[10px] font-bold text-gray-500 uppercase mb-1">Attended</p>
                                    <p className="text-2xl font-black text-white">{event.attendedCount}</p>
                                    <p className="text-xs text-gray-400">{Math.round((event.attendedCount / event.totalParticipants) * 100)}% turnout</p>
                                </div>
                                <div className="p-4 bg-black/40 rounded-xl">
                                    <p className="text-[10px] font-bold text-gray-500 uppercase mb-1">Issued</p>
                                    <p className="text-2xl font-black text-ubLime">{event.certificatesIssued}</p>
                                    <p className="text-xs text-gray-400">Blockchain verified</p>
                                </div>
                                <div className="p-4 bg-black/40 rounded-xl">
                                    <p className="text-[10px] font-bold text-gray-500 uppercase mb-1">Pending</p>
                                    <p className="text-2xl font-black text-yellow-400">{event.certificatesPending}</p>
                                    <p className="text-xs text-gray-400">Awaiting approval</p>
                                </div>
                                <div className="p-4 bg-black/40 rounded-xl">
                                    <p className="text-[10px] font-bold text-gray-500 uppercase mb-1">Threshold</p>
                                    <p className="text-2xl font-black text-cyan-400">{event.attendanceThreshold}%</p>
                                    <p className="text-xs text-gray-400">Min. attendance</p>
                                </div>
                            </div>

                            <div className="flex gap-3">
                                <button
                                    onClick={() => {
                                        setSelectedEvent(event);
                                        setShowGenerator(true);
                                    }}
                                    className="flex-1 px-4 py-3 bg-ubLime rounded-xl text-black font-bold text-sm hover:bg-ubLime/90 transition-all flex items-center justify-center gap-2"
                                >
                                    <Zap size={16} />
                                    Generate Certificates
                                </button>
                                <button className="px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white font-bold text-sm hover:bg-white/10 transition-all flex items-center gap-2">
                                    <Eye size={16} />
                                    View Details
                                </button>
                                <button className="px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white font-bold text-sm hover:bg-white/10 transition-all">
                                    <Download size={16} />
                                </button>
                            </div>
                        </motion.div>
                    ))}
                </div>
            </div>
        </div>
    );

    return (
        <div className={isEmbedded ? "" : "min-h-screen bg-black text-white font-sans selection:bg-ubLime selection:text-black pb-20"}>
            {!isEmbedded && <Navbar />}

            <div className={isEmbedded ? "" : "pt-32 px-6 md:px-12 max-w-7xl mx-auto"}>
                <motion.div
                    initial={{ opacity: 0, y: 30 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="mb-12"
                >
                    {!isEmbedded && (
                        <div className="flex items-center gap-4 mb-4">
                            <div className="w-16 h-16 bg-ubLime/20 rounded-2xl flex items-center justify-center">
                                <Award size={32} className="text-ubLime" />
                            </div>
                            <div>
                                <h1 className="text-5xl md:text-6xl font-black">
                                    Smart <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet">Certificates</span>
                                </h1>
                                <p className="text-xl text-gray-400 font-medium mt-2">
                                    Blockchain-verified, tamper-proof digital certificates
                                </p>
                            </div>
                        </div>
                    )}

                    {/* Tab Navigation */}
                    <div className="flex gap-3 mt-8">
                        {[
                            { id: 'overview', label: 'Overview', icon: Award },
                            { id: 'verify', label: 'Verify Certificate', icon: Shield }
                        ].map(tab => (
                            <button
                                key={tab.id}
                                onClick={() => setActiveTab(tab.id)}
                                className={`px-6 py-3 rounded-xl font-bold flex items-center gap-2 transition-all ${activeTab === tab.id
                                    ? 'bg-ubLime text-black'
                                    : 'bg-white/5 text-gray-400 hover:bg-white/10'
                                    }`}
                            >
                                <tab.icon size={18} />
                                {tab.label}
                            </button>
                        ))}
                    </div>
                </motion.div>

                {activeTab === 'overview' && renderOverview()}
                {activeTab === 'verify' && (
                    <div className="max-w-2xl mx-auto">
                        <div className="bg-zinc-900/50 border border-white/5 rounded-3xl p-12">
                            <div className="text-center mb-8">
                                <div className="w-20 h-20 bg-cyan-400/20 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <Shield size={40} className="text-cyan-400" />
                                </div>
                                <h2 className="text-3xl font-black text-white mb-3">Verify Certificate</h2>
                                <p className="text-gray-400">Enter certificate ID or scan QR code to verify authenticity</p>
                            </div>

                            <div className="space-y-6">
                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-wider">Certificate ID</label>
                                    <input
                                        type="text"
                                        value={verificationCode}
                                        onChange={(e) => setVerificationCode(e.target.value)}
                                        placeholder="CERT-2025-AI-001"
                                        className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-cyan-400 transition-colors"
                                    />
                                </div>

                                <button className="w-full py-4 bg-cyan-400 rounded-2xl text-black font-bold hover:bg-cyan-300 transition-all flex items-center justify-center gap-2">
                                    <Shield size={20} />
                                    Verify Certificate
                                </button>

                                <div className="relative">
                                    <div className="absolute inset-0 flex items-center">
                                        <div className="w-full border-t border-white/10"></div>
                                    </div>
                                    <div className="relative flex justify-center text-sm">
                                        <span className="px-4 bg-zinc-900 text-gray-500 font-bold">OR</span>
                                    </div>
                                </div>

                                <button className="w-full py-4 bg-white/5 border border-white/10 rounded-2xl text-white font-bold hover:bg-white/10 transition-all flex items-center justify-center gap-2">
                                    <QrCode size={20} />
                                    Scan QR Code
                                </button>
                            </div>
                        </div>
                    </div>
                )}
            </div>

            {/* Certificate Generator Modal */}
            <AnimatePresence>
                {showGenerator && (
                    <CertificateGenerator
                        event={selectedEvent}
                        onClose={() => {
                            setShowGenerator(false);
                            setSelectedEvent(null);
                        }}
                    />
                )}
            </AnimatePresence>

            {/* Templates Modal */}
            <AnimatePresence>
                {showTemplates && (
                    <CertificateTemplates onClose={() => setShowTemplates(false)} />
                )}
            </AnimatePresence>

            {/* Bulk Upload Modal */}
            <AnimatePresence>
                {bulkUploadModal && (
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="fixed inset-0 z-[100] flex items-center justify-center px-6 bg-black/90 backdrop-blur-xl"
                        onClick={() => setBulkUploadModal(false)}
                    >
                        <motion.div
                            initial={{ scale: 0.9, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            exit={{ scale: 0.9, opacity: 0 }}
                            onClick={(e) => e.stopPropagation()}
                            className="bg-zinc-900 border border-white/10 p-12 rounded-[48px] max-w-2xl w-full"
                        >
                            <div className="flex items-center justify-between mb-8">
                                <h2 className="text-3xl font-black text-white">Bulk Certificate Generation</h2>
                                <button
                                    onClick={() => setBulkUploadModal(false)}
                                    className="w-10 h-10 bg-white/5 rounded-xl flex items-center justify-center hover:bg-white/10 transition-all"
                                >
                                    <X size={20} className="text-gray-400" />
                                </button>
                            </div>

                            <div className="space-y-6">
                                <div className="p-8 border-2 border-dashed border-white/10 rounded-3xl hover:border-ubLime/50 transition-all cursor-pointer group">
                                    <div className="text-center">
                                        <div className="w-16 h-16 bg-white/5 rounded-2xl flex items-center justify-center mx-auto mb-4 group-hover:scale-110 transition-transform">
                                            <Upload size={32} className="text-gray-400 group-hover:text-ubLime transition-colors" />
                                        </div>
                                        <p className="text-white font-bold mb-2">Upload Attendance Sheet</p>
                                        <p className="text-gray-400 text-sm mb-4">Drag & drop or click to upload CSV/Excel file</p>
                                        <p className="text-xs text-gray-500">Required columns: Name, Email, Attendance %, Role (optional)</p>
                                    </div>
                                </div>

                                <div className="p-6 bg-ubLime/10 border border-ubLime/30 rounded-2xl">
                                    <div className="flex gap-4">
                                        <AlertCircle size={24} className="text-ubLime flex-shrink-0" />
                                        <div>
                                            <p className="text-ubLime font-bold mb-1">Auto-generation Rules</p>
                                            <ul className="text-ubLime/80 text-sm space-y-1">
                                                <li>• Only participants meeting attendance threshold will receive certificates</li>
                                                <li>• Blockchain hash will be generated automatically</li>
                                                <li>• Email notifications will be sent with QR verification link</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div className="flex gap-4">
                                    <button className="flex-1 py-4 bg-white/5 border border-white/10 rounded-2xl text-white font-bold hover:bg-white/10 transition-all">
                                        Download Template
                                    </button>
                                    <button className="flex-1 py-4 bg-ubLime rounded-2xl text-black font-bold hover:bg-ubLime/90 transition-all">
                                        Process & Generate
                                    </button>
                                </div>
                            </div>
                        </motion.div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
};

export default CertificateManagement;
