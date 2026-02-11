import React, { useState, useRef } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
    X, Award, QrCode, Shield, Share2, Download, Send,
    CheckCircle2, Linkedin, Copy, Hash, ExternalLink,
    Sparkles, Zap, AlertCircle, Users, Filter, Search,
    Mail, CheckCheck, Clock, Eye
} from 'lucide-react';

const CertificateGenerator = ({ event, onClose }) => {
    const [step, setStep] = useState(1); // 1: Select participants, 2: Preview, 3: Success
    const [selectedParticipants, setSelectedParticipants] = useState([]);
    const [generationMode, setGenerationMode] = useState('manual'); // manual, auto, bulk
    const [searchQuery, setSearchQuery] = useState('');
    const [filterRole, setFilterRole] = useState('all');
    const [previewCert, setPreviewCert] = useState(null);
    const [isGenerating, setIsGenerating] = useState(false);
    const [generatedCerts, setGeneratedCerts] = useState([]);

    // Mock participants for the event
    const participants = [
        {
            id: 'p_001',
            name: 'Rahul Sharma',
            email: 'rahul.sharma@university.edu',
            attendance: 95,
            role: 'Participant',
            eligible: true,
            sessionsAttended: 19,
            totalSessions: 20
        },
        {
            id: 'p_002',
            name: 'Priya Patel',
            email: 'priya.patel@university.edu',
            attendance: 88,
            role: 'Participant',
            eligible: true,
            sessionsAttended: 18,
            totalSessions: 20
        },
        {
            id: 'p_003',
            name: 'Arjun Kumar',
            email: 'arjun.kumar@university.edu',
            attendance: 92,
            role: 'Winner',
            eligible: true,
            sessionsAttended: 19,
            totalSessions: 20
        },
        {
            id: 'p_004',
            name: 'Sneha Reddy',
            email: 'sneha.reddy@university.edu',
            attendance: 72,
            role: 'Participant',
            eligible: false,
            sessionsAttended: 14,
            totalSessions: 20
        },
        {
            id: 'p_005',
            name: 'Vikram Singh',
            email: 'vikram.singh@university.edu',
            attendance: 100,
            role: 'Speaker',
            eligible: true,
            sessionsAttended: 20,
            totalSessions: 20
        }
    ];

    const handleSelectParticipant = (participant) => {
        if (selectedParticipants.find(p => p.id === participant.id)) {
            setSelectedParticipants(selectedParticipants.filter(p => p.id !== participant.id));
        } else {
            setSelectedParticipants([...selectedParticipants, participant]);
        }
    };

    const handleSelectAll = () => {
        const eligible = participants.filter(p => p.eligible);
        if (selectedParticipants.length === eligible.length) {
            setSelectedParticipants([]);
        } else {
            setSelectedParticipants(eligible);
        }
    };

    const handleGenerate = () => {
        setIsGenerating(true);
        // Simulate certificate generation
        setTimeout(() => {
            const certs = selectedParticipants.map((p, i) => ({
                ...p,
                certificateId: `CERT-2025-${event?.id || 'EVT'}-${String(i + 1).padStart(3, '0')}`,
                blockchainHash: `0x${Math.random().toString(16).substr(2, 8)}...${Math.random().toString(16).substr(2, 8)}`,
                qrCode: `https://unibuzz.verify/${Math.random().toString(36).substr(2, 9)}`,
                issuedDate: new Date().toISOString(),
                linkedinShareUrl: `https://linkedin.com/share?cert=${Math.random().toString(36).substr(2, 9)}`
            }));
            setGeneratedCerts(certs);
            setIsGenerating(false);
            setStep(3);
        }, 2000);
    };

    const CertificatePreview = ({ participant }) => (
        <div className="relative w-full aspect-[1.414/1] bg-gradient-to-br from-zinc-900 to-black border-4 border-ubLime/30 rounded-3xl p-12 overflow-hidden">
            {/* Decorative elements */}
            <div className="absolute top-0 left-0 w-full h-full opacity-5">
                <div className="absolute top-10 left-10 w-32 h-32 border-4 border-ubLime rounded-full" />
                <div className="absolute bottom-10 right-10 w-40 h-40 border-4 border-ubViolet rounded-full" />
            </div>

            {/* Header */}
            <div className="relative z-10 text-center mb-8">
                <div className="w-20 h-20 bg-ubLime rounded-2xl flex items-center justify-center mx-auto mb-4">
                    <Award size={40} className="text-black" />
                </div>
                <h1 className="text-4xl font-black text-white mb-2">CERTIFICATE</h1>
                <p className="text-ubLime text-lg font-bold uppercase tracking-widest">of Achievement</p>
            </div>

            {/* Content */}
            <div className="relative z-10 text-center space-y-6">
                <p className="text-gray-400 text-sm uppercase tracking-wider">This is to certify that</p>
                <h2 className="text-5xl font-black text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet">
                    {participant.name}
                </h2>
                <p className="text-gray-400 text-sm">has successfully completed</p>
                <h3 className="text-2xl font-bold text-white">{event?.title || 'Event Title'}</h3>

                <div className="flex items-center justify-center gap-8 pt-6">
                    <div className="text-center">
                        <p className="text-xs text-gray-500 uppercase mb-1">Attendance</p>
                        <p className="text-2xl font-black text-ubLime">{participant.attendance}%</p>
                    </div>
                    <div className="w-px h-12 bg-white/10" />
                    <div className="text-center">
                        <p className="text-xs text-gray-500 uppercase mb-1">Role</p>
                        <p className="text-2xl font-black text-ubViolet">{participant.role}</p>
                    </div>
                    <div className="w-px h-12 bg-white/10" />
                    <div className="text-center">
                        <p className="text-xs text-gray-500 uppercase mb-1">Date</p>
                        <p className="text-2xl font-black text-cyan-400">{new Date(event?.date || Date.now()).toLocaleDateString('en-US', { month: 'short', year: 'numeric' })}</p>
                    </div>
                </div>
            </div>

            {/* Footer */}
            <div className="absolute bottom-8 left-12 right-12 flex items-end justify-between">
                <div className="text-left">
                    <div className="w-32 h-px bg-white/20 mb-2" />
                    <p className="text-xs text-gray-500">Organizer Signature</p>
                </div>
                <div className="text-center">
                    <div className="w-16 h-16 bg-white/10 rounded-xl flex items-center justify-center mb-2">
                        <QrCode size={32} className="text-ubLime" />
                    </div>
                    <p className="text-[8px] text-gray-500 uppercase">Scan to Verify</p>
                </div>
                <div className="text-right">
                    <p className="text-[8px] text-gray-500 font-mono mb-1">Blockchain Hash</p>
                    <p className="text-[10px] text-cyan-400 font-mono">0x7a8f9b2c...</p>
                </div>
            </div>
        </div>
    );

    return (
        <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-[100] flex items-center justify-center px-6 bg-black/90 backdrop-blur-xl overflow-y-auto py-20"
            onClick={onClose}
        >
            <motion.div
                initial={{ scale: 0.9, opacity: 0 }}
                animate={{ scale: 1, opacity: 1 }}
                exit={{ scale: 0.9, opacity: 0 }}
                onClick={(e) => e.stopPropagation()}
                className="bg-zinc-900 border border-white/10 rounded-[48px] max-w-6xl w-full my-auto"
            >
                {/* Header */}
                <div className="p-8 border-b border-white/10 flex items-center justify-between">
                    <div>
                        <h2 className="text-3xl font-black text-white mb-2">Generate Certificates</h2>
                        <p className="text-gray-400">
                            {event ? `For: ${event.title}` : 'Select participants and generate verified certificates'}
                        </p>
                    </div>
                    <button
                        onClick={onClose}
                        className="w-12 h-12 bg-white/5 rounded-xl flex items-center justify-center hover:bg-white/10 transition-all"
                    >
                        <X size={24} className="text-gray-400" />
                    </button>
                </div>

                {/* Progress */}
                <div className="px-8 pt-6">
                    <div className="flex items-center justify-between mb-4">
                        {[
                            { num: 1, label: 'Select' },
                            { num: 2, label: 'Preview' },
                            { num: 3, label: 'Generate' }
                        ].map((s, i) => (
                            <React.Fragment key={s.num}>
                                <div className="flex items-center gap-3">
                                    <div className={`w-10 h-10 rounded-full flex items-center justify-center font-black transition-all ${step >= s.num ? 'bg-ubLime text-black' : 'bg-white/5 text-gray-500'
                                        }`}>
                                        {step > s.num ? <CheckCheck size={20} /> : s.num}
                                    </div>
                                    <span className={`font-bold ${step >= s.num ? 'text-white' : 'text-gray-500'}`}>
                                        {s.label}
                                    </span>
                                </div>
                                {i < 2 && <div className={`flex-1 h-1 mx-4 rounded-full ${step > s.num ? 'bg-ubLime' : 'bg-white/5'}`} />}
                            </React.Fragment>
                        ))}
                    </div>
                </div>

                {/* Content */}
                <div className="p-8 max-h-[60vh] overflow-y-auto">
                    {step === 1 && (
                        <div className="space-y-6">
                            {/* Generation Mode */}
                            <div className="grid grid-cols-3 gap-4">
                                {[
                                    { id: 'manual', label: 'Manual Selection', icon: Users, desc: 'Pick specific participants' },
                                    { id: 'auto', label: 'Auto (Threshold)', icon: Zap, desc: 'Based on attendance %' },
                                    { id: 'bulk', label: 'Bulk Approve', icon: CheckCheck, desc: 'All eligible participants' }
                                ].map(mode => (
                                    <button
                                        key={mode.id}
                                        onClick={() => setGenerationMode(mode.id)}
                                        className={`p-6 rounded-2xl border-2 transition-all ${generationMode === mode.id
                                                ? 'bg-ubLime/10 border-ubLime'
                                                : 'bg-white/5 border-white/5 hover:border-white/20'
                                            }`}
                                    >
                                        <mode.icon size={24} className={generationMode === mode.id ? 'text-ubLime' : 'text-gray-400'} />
                                        <p className={`font-bold mt-3 ${generationMode === mode.id ? 'text-white' : 'text-gray-400'}`}>
                                            {mode.label}
                                        </p>
                                        <p className="text-xs text-gray-500 mt-1">{mode.desc}</p>
                                    </button>
                                ))}
                            </div>

                            {/* Filters */}
                            <div className="flex gap-3">
                                <div className="relative flex-1">
                                    <Search size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500" />
                                    <input
                                        type="text"
                                        placeholder="Search participants..."
                                        value={searchQuery}
                                        onChange={(e) => setSearchQuery(e.target.value)}
                                        className="w-full pl-12 pr-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white focus:outline-none focus:border-ubLime transition-colors"
                                    />
                                </div>
                                <select
                                    value={filterRole}
                                    onChange={(e) => setFilterRole(e.target.value)}
                                    className="px-4 py-3 bg-white/5 border border-white/10 rounded-xl text-white focus:outline-none appearance-none"
                                >
                                    <option value="all" className="bg-black">All Roles</option>
                                    <option value="Participant" className="bg-black">Participant</option>
                                    <option value="Winner" className="bg-black">Winner</option>
                                    <option value="Speaker" className="bg-black">Speaker</option>
                                </select>
                                <button
                                    onClick={handleSelectAll}
                                    className="px-6 py-3 bg-ubViolet/20 border border-ubViolet/30 rounded-xl text-ubViolet font-bold hover:bg-ubViolet/30 transition-all"
                                >
                                    {selectedParticipants.length === participants.filter(p => p.eligible).length ? 'Deselect All' : 'Select All Eligible'}
                                </button>
                            </div>

                            {/* Participants List */}
                            <div className="space-y-3">
                                {participants.map(participant => (
                                    <div
                                        key={participant.id}
                                        className={`p-4 rounded-2xl border-2 transition-all cursor-pointer ${selectedParticipants.find(p => p.id === participant.id)
                                                ? 'bg-ubLime/10 border-ubLime'
                                                : participant.eligible
                                                    ? 'bg-white/5 border-white/5 hover:border-white/20'
                                                    : 'bg-red-500/5 border-red-500/20 opacity-50 cursor-not-allowed'
                                            }`}
                                        onClick={() => participant.eligible && handleSelectParticipant(participant)}
                                    >
                                        <div className="flex items-center justify-between">
                                            <div className="flex items-center gap-4">
                                                <div className={`w-12 h-12 rounded-xl flex items-center justify-center font-black ${selectedParticipants.find(p => p.id === participant.id)
                                                        ? 'bg-ubLime text-black'
                                                        : 'bg-white/5 text-gray-400'
                                                    }`}>
                                                    {selectedParticipants.find(p => p.id === participant.id) ? (
                                                        <CheckCircle2 size={24} />
                                                    ) : (
                                                        participant.name.charAt(0)
                                                    )}
                                                </div>
                                                <div>
                                                    <p className="text-white font-bold">{participant.name}</p>
                                                    <p className="text-gray-400 text-sm">{participant.email}</p>
                                                </div>
                                            </div>
                                            <div className="flex items-center gap-6">
                                                <div className="text-right">
                                                    <p className="text-xs text-gray-500">Attendance</p>
                                                    <p className={`text-lg font-black ${participant.attendance >= 80 ? 'text-ubLime' : 'text-red-400'
                                                        }`}>
                                                        {participant.attendance}%
                                                    </p>
                                                </div>
                                                <div className="text-right">
                                                    <p className="text-xs text-gray-500">Sessions</p>
                                                    <p className="text-lg font-black text-cyan-400">
                                                        {participant.sessionsAttended}/{participant.totalSessions}
                                                    </p>
                                                </div>
                                                <div className="text-right">
                                                    <p className="text-xs text-gray-500">Role</p>
                                                    <span className={`px-3 py-1 rounded-full text-xs font-bold ${participant.role === 'Winner' ? 'bg-yellow-400/20 text-yellow-400' :
                                                            participant.role === 'Speaker' ? 'bg-ubViolet/20 text-ubViolet' :
                                                                'bg-cyan-400/20 text-cyan-400'
                                                        }`}>
                                                        {participant.role}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                ))}
                            </div>

                            <div className="p-4 bg-ubLime/10 border border-ubLime/30 rounded-2xl">
                                <p className="text-ubLime font-bold">
                                    {selectedParticipants.length} participant{selectedParticipants.length !== 1 ? 's' : ''} selected for certificate generation
                                </p>
                            </div>
                        </div>
                    )}

                    {step === 2 && (
                        <div className="space-y-6">
                            <div className="grid grid-cols-2 gap-6">
                                {selectedParticipants.slice(0, 2).map(participant => (
                                    <div key={participant.id}>
                                        <CertificatePreview participant={participant} />
                                    </div>
                                ))}
                            </div>
                            {selectedParticipants.length > 2 && (
                                <p className="text-center text-gray-400">
                                    + {selectedParticipants.length - 2} more certificate{selectedParticipants.length - 2 !== 1 ? 's' : ''} will be generated
                                </p>
                            )}
                        </div>
                    )}

                    {step === 3 && (
                        <div className="space-y-6">
                            <div className="text-center py-8">
                                <div className="w-24 h-24 bg-ubLime/20 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <CheckCircle2 size={48} className="text-ubLime" />
                                </div>
                                <h3 className="text-3xl font-black text-white mb-3">Certificates Generated! 🎉</h3>
                                <p className="text-gray-400 text-lg">
                                    {generatedCerts.length} certificate{generatedCerts.length !== 1 ? 's' : ''} generated with blockchain verification
                                </p>
                            </div>

                            <div className="space-y-3">
                                {generatedCerts.map(cert => (
                                    <div key={cert.id} className="p-6 bg-white/5 border border-white/5 rounded-2xl">
                                        <div className="flex items-start justify-between mb-4">
                                            <div>
                                                <p className="text-white font-bold text-lg">{cert.name}</p>
                                                <p className="text-gray-400 text-sm">{cert.email}</p>
                                            </div>
                                            <span className="px-3 py-1 bg-ubLime/20 text-ubLime rounded-full text-xs font-bold">
                                                ISSUED
                                            </span>
                                        </div>
                                        <div className="grid grid-cols-2 gap-4 mb-4">
                                            <div className="p-3 bg-black/40 rounded-xl">
                                                <p className="text-[10px] text-gray-500 uppercase mb-1">Certificate ID</p>
                                                <p className="text-sm font-mono text-cyan-400">{cert.certificateId}</p>
                                            </div>
                                            <div className="p-3 bg-black/40 rounded-xl">
                                                <p className="text-[10px] text-gray-500 uppercase mb-1">Blockchain Hash</p>
                                                <p className="text-sm font-mono text-cyan-400">{cert.blockchainHash}</p>
                                            </div>
                                        </div>
                                        <div className="flex gap-2">
                                            <button className="flex-1 px-4 py-2 bg-white/5 border border-white/10 rounded-xl text-white font-bold text-sm hover:bg-white/10 transition-all flex items-center justify-center gap-2">
                                                <Download size={16} />
                                                Download
                                            </button>
                                            <button className="flex-1 px-4 py-2 bg-white/5 border border-white/10 rounded-xl text-white font-bold text-sm hover:bg-white/10 transition-all flex items-center justify-center gap-2">
                                                <Mail size={16} />
                                                Email
                                            </button>
                                            <button className="flex-1 px-4 py-2 bg-[#0077B5]/20 border border-[#0077B5]/30 rounded-xl text-[#0077B5] font-bold text-sm hover:bg-[#0077B5]/30 transition-all flex items-center justify-center gap-2">
                                                <Linkedin size={16} />
                                                Share
                                            </button>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>
                    )}
                </div>

                {/* Footer */}
                <div className="p-8 border-t border-white/10 flex items-center justify-between">
                    <button
                        onClick={() => step > 1 ? setStep(step - 1) : onClose()}
                        className="px-6 py-3 bg-white/5 border border-white/10 rounded-xl text-white font-bold hover:bg-white/10 transition-all"
                    >
                        {step === 1 ? 'Cancel' : 'Back'}
                    </button>
                    {step < 3 && (
                        <button
                            onClick={() => step === 2 ? handleGenerate() : setStep(step + 1)}
                            disabled={step === 1 && selectedParticipants.length === 0}
                            className="px-8 py-3 bg-ubLime rounded-xl text-black font-bold hover:bg-ubLime/90 transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
                        >
                            {isGenerating ? (
                                <>
                                    <Clock size={20} className="animate-spin" />
                                    Generating...
                                </>
                            ) : step === 2 ? (
                                <>
                                    <Zap size={20} />
                                    Generate Certificates
                                </>
                            ) : (
                                <>
                                    Preview ({selectedParticipants.length})
                                    <Eye size={20} />
                                </>
                            )}
                        </button>
                    )}
                    {step === 3 && (
                        <button
                            onClick={onClose}
                            className="px-8 py-3 bg-ubLime rounded-xl text-black font-bold hover:bg-ubLime/90 transition-all"
                        >
                            Done
                        </button>
                    )}
                </div>
            </motion.div>
        </motion.div>
    );
};

export default CertificateGenerator;
