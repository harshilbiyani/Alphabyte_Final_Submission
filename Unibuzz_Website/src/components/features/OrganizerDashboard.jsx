import React, { useState, useRef, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import {
    Calendar, MapPin, Users, Target, ArrowRight, ArrowLeft,
    Upload, Star, Layout, Briefcase, Plus, CheckCircle2,
    BarChart3, Clock, Laptop, Trophy, Scissors, ExternalLink, Activity, Info, Trash2
} from 'lucide-react';
import Navbar from '../home/Navbar';
import CertificateManagement from './CertificateManagement';
import { useUser } from '../../context/UserContext';

const OrganizerDashboard = () => {
    const { addEvent, events, updateEventStatus, deleteEvent } = useUser();
    
    // Check for restoration data immediately to avoid flickering
    const getSavedState = () => {
        const view = localStorage.getItem('dashboard_view');
        const eventId = localStorage.getItem('dashboard_event_id');
        if (view === 'event-detail' && eventId) {
            const event = events.find(e => e.id === eventId);
            if (event) return { tab: 'event-detail', event };
        }
        return { tab: 'dashboard', event: null };
    };

    const savedState = getSavedState();
    const [activeTab, setActiveTab] = useState(savedState.tab);
    const [selectedEvent, setSelectedEvent] = useState(savedState.event);
    
    const [step, setStep] = useState(1);
    const [isSubmitted, setIsSubmitted] = useState(false);
    const [showOnSpotModal, setShowOnSpotModal] = useState(false);
    const [manualParticipant, setManualParticipant] = useState({ name: '', email: '', college: '' });
    const fileInputRef = useRef(null);

    // Clean up restoration data once used in state initialization
    useEffect(() => {
        if (activeTab === 'event-detail' && selectedEvent) {
            localStorage.removeItem('dashboard_view');
            localStorage.removeItem('dashboard_event_id');
        }
    }, []);

    // Form State
    const [eventData, setEventData] = useState({
        title: '',
        category: 'Hackathon',
        description: '',
        coverImage: null,
        startDate: '',
        startTime: '',
        endDate: '',
        endTime: '',
        isMultiDay: false,
        mode: 'In-person',
        venue: '',
        meetingLink: '',
        maxParticipants: '',
        regDeadline: '',
        prerequisites: '',
        isTeamEvent: false,
        teamSizeMin: 2,
        teamSizeMax: 4,
        teamFormation: 'Manual',
        skills: [],
        attendanceMethod: 'QR Code (Recommended)',
        isMultiSession: false,
        sessions: [''],
        certTemplate: 'Modern Template',
        minAttendance: 75,
        pointsReg: 5,
        pointsAttend: 20,
        pointsCert: 10,
        sponsorCoupon: '',
        couponValue: '₹200'
    });

    const categories = ['Hackathon', 'Workshop', 'Seminar', 'Cultural', 'Sports', 'Other'];
    const modes = ['In-person', 'Online', 'Hybrid'];
    const attendanceMethods = ['QR Code (Recommended)', 'Manual', 'RFID'];
    const templates = ['Modern Template', 'Classic Template', 'Minimalist Template'];

    const handleInputChange = (e) => {
        const { name, value, type, checked } = e.target;
        setEventData(prev => ({
            ...prev,
            [name]: type === 'checkbox' ? checked : value
        }));
    };

    const handleSkillAdd = (e) => {
        if (e.key === 'Enter' && e.target.value.trim()) {
            setEventData(prev => ({
                ...prev,
                skills: [...prev.skills, e.target.value.trim()]
            }));
            e.target.value = '';
        }
    };

    const removeSkill = (index) => {
        setEventData(prev => ({
            ...prev,
            skills: prev.skills.filter((_, i) => i !== index)
        }));
    };

    const triggerFileSelect = () => {
        fileInputRef.current.click();
    };

    const handleFileSelect = (e) => {
        const file = e.target.files[0];
        if (file) {
            setEventData(prev => ({ ...prev, coverImage: URL.createObjectURL(file) }));
        }
    };

    const validateStep = (currentStep) => {
        return true; // Validation disabled for demonstration
        /*
        if (currentStep === 1) {
            return eventData.title && eventData.category && eventData.description && eventData.coverImage;
        }
        if (currentStep === 2) {
            const hasDates = eventData.startDate && eventData.startTime && eventData.endDate && eventData.endTime;
            const hasLocation = eventData.mode === 'Online' ? eventData.meetingLink : eventData.venue;
            return hasDates && hasLocation;
        }
        if (currentStep === 3) {
            const isTeamValid = eventData.isTeamEvent 
                ? (Number(eventData.teamSizeMin) > 0 && Number(eventData.teamSizeMax) > 0 && Number(eventData.teamSizeMin) <= Number(eventData.teamSizeMax))
                : true;
            return eventData.maxParticipants && eventData.regDeadline && isTeamValid;
        }
        return true;
        */
    };

    const exportToCSV = (event) => {
        const headers = ["Name", "Email", "College", "Status"].join(",");
        const rows = event.participants.map(p => `${p.name},${p.email},${p.college},${p.status}`).join("\n");
        const blob = new Blob([`${headers}\n${rows}`], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.setAttribute('hidden', '');
        a.setAttribute('href', url);
        a.setAttribute('download', `${event.title.replace(/\s+/g, '_')}_participants.csv`);
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    };

    const generateReport = (event) => {
        const reportContent = `
            EVENT REPORT: ${event.title}
            -----------------------------
            Category: ${event.category}
            Mode: ${event.mode}
            Date: ${event.startDate} to ${event.endDate}
            Venue: ${event.venue || 'Online'}
            
            PARTICIPATION SUMMARY
            Total Registrations: ${event.participants.length}
            Confirmed Attendees: ${event.attendees}
            Completion Rate: ${((event.attendees / event.participants.length) * 100).toFixed(1)}%
            
            SKILLS IMPACT
            Main Skills: ${event.skills.join(", ") || 'General'}
            
            ADMINISTRATIVE
            Points Disbursed: ${event.pointsReg + event.pointsAttend + event.pointsCert} per student
            Certificates Issued: ${event.attendees >= (event.participants.length * event.minAttendance / 100) ? event.attendees : 'Pending'}
        `;
        const blob = new Blob([reportContent], { type: 'text/plain' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `${event.title}_Report.txt`;
        a.click();
    };

    const addOnSpotParticipant = (eventId) => {
        if (!manualParticipant.name || !manualParticipant.email) return;
        
        const newEntry = { ...manualParticipant, status: 'Registered' };
        // We'll update the user context directly if we had a proper action, 
        // for now let's mock the update to the selectedEvent state if it matches
        const userEvents = JSON.parse(localStorage.getItem('userEvents') || '[]');
        const updatedEvents = userEvents.map(ev => {
            if (ev.id === eventId) {
                return { ...ev, participants: [...ev.participants, newEntry] };
            }
            return ev;
        });
        localStorage.setItem('userEvents', JSON.stringify(updatedEvents));
        // Force refresh for demo purposes - in a real app this would be in Context
        window.location.reload(); 
    };

    const handleSubmit = () => {
        const newEvent = {
            ...eventData,
            id: Date.now(),
            status: 'Published',
            registrations: 0,
            attendees: 0,
            dateCreated: new Date().toLocaleDateString(),
            participants: [
                { name: 'John Doe', email: 'john@example.com', college: 'MIT', status: 'Registered' },
                { name: 'Jane Smith', email: 'jane@example.com', college: 'Stanford', status: 'Registered' }
            ]
        };
        addEvent(newEvent);
        setIsSubmitted(true);
    };

    const getStatusColor = (status) => {
        switch (status) {
            case 'Published': return 'bg-cyan-400/20 text-cyan-400';
            case 'Live': return 'bg-ubLime/20 text-ubLime';
            case 'Completed': return 'bg-ubViolet/20 text-ubViolet';
            case 'Archived': return 'bg-white/10 text-gray-400';
            default: return 'bg-white/10 text-gray-400';
        }
    };

    const handleStatusChange = (eventId, newStatus) => {
        updateEventStatus(eventId, newStatus);
        
        // Map status to catchy messages
        const messages = {
            'Live': 'Igniting Your Event... Going Live! 🚀',
            'Published': 'Syncing Event Details... 📡',
            'Completed': 'Wrapping Up... Generating Memories! ✨',
            'Archived': 'Archiving Event... Securing Data 🔒'
        };

        // Persist state for view recovery and custom splash screen
        localStorage.setItem('dashboard_view', 'event-detail');
        localStorage.setItem('dashboard_event_id', eventId);
        localStorage.setItem('refresh_message', messages[newStatus] || 'Updating Status...');

        window.location.reload();
    };

    const handleDeleteEvent = (eventId) => {
        if (window.confirm('CRITICAL ACTION: Are you sure you want to delete this event completely? This will remove all participant data, certificates, and metrics. This cannot be undone.')) {
            deleteEvent(eventId);
            setActiveTab('dashboard');
            setSelectedEvent(null);
            // Show a quick success message or just transition back
            alert('Event deleted successfully.');
        }
    };

    const renderEventDetail = (event) => (
        <div className="space-y-8">
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
                <div>
                    <button 
                        onClick={() => setActiveTab('dashboard')}
                        className="text-gray-400 hover:text-white flex items-center gap-2 font-bold mb-4"
                    >
                        <ArrowLeft size={18} /> Back to Dashboard
                    </button>
                    <div className="flex items-center gap-4 mb-2">
                        <h2 className="text-4xl font-black text-white">{event.title}</h2>
                        <span className={`px-4 py-1 rounded-full text-xs font-black uppercase tracking-tighter ${getStatusColor(event.status)}`}>
                            {event.status}
                        </span>
                    </div>
                    <p className="text-gray-400 font-medium flex items-center gap-4">
                        <span className="flex items-center gap-2"><Calendar size={16} /> {event.startDate}</span>
                        <span className="flex items-center gap-2"><MapPin size={16} /> {event.venue || event.mode}</span>
                    </p>
                </div>

                <div className="flex flex-wrap gap-4">
                    {event.status === 'Published' && (
                        <button 
                            onClick={() => handleStatusChange(event.id, 'Live')}
                            className="px-8 py-3 bg-ubLime text-black font-black rounded-xl hover:scale-105 transition-all shadow-[0_0_20px_rgba(198,255,51,0.3)]"
                        >
                            Go Live
                        </button>
                    )}
                    {event.status === 'Live' && (
                        <div className="flex gap-4">
                            <button 
                                onClick={() => handleStatusChange(event.id, 'Published')}
                                className="px-6 py-3 bg-white/5 text-gray-400 font-bold rounded-xl hover:bg-white/10 transition-all"
                            >
                                Back to Published
                            </button>
                            <button 
                                onClick={() => handleStatusChange(event.id, 'Completed')}
                                className="px-8 py-3 bg-ubViolet text-white font-black rounded-xl hover:scale-105 transition-all shadow-[0_0_20px_rgba(125,57,235,0.3)]"
                            >
                                Mark Completed
                            </button>
                        </div>
                    )}
                    {event.status === 'Completed' && (
                        <div className="flex gap-4">
                            <button 
                                onClick={() => handleStatusChange(event.id, 'Live')}
                                className="px-6 py-3 bg-white/5 text-gray-400 font-bold rounded-xl hover:bg-white/10 transition-all"
                            >
                                Back to Live
                            </button>
                            <button 
                                onClick={() => generateReport(event)}
                                className="px-8 py-3 bg-ubLime text-black font-black rounded-xl hover:scale-105 transition-all"
                            >
                                Download Report
                            </button>
                            <button 
                                onClick={() => handleStatusChange(event.id, 'Archived')}
                                className="px-8 py-3 bg-white/10 text-white font-black rounded-xl hover:bg-white/20 transition-all"
                            >
                                Archive Event
                            </button>
                        </div>
                    )}
                    {event.status === 'Archived' && (
                        <div className="flex gap-4">
                            <button 
                                onClick={() => handleStatusChange(event.id, 'Completed')}
                                className="px-6 py-3 bg-white/5 text-gray-400 font-bold rounded-xl hover:bg-white/10 transition-all"
                            >
                                Restore to Completed
                            </button>
                            <button 
                                onClick={() => generateReport(event)}
                                className="px-8 py-3 bg-ubLime text-black font-black rounded-xl hover:scale-105 transition-all"
                            >
                                Download Report
                            </button>
                            <button 
                                onClick={() => handleDeleteEvent(event.id)}
                                className="px-8 py-3 bg-red-500/10 text-red-500 border border-red-500/20 font-black rounded-xl hover:bg-red-500 hover:text-white transition-all flex items-center gap-2"
                            >
                                <Trash2 size={18} /> Delete Permanently
                            </button>
                        </div>
                    )}
                </div>
            </div>

            <AnimatePresence mode="wait">
                <motion.div
                    key={event.status}
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 1.05 }}
                    transition={{ duration: 0.4 }}
                >
                    {/* Quick Stats */}
                    <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
                        {[
                            { label: 'Total Registrations', value: event.participants.length, icon: Users, color: 'text-ubLime' },
                            { label: 'Confirmed Attendees', value: event.attendees, icon: CheckCircle2, color: 'text-ubViolet' },
                            { label: 'Avg. Skill Level', value: 'Intermediate', icon: Activity, color: 'text-cyan-400' },
                            { label: 'Days Remaining', value: event.status === 'Archived' ? '0' : '5', icon: Clock, color: 'text-yellow-400' },
                        ].map((stat, i) => (
                            <div key={i} className="bg-zinc-900/50 border border-white/5 p-6 rounded-3xl">
                                <stat.icon size={20} className={`${stat.color} mb-4`} />
                                <p className="text-gray-500 text-xs font-bold uppercase tracking-widest">{stat.label}</p>
                                <h4 className="text-3xl font-black text-white mt-1">{stat.value}</h4>
                            </div>
                        ))}
                    </div>
                </motion.div>
            </AnimatePresence>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
                {/* Participant List */}
                <div className="lg:col-span-2 bg-zinc-900/50 border border-white/5 p-8 rounded-[40px]">
                    <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 mb-6">
                        <h3 className="text-2xl font-black text-white">Participant Details</h3>
                        <div className="flex gap-3">
                            <button 
                                onClick={() => setShowOnSpotModal(true)}
                                className="px-4 py-2 bg-white/5 text-white text-xs font-bold rounded-xl border border-white/10 hover:border-ubLime transition-all flex items-center gap-2"
                            >
                                <Plus size={14} /> Add Manual
                            </button>
                            <button 
                                onClick={() => exportToCSV(event)}
                                className="px-4 py-2 bg-ubLime text-black text-xs font-bold rounded-xl hover:scale-105 transition-all flex items-center gap-2"
                            >
                                 Export CSV <ExternalLink size={14} />
                            </button>
                        </div>
                    </div>
                    <div className="overflow-x-auto">
                        <table className="w-full text-left">
                            <thead>
                                <tr className="text-gray-500 text-xs uppercase tracking-widest border-b border-white/10">
                                    <th className="pb-4 pr-4">Name</th>
                                    <th className="pb-4 pr-4">Email</th>
                                    <th className="pb-4 pr-4">College</th>
                                    <th className="pb-4">Status</th>
                                </tr>
                            </thead>
                            <tbody className="text-sm">
                                {event.participants.map((p, i) => (
                                    <tr key={i} className="border-b border-white/5">
                                        <td className="py-4 pr-4 text-white font-bold">{p.name}</td>
                                        <td className="py-4 pr-4 text-gray-400">{p.email}</td>
                                        <td className="py-4 pr-4 text-gray-400">{p.college}</td>
                                        <td className="py-4">
                                            <span className="px-3 py-1 bg-ubLime/10 text-ubLime text-[10px] font-black rounded-full uppercase">
                                                {p.status}
                                            </span>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>

                {/* Event Details Summary */}
                <div className="space-y-6">
                    <div className="bg-zinc-900/50 border border-white/10 p-8 rounded-[40px]">
                        <h3 className="text-xl font-bold text-white mb-6 flex items-center gap-2">
                            <Info size={20} className="text-ubViolet" /> Event Summary
                        </h3>
                        <div className="space-y-4">
                            {[
                                { label: 'Category', value: event.category },
                                { label: 'Mode', value: event.mode },
                                { label: 'Max Capacity', value: event.maxParticipants },
                                { label: 'Team Event', value: event.isTeamEvent ? 'Yes' : 'No' },
                                { label: 'Attendance', value: event.attendanceMethod }
                            ].map((detail, i) => (
                                <div key={i} className="flex justify-between items-center py-2 border-b border-white/5 last:border-0">
                                    <span className="text-gray-500 font-medium">{detail.label}</span>
                                    <span className="text-white font-bold">{detail.value}</span>
                                </div>
                            ))}
                        </div>
                    </div>

                    <div className="bg-ubViolet/20 border border-ubViolet/30 p-8 rounded-[40px]">
                        <h3 className="text-xl font-bold text-white mb-4">Engagement Insights</h3>
                        <p className="text-gray-400 text-sm mb-6 font-medium">Your event has seen a 12% increase in registrations over the last 24 hours.</p>
                        <div className="h-2 w-full bg-white/10 rounded-full overflow-hidden">
                            <div className="h-full bg-ubViolet w-3/4" />
                        </div>
                        <p className="mt-2 text-xs text-ubViolet font-bold uppercase tracking-widest text-right">75% Capacity Reached</p>
                    </div>
                </div>
            </div>

            {/* Danger Zone */}
            <div className="mt-12 pt-8 border-t border-red-500/20">
                <div className="bg-red-500/5 border border-red-500/10 p-8 rounded-[40px] flex flex-col md:flex-row items-center justify-between gap-6">
                    <div>
                        <h3 className="text-xl font-black text-red-500 mb-2">Danger Zone</h3>
                        <p className="text-gray-400 font-medium">Permanently remove this event and all associated data from UniBuzz.</p>
                    </div>
                    <button 
                        onClick={() => handleDeleteEvent(event.id)}
                        className="px-8 py-4 bg-red-500 text-white font-black rounded-2xl hover:bg-red-600 transition-all flex items-center gap-2 shadow-[0_0_20px_rgba(239,68,68,0.2)]"
                    >
                        <Trash2 size={20} /> Delete Event Completely
                    </button>
                </div>
            </div>
        </div>
    );

    const renderDashboard = () => (
        <div className="space-y-12">
            {/* Stats Overview */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                    { label: 'Total Events', value: events.length, icon: Calendar, color: 'text-ubLime' },
                    { label: 'Total Participants', value: events.reduce((acc, ev) => acc + ev.participants.length, 0), icon: Users, color: 'text-ubViolet' },
                    { label: 'Avg. Attendance', value: '88%', icon: BarChart3, color: 'text-cyan-400' },
                    { label: 'Certificates Issued', value: '840', icon: Trophy, color: 'text-yellow-400' },
                ].map((stat, i) => (
                    <motion.div
                        key={i}
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: i * 0.1 }}
                        className="bg-zinc-900/50 border border-white/5 p-6 rounded-3xl hover:border-white/10 transition-colors"
                    >
                        <div className={`w-12 h-12 rounded-2xl bg-white/5 flex items-center justify-center mb-4 ${stat.color}`}>
                            <stat.icon size={24} />
                        </div>
                        <p className="text-gray-400 text-sm font-medium uppercase tracking-wider">{stat.label}</p>
                        <h4 className="text-3xl font-black text-white mt-1">{stat.value}</h4>
                    </motion.div>
                ))}
            </div>

            {/* Active Events & Quick Actions */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <div className="bg-zinc-900/50 border border-white/5 p-8 rounded-3xl">
                    <h3 className="text-xl font-bold text-white mb-6">Published Events</h3>
                    <div className="space-y-4 max-h-[400px] overflow-y-auto pr-2 custom-scrollbar">
                        {events.filter(ev => ev.status !== 'Archived').length === 0 ? (
                             <div className="text-center py-10">
                                <p className="text-gray-500 font-bold mb-4">No active events yet.</p>
                                <button onClick={() => setActiveTab('create')} className="text-ubLime font-bold flex items-center gap-2 mx-auto">
                                    <Plus size={18} /> Create your first event
                                </button>
                             </div>
                        ) : (
                            events.filter(ev => ev.status !== 'Archived').map((event, i) => (
                                <div 
                                    key={i} 
                                    onClick={() => { setSelectedEvent(event); setActiveTab('event-detail'); }}
                                    className="flex items-center justify-between p-4 bg-white/5 rounded-2xl border border-transparent hover:border-ubLime transition-all cursor-pointer group"
                                >
                                    <div>
                                        <p className="text-white font-bold group-hover:text-ubLime transition-colors">{event.title}</p>
                                        <p className="text-gray-400 text-xs">{event.startDate} • {event.participants.length} signups</p>
                                    </div>
                                    <span className={`px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-tighter ${getStatusColor(event.status)}`}>
                                        {event.status}
                                    </span>
                                </div>
                            ))
                        )}
                    </div>
                </div>

                <div className="space-y-6">
                    <button
                        onClick={() => setActiveTab('create')}
                        className="w-full group p-8 bg-ubLime rounded-3xl flex items-center justify-between hover:scale-[1.02] transition-all"
                    >
                        <div className="text-left">
                            <h3 className="text-2xl font-black text-black">Create New Event</h3>
                            <p className="text-black/60 font-medium">Launch your next campus highlight</p>
                        </div>
                        <div className="w-16 h-16 bg-black rounded-2xl flex items-center justify-center group-hover:rotate-90 transition-transform">
                            <Plus size={32} className="text-ubLime" />
                        </div>
                    </button>

                    <button
                        onClick={() => setActiveTab('certificates')}
                        className="w-full group p-8 bg-gradient-to-br from-cyan-400/20 to-ubViolet/20 border border-cyan-400/30 rounded-3xl flex items-center justify-between hover:scale-[1.02] transition-all"
                    >
                        <div className="text-left">
                            <h3 className="text-2xl font-black text-white">Smart Certificates</h3>
                            <p className="text-gray-400 font-medium">Blockchain-verified digital certificates</p>
                        </div>
                        <div className="w-16 h-16 bg-cyan-400/20 rounded-2xl flex items-center justify-center group-hover:scale-110 transition-transform">
                            <Trophy size={32} className="text-cyan-400" />
                        </div>
                    </button>
                </div>
            </div>

            {/* Past/Archived Events */}
            <div className="bg-zinc-900/50 border border-white/5 p-8 rounded-3xl">
                <h3 className="text-xl font-bold text-white mb-6">Past Events (Archived)</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {events.filter(ev => ev.status === 'Archived').length === 0 ? (
                        <p className="text-gray-500 font-medium">No completed events yet.</p>
                    ) : (
                        events.filter(ev => ev.status === 'Archived').map((event, i) => (
                            <div 
                                key={i}
                                onClick={() => { setSelectedEvent(event); setActiveTab('event-detail'); }}
                                className="bg-white/5 p-6 rounded-2xl border border-transparent hover:border-ubViolet transition-all cursor-pointer"
                            >
                                <div className="flex justify-between items-start mb-4">
                                    <h4 className="text-lg font-bold text-white">{event.title}</h4>
                                    <span className="text-[10px] font-bold text-gray-500 uppercase tracking-widest">{event.startDate}</span>
                                </div>
                                <div className="flex items-center gap-4 text-sm text-gray-400">
                                    <span className="flex items-center gap-1"><Users size={14} /> {event.participants.length}</span>
                                    <span className="flex items-center gap-1"><Trophy size={14} /> 45 Certs</span>
                                </div>
                            </div>
                        ))
                    )}
                </div>
            </div>
        </div>
    );

    const renderStepper = () => {
        const stepProgress = (step / 5) * 100;

        return (
            <div className="max-w-4xl mx-auto">
                <div className="mb-12">
                    <div className="flex justify-between items-center mb-4">
                        <button
                            onClick={() => {
                                if (step === 1) setActiveTab('dashboard');
                                else setStep(step - 1);
                            }}
                            className="text-gray-400 hover:text-white flex items-center gap-2 font-bold px-4 py-2 hover:bg-white/5 rounded-xl transition-all"
                        >
                            <ArrowLeft size={20} /> Back
                        </button>
                        <div className="text-right">
                            <p className="text-xs font-bold text-gray-500 uppercase tracking-widest mb-1">Step {step} of 5</p>
                            <p className="text-lg font-black text-white">
                                {step === 1 && "Basic Details"}
                                {step === 2 && "Schedule & Location"}
                                {step === 3 && "Registration Settings"}
                                {step === 4 && "Certificates & Tracking"}
                                {step === 5 && "Review & Submit"}
                            </p>
                        </div>
                    </div>
                    <div className="h-2 w-full bg-white/5 rounded-full overflow-hidden">
                        <motion.div
                            initial={{ width: 0 }}
                            animate={{ width: `${stepProgress}%` }}
                            className="h-full bg-ubLime"
                        />
                    </div>
                </div>

                <AnimatePresence mode="wait">
                    <motion.div
                        key={step}
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        exit={{ opacity: 0, x: -20 }}
                        className="bg-zinc-900/50 border border-white/10 rounded-[40px] p-8 md:p-12"
                    >
                        {step === 1 && (
                            <div className="space-y-8">
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Event Title *</label>
                                        <input
                                            name="title"
                                            value={eventData.title}
                                            onChange={handleInputChange}
                                            placeholder="Enter a catchy title"
                                            className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors"
                                        />
                                    </div>
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Category *</label>
                                        <select
                                            name="category"
                                            value={eventData.category}
                                            onChange={handleInputChange}
                                            className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors appearance-none"
                                        >
                                            {categories.map(cat => <option key={cat} value={cat} className="bg-black">{cat}</option>)}
                                        </select>
                                    </div>
                                </div>

                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Description *</label>
                                    <div className="bg-white/5 border border-white/10 rounded-2xl overflow-hidden focus-within:border-ubLime transition-colors">
                                        <div className="p-3 border-b border-white/10 flex gap-4 bg-white/5">
                                            <button className="text-gray-400 hover:text-white font-bold">B</button>
                                            <button className="text-gray-400 hover:text-white italic">I</button>
                                            <button className="text-gray-400 hover:text-white underline">U</button>
                                            <div className="w-px h-6 bg-white/10 mx-2" />
                                            <button className="text-gray-400 hover:text-white">Link</button>
                                            <button className="text-gray-400 hover:text-white">Bullet</button>
                                        </div>
                                        <textarea
                                            name="description"
                                            value={eventData.description}
                                            onChange={handleInputChange}
                                            placeholder="Tell potential participants why they should join..."
                                            rows={6}
                                            className="w-full bg-transparent px-6 py-4 text-white focus:outline-none"
                                        />
                                    </div>
                                </div>

                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Cover Image *</label>
                                    <input 
                                        type="file" 
                                        className="hidden" 
                                        ref={fileInputRef} 
                                        onChange={handleFileSelect}
                                        accept="image/*"
                                    />
                                    <div 
                                        onClick={triggerFileSelect}
                                        className="border-2 border-dashed border-white/10 rounded-[32px] p-12 flex flex-col items-center justify-center hover:border-ubLime cursor-pointer transition-all group overflow-hidden relative"
                                    >
                                        {eventData.coverImage ? (
                                            <div className="absolute inset-0 w-full h-full">
                                                <img src={eventData.coverImage} className="w-full h-full object-cover opacity-40" alt="Cover" />
                                                <div className="absolute inset-0 flex items-center justify-center bg-black/40">
                                                     <p className="text-white font-bold">Change Image</p>
                                                </div>
                                            </div>
                                        ) : (
                                            <>
                                                <div className="w-16 h-16 bg-white/5 rounded-2xl flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
                                                    <Upload className="text-gray-400 group-hover:text-ubLime" />
                                                </div>
                                                <p className="text-white font-bold mb-1">Drag & drop or <span className="text-ubLime">click to upload</span></p>
                                                <p className="text-gray-500 text-sm">Max size: 5MB • JPG, PNG, WEBP</p>
                                            </>
                                        )}
                                    </div>
                                </div>
                            </div>
                        )}

                        {step === 2 && (
                            <div className="space-y-8">
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Start Date & Time *</label>
                                        <div className="flex gap-4">
                                            <input type="date" name="startDate" value={eventData.startDate} onChange={handleInputChange} className="flex-1 bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors" />
                                            <input type="time" name="startTime" value={eventData.startTime} onChange={handleInputChange} className="w-32 bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors" />
                                        </div>
                                    </div>
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">End Date & Time *</label>
                                        <div className="flex gap-4">
                                            <input type="date" name="endDate" value={eventData.endDate} onChange={handleInputChange} className="flex-1 bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors" />
                                            <input type="time" name="endTime" value={eventData.endTime} onChange={handleInputChange} className="w-32 bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors" />
                                        </div>
                                    </div>
                                </div>

                                <label className="flex items-center gap-3 cursor-pointer group">
                                    <input type="checkbox" name="isMultiDay" checked={eventData.isMultiDay} onChange={handleInputChange} className="w-5 h-5 rounded border-white/10 bg-white/5 checked:bg-ubLime" />
                                    <span className="text-gray-400 font-medium group-hover:text-white transition-colors">Multi-day event (multiple sessions)</span>
                                </label>

                                <div className="space-y-4">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Event Mode *</label>
                                    <div className="flex flex-wrap gap-4">
                                        {modes.map(m => (
                                            <button
                                                key={m}
                                                onClick={() => setEventData(prev => ({ ...prev, mode: m }))}
                                                className={`px-8 py-4 rounded-2xl font-bold flex items-center gap-3 transition-all ${eventData.mode === m ? 'bg-ubLime text-black' : 'bg-white/5 text-gray-400 hover:bg-white/10'
                                                    }`}
                                            >
                                                {m === 'In-person' && <MapPin size={18} />}
                                                {m === 'Online' && <Laptop size={18} />}
                                                {m === 'Hybrid' && <Layout size={18} />}
                                                {m}
                                            </button>
                                        ))}
                                    </div>
                                </div>

                                {eventData.mode !== 'Online' && (
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Venue / Location *</label>
                                        <input
                                            name="venue"
                                            value={eventData.venue}
                                            onChange={handleInputChange}
                                            placeholder="e.g. Building C, Innovation Lab"
                                            className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors"
                                        />
                                    </div>
                                )}

                                {(eventData.mode === 'Online' || eventData.mode === 'Hybrid') && (
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Meeting Link</label>
                                        <input
                                            name="meetingLink"
                                            value={eventData.meetingLink}
                                            onChange={handleInputChange}
                                            placeholder="https://meet.google.com/xxx"
                                            className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors"
                                        />
                                    </div>
                                )}
                            </div>
                        )}

                        {step === 3 && (
                            <div className="space-y-8">
                                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Maximum Participants *</label>
                                        <input
                                            type="number"
                                            name="maxParticipants"
                                            value={eventData.maxParticipants}
                                            onChange={handleInputChange}
                                            placeholder="120"
                                            className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors"
                                        />
                                    </div>
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Registration Deadline *</label>
                                        <input
                                            type="datetime-local"
                                            name="regDeadline"
                                            value={eventData.regDeadline}
                                            onChange={handleInputChange}
                                            className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors"
                                        />
                                    </div>
                                </div>

                                <div className="space-y-2">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Prerequisites (Optional)</label>
                                    <input
                                        name="prerequisites"
                                        value={eventData.prerequisites}
                                        onChange={handleInputChange}
                                        placeholder="e.g., Basic Python knowledge"
                                        className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors"
                                    />
                                </div>

                                <div className="p-6 bg-white/5 rounded-[32px] border border-white/5 space-y-6">
                                    <label className="flex items-center gap-3 cursor-pointer group">
                                        <input
                                            type="checkbox"
                                            name="isTeamEvent"
                                            checked={eventData.isTeamEvent}
                                            onChange={handleInputChange}
                                            className="w-5 h-5 rounded border-white/10 bg-white/10 checked:bg-ubViolet"
                                        />
                                        <span className="text-lg font-bold text-white">This is a team event</span>
                                    </label>

                                    {eventData.isTeamEvent && (
                                        <motion.div
                                            initial={{ height: 0, opacity: 0 }}
                                            animate={{ height: 'auto', opacity: 1 }}
                                            className="space-y-6 pt-4 border-t border-white/10 overflow-hidden"
                                        >
                                            <div className="grid grid-cols-2 gap-6">
                                                <div className="space-y-2">
                                                    <label className="text-xs font-bold text-gray-500 uppercase">Min Team Size</label>
                                                    <input type="number" name="teamSizeMin" value={eventData.teamSizeMin} onChange={handleInputChange} className="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white" />
                                                </div>
                                                <div className="space-y-2">
                                                    <label className="text-xs font-bold text-gray-500 uppercase">Max Team Size</label>
                                                    <input type="number" name="teamSizeMax" value={eventData.teamSizeMax} onChange={handleInputChange} className="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white" />
                                                </div>
                                            </div>
                                            <div className="flex gap-4">
                                                <button
                                                    onClick={() => setEventData(prev => ({ ...prev, teamFormation: 'Auto' }))}
                                                    className={`flex-1 py-3 rounded-xl font-bold transition-all ${eventData.teamFormation === 'Auto' ? 'bg-ubViolet text-white' : 'bg-white/5 text-gray-400'}`}
                                                >
                                                    Auto Team Formation
                                                </button>
                                                <button
                                                    onClick={() => setEventData(prev => ({ ...prev, teamFormation: 'Manual' }))}
                                                    className={`flex-1 py-3 rounded-xl font-bold transition-all ${eventData.teamFormation === 'Manual' ? 'bg-ubViolet text-white' : 'bg-white/5 text-gray-400'}`}
                                                >
                                                    Manual Only
                                                </button>
                                            </div>
                                        </motion.div>
                                    )}
                                </div>

                                <div className="space-y-4">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Skills Required (Optional)</label>
                                    <div className="flex flex-wrap gap-2 mb-4">
                                        {eventData.skills.map((skill, i) => (
                                            <span key={i} className="bg-ubLime/20 text-ubLime px-4 py-2 rounded-full text-sm font-bold flex items-center gap-2">
                                                {skill}
                                                <Scissors size={14} className="cursor-pointer rotate-90" onClick={() => removeSkill(i)} />
                                            </span>
                                        ))}
                                    </div>
                                    <input
                                        onKeyDown={handleSkillAdd}
                                        placeholder="Type skill and press Enter..."
                                        className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none focus:border-ubLime transition-colors"
                                    />
                                </div>
                            </div>
                        )}

                        {step === 4 && (
                            <div className="space-y-8">
                                <div className="space-y-4">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Attendance Tracking Method *</label>
                                    <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                                        {attendanceMethods.map(method => (
                                            <button
                                                key={method}
                                                onClick={() => setEventData(prev => ({ ...prev, attendanceMethod: method }))}
                                                className={`p-6 rounded-3xl border-2 font-bold transition-all flex flex-col items-center gap-3 ${eventData.attendanceMethod === method ? 'bg-ubLime/10 border-ubLime text-ubLime' : 'bg-white/5 border-white/5 text-gray-400 hover:border-white/20'
                                                    }`}
                                            >
                                                {method.includes('QR') ? <Layout size={24} /> : method.includes('Manual') ? <Users size={24} /> : <Briefcase size={24} />}
                                                <span className="text-sm">{method}</span>
                                            </button>
                                        ))}
                                    </div>
                                </div>

                                <div className="p-6 bg-white/5 rounded-[32px] border border-white/5 space-y-4">
                                    <label className="flex items-center gap-3 cursor-pointer group">
                                        <input type="checkbox" name="isMultiSession" checked={eventData.isMultiSession} onChange={handleInputChange} className="w-5 h-5 rounded border-white/10 bg-white/10 checked:bg-ubLime" />
                                        <span className="text-lg font-bold text-white">Multi-session event</span>
                                    </label>
                                    {eventData.isMultiSession && (
                                        <div className="space-y-3 pt-4 border-t border-white/5">
                                            {eventData.sessions.map((session, i) => (
                                                <input
                                                    key={i}
                                                    value={session}
                                                    onChange={(e) => {
                                                        const newSessions = [...eventData.sessions];
                                                        newSessions[i] = e.target.value;
                                                        setEventData(prev => ({ ...prev, sessions: newSessions }));
                                                    }}
                                                    placeholder={`Session ${i + 1}: e.g. Day 1 - Morning`}
                                                    className="w-full bg-black/40 border border-white/5 rounded-xl px-4 py-3 text-white text-sm"
                                                />
                                            ))}
                                            <button
                                                onClick={() => setEventData(prev => ({ ...prev, sessions: [...prev.sessions, ''] }))}
                                                className="text-ubLime text-sm font-bold flex items-center gap-2 hover:gap-3 transition-all"
                                            >
                                                <Plus size={16} /> Add Session
                                            </button>
                                        </div>
                                    )}
                                </div>

                                <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div className="space-y-4">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Certificate Template *</label>
                                        <select
                                            name="certTemplate"
                                            value={eventData.certTemplate}
                                            onChange={handleInputChange}
                                            className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none appearance-none"
                                        >
                                            {templates.map(t => <option key={t} value={t} className="bg-black">{t}</option>)}
                                        </select>
                                        <button className="text-ubViolet text-xs font-bold uppercase tracking-widest hover:underline">Preview Template</button>
                                    </div>
                                    <div className="space-y-4">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Min Attendance for Certificate</label>
                                        <div className="relative">
                                            <input
                                                type="number"
                                                name="minAttendance"
                                                value={eventData.minAttendance}
                                                onChange={handleInputChange}
                                                className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white focus:outline-none"
                                            />
                                            <span className="absolute right-6 top-1/2 -translate-y-1/2 text-gray-500 font-bold">%</span>
                                        </div>
                                    </div>
                                </div>

                                <div className="space-y-4">
                                    <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Points Awarded *</label>
                                    <div className="grid grid-cols-3 gap-4">
                                        {[
                                            { name: 'pointsReg', label: 'Registration' },
                                            { name: 'pointsAttend', label: 'Attendance' },
                                            { name: 'pointsCert', label: 'Certificate' }
                                        ].map(p => (
                                            <div key={p.name} className="space-y-2">
                                                <p className="text-[10px] font-bold text-gray-500 uppercase">{p.label}</p>
                                                <input type="number" name={p.name} value={eventData[p.name]} onChange={handleInputChange} className="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white text-center font-bold" />
                                            </div>
                                        ))}
                                    </div>
                                </div>

                                <div className="grid grid-cols-2 gap-8">
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Sponsor Coupon (Optional)</label>
                                        <select className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white appearance-none">
                                            <option className="bg-black">Select Sponsor</option>
                                            <option className="bg-black">Starbucks</option>
                                            <option className="bg-black">Zomato</option>
                                        </select>
                                    </div>
                                    <div className="space-y-2">
                                        <label className="text-xs font-bold text-gray-400 uppercase tracking-widest">Coupon Value</label>
                                        <input value={eventData.couponValue} readOnly className="w-full bg-white/5 border border-white/10 rounded-2xl px-6 py-4 text-white" />
                                    </div>
                                </div>
                            </div>
                        )}

                        {step === 5 && (
                            <div className="space-y-8">
                                <h3 className="text-3xl font-black text-white">Review Your Event</h3>

                                <div className="space-y-6">
                                    <div className="p-6 bg-white/5 rounded-3xl border border-white/5">
                                        <div className="grid grid-cols-1 md:grid-cols-2 gap-y-4 gap-x-12">
                                            {[
                                                { label: 'Event Title', val: eventData.title || 'AI Hackathon 2025' },
                                                { label: 'Category', val: eventData.category },
                                                { label: 'Date', val: `${eventData.startDate || 'March 15'} - ${eventData.endDate || '16, 2025'}` },
                                                { label: 'Location', val: eventData.venue || 'Building C, Innovation Lab' },
                                                { label: 'Max Participants', val: eventData.maxParticipants || '120' },
                                                { label: 'Deadline', val: eventData.regDeadline || 'March 10, 2025' },
                                                { label: 'Team Event', val: eventData.isTeamEvent ? `Yes (${eventData.teamSizeMin}-${eventData.teamSizeMax} members)` : 'No' },
                                                { label: 'Attendance', val: eventData.attendanceMethod },
                                                { label: 'Certificate', val: eventData.certTemplate },
                                                { label: 'Points', val: `${eventData.pointsReg} (Reg) + ${eventData.pointsAttend} (Attend) + ${eventData.pointsCert} (Cert)` }
                                            ].map((item, i) => (
                                                <div key={i} className="flex flex-col">
                                                    <span className="text-[10px] font-bold text-gray-500 uppercase tracking-widest">{item.label}</span>
                                                    <span className="text-white font-medium">{item.val}</span>
                                                </div>
                                            ))}
                                        </div>
                                    </div>

                                    <div className="flex flex-col gap-4">
                                        <label className="flex items-center gap-4 p-6 bg-ubLime/10 rounded-3xl border border-ubLime/30 cursor-pointer hover:bg-ubLime/20 transition-all">
                                            <input type="radio" name="submitType" defaultChecked className="w-5 h-5 accent-ubLime" />
                                            <div>
                                                <p className="text-ubLime font-bold">Publish Directly</p>
                                                <p className="text-ubLime/60 text-xs">Your event will be immediately visible to students and sponsors.</p>
                                            </div>
                                        </label>
                                        <label className="flex items-center gap-4 p-6 bg-white/5 rounded-3xl border border-white/10 cursor-pointer hover:border-ubViolet transition-all">
                                            <input type="radio" name="submitType" className="w-5 h-5 accent-ubViolet" />
                                            <div>
                                                <p className="text-white font-bold">Save as Draft</p>
                                                <p className="text-gray-500 text-xs">Come back later and finish editing.</p>
                                            </div>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        )}

                        <div className="mt-12 flex justify-center">
                            {step < 5 ? (
                                <button
                                    onClick={() => {
                                        if (validateStep(step)) {
                                            setStep(step + 1);
                                        } else {
                                            if (step === 3) {
                                                if (!eventData.maxParticipants) alert("Please enter Max Participants.");
                                                else if (!eventData.regDeadline) alert("Please enter Registration Deadline.");
                                                else if (eventData.isTeamEvent) {
                                                    const min = Number(eventData.teamSizeMin);
                                                    const max = Number(eventData.teamSizeMax);
                                                    if (min <= 0 || max <= 0) alert("Team sizes must be positive numbers.");
                                                    else if (min > max) alert("Min team size cannot be greater than max team size.");
                                                    else alert("Please check all required fields.");
                                                }
                                                else alert("Please check all required fields.");
                                            } else {
                                                alert("Please fill in all required fields marked with * before proceeding.");
                                            }
                                        }
                                    }}
                                    className={`px-12 py-5 rounded-2xl text-black font-black text-xl transition-all flex items-center gap-3 ${
                                        validateStep(step) 
                                        ? 'bg-ubLime hover:scale-105 shadow-[0_0_30px_rgba(198,255,51,0.3)]' 
                                        : 'bg-gray-600 cursor-not-allowed opacity-50'
                                    }`}
                                >
                                    Next: {step === 1 ? 'Schedule' : step === 2 ? 'Registration' : step === 3 ? 'Certificates' : 'Review'} <ArrowRight size={20} />
                                </button>
                            ) : (
                                <button
                                    onClick={handleSubmit}
                                    className="px-20 py-6 bg-ubLime rounded-3xl text-black font-black text-2xl hover:scale-105 transition-all shadow-[0_0_50px_rgba(198,255,51,0.5)] flex items-center gap-3"
                                >
                                    Publish Event <ArrowRight size={24} />
                                </button>
                            )}
                        </div>
                    </motion.div>
                </AnimatePresence>
            </div>
        );
    };

    return (
        <div className="min-h-screen bg-black text-white font-sans selection:bg-ubLime selection:text-black pb-20">
            <Navbar />

            {/* On-Spot Registration Modal */}
            <AnimatePresence>
                {showOnSpotModal && (
                    <motion.div 
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="fixed inset-0 z-[110] flex items-center justify-center px-6 bg-black/90 backdrop-blur-md"
                    >
                        <motion.div 
                            initial={{ scale: 0.9, y: 20 }}
                            animate={{ scale: 1, y: 0 }}
                            className="bg-zinc-900 border border-white/10 p-8 rounded-[40px] max-w-md w-full"
                        >
                            <h3 className="text-2xl font-black text-white mb-6">Manual Registration</h3>
                            <div className="space-y-4 mb-8">
                                <div className="space-y-1">
                                    <label className="text-[10px] font-bold text-gray-500 uppercase">Full Name</label>
                                    <input 
                                        value={manualParticipant.name}
                                        onChange={(e) => setManualParticipant({...manualParticipant, name: e.target.value})}
                                        className="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white focus:border-ubLime outline-none" 
                                    />
                                </div>
                                <div className="space-y-1">
                                    <label className="text-[10px] font-bold text-gray-500 uppercase">Email Address</label>
                                    <input 
                                        type="email"
                                        value={manualParticipant.email}
                                        onChange={(e) => setManualParticipant({...manualParticipant, email: e.target.value})}
                                        className="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white focus:border-ubLime outline-none" 
                                    />
                                </div>
                                <div className="space-y-1">
                                    <label className="text-[10px] font-bold text-gray-500 uppercase">College/Organization</label>
                                    <input 
                                        value={manualParticipant.college}
                                        onChange={(e) => setManualParticipant({...manualParticipant, college: e.target.value})}
                                        className="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white focus:border-ubLime outline-none" 
                                    />
                                </div>
                            </div>
                            <div className="flex gap-4">
                                <button 
                                    onClick={() => setShowOnSpotModal(false)}
                                    className="flex-1 py-4 text-gray-400 font-bold hover:text-white transition-all"
                                >
                                    Cancel
                                </button>
                                <button 
                                    onClick={() => addOnSpotParticipant(selectedEvent?.id)}
                                    className="flex-1 py-4 bg-ubLime text-black font-black rounded-2xl hover:scale-105 transition-all"
                                >
                                    Register
                                </button>
                            </div>
                        </motion.div>
                    </motion.div>
                )}
            </AnimatePresence>

            <div className="pt-32 px-6 md:px-12 max-w-7xl mx-auto">
                <motion.div
                    initial={{ opacity: 0, y: 30 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="mb-12"
                >
                    <h1 className="text-5xl md:text-6xl font-black mb-4">
                        {activeTab === 'dashboard' ? 'Organizer' : 
                         activeTab === 'event-detail' ? (selectedEvent?.title?.split(' ')[0] || 'Event') :
                         activeTab === 'certificates' ? 'Smart' : 'Create'} 
                        <span className="text-transparent bg-clip-text bg-gradient-to-r from-ubLime to-ubViolet ml-3">
                            {activeTab === 'dashboard' ? 'Dashboard' : 
                             activeTab === 'event-detail' ? 'Engine' : 
                             activeTab === 'certificates' ? 'Certificates' : 'Event'}
                        </span>
                    </h1>
                    <p className="text-xl text-gray-400 font-medium">
                        {activeTab === 'dashboard'
                            ? 'Manage your campus footprint and event metrics.'
                            : activeTab === 'event-detail'
                                ? `Live Lifecycle: ${selectedEvent?.title || 'Manage your event metrics'}`
                                : activeTab === 'certificates'
                                    ? 'Issue and manage blockchain-verified certificates.'
                                    : 'Fill in the details below to launch your event.'}
                    </p>
                </motion.div>

                {activeTab === 'dashboard' ? renderDashboard() :
                    activeTab === 'event-detail' ? renderEventDetail(selectedEvent || events[0]) :
                        activeTab === 'certificates' ? <CertificateManagement isEmbedded={true} /> :
                            renderStepper()}
            </div>

            {/* Success Modal */}
            <AnimatePresence>
                {isSubmitted && (
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="fixed inset-0 z-[100] flex items-center justify-center px-6 bg-black/90 backdrop-blur-xl"
                    >
                        <motion.div
                            initial={{ scale: 0.9, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            className="bg-zinc-900 border border-white/10 p-12 rounded-[48px] max-w-lg w-full text-center relative overflow-hidden"
                        >
                            <div className="absolute top-0 left-0 w-full h-2 bg-ubLime" />
                            <div className="w-24 h-24 bg-ubLime/20 rounded-full flex items-center justify-center mx-auto mb-8">
                                <CheckCircle2 size={48} className="text-ubLime" />
                            </div>
                            <h2 className="text-4xl font-black text-white mb-4">Event Published! 🎉</h2>
                            <p className="text-gray-400 text-lg mb-10">
                                Your event is now live and visible to the community.
                            </p>
                            <div className="flex flex-col gap-4">
                                <button
                                    onClick={() => { setIsSubmitted(false); setActiveTab('dashboard'); setStep(1); }}
                                    className="w-full py-5 bg-ubLime rounded-2xl text-black font-black text-lg hover:bg-ubWhite transition-all"
                                >
                                    Return to Dashboard
                                </button>
                                <button
                                    onClick={() => { setIsSubmitted(false); setStep(1); setActiveTab('create'); }}
                                    className="w-full py-5 bg-white/5 rounded-2xl text-white font-bold text-lg hover:bg-white/10 transition-all"
                                >
                                    Create Another Event
                                </button>
                            </div>
                        </motion.div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
};

export default OrganizerDashboard;
